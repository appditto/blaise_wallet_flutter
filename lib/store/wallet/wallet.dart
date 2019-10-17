import 'dart:convert';
import 'dart:ui';

import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/network/http_client.dart';
import 'package:blaise_wallet_flutter/network/model/request/fcm_delete_account_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/fcm_update_bulk_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/fcm_update_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/subscribe_request.dart';
import 'package:blaise_wallet_flutter/network/model/response/accounts_response_borrowed.dart';
import 'package:blaise_wallet_flutter/network/model/response/borrow_response.dart';
import 'package:blaise_wallet_flutter/network/model/response/subscribe_response.dart';
import 'package:blaise_wallet_flutter/network/ws_client.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobx/mobx.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

part 'wallet.g.dart';

class Wallet = WalletBase with _$Wallet;

/// The global wallet state and mutation actions
abstract class WalletBase with Store {
  final Currency NO_FEE = Currency('0');
  final Currency MIN_FEE = Currency('0.0001');

  final Logger log = sl.get<Logger>();

  @observable
  bool walletLoading = true;

  @observable
  Currency totalWalletBalance = Currency('0');

  @observable
  List<PascalAccount> walletAccounts = [];

  @observable
  RPCClient rpcClient;

  @observable
  PublicKey publicKey;

  @observable
  Map<int, Account> accountStateMap = Map();

  @observable
  double localCurrencyPrice;
  @observable
  double btcPrice;

  @observable
  String uuid;

  @observable
  AccountNumber activeAccount;

  @observable
  BorrowResponse borrowedAccount;

  @observable
  bool isBorrowEligible = false;

  @observable
  bool hasExceededBorrowLimit = false;

  @observable
  bool hasReceivedSubscribeResponse = false;

  @action
  Future<void> initializeRpc() async {
    this.rpcClient =
        RPCClient(rpcAddress: await sl.get<SharedPrefsUtil>().getRpcUrl());
  }

  @action
  Future<dynamic> getBalanceAndInsertBorrowed() async {
    if (borrowedAccount != null && !this.walletAccounts.contains(borrowedAccount.account)) {
      RPCResponse resp = await rpcClient.makeRpcRequest(GetAccountRequest(account: borrowedAccount.account.account));
      if (resp is PascalAccount) {
        resp.isBorrowed = true;
        this.walletAccounts.removeWhere((acct) => acct.account == borrowedAccount.account);
        this.walletAccounts.add(resp);
        return resp;
      }
    }
    return null;
  }

  @action
  Future<dynamic> updateBorrowed() async {
    BorrowResponse resp = await HttpAPI.getBorrowed(PublicKeyCoder().encodeToBase58(this.publicKey));
    if (resp == null) {
      isBorrowEligible = false;
    } else if (resp.account == null) {
      isBorrowEligible = true;
      borrowedAccount = null;
    } else {
      isBorrowEligible = false;
      borrowedAccount = resp;
      return await this.getBalanceAndInsertBorrowed();
    }
    return null;
  }

  @action
  Future<dynamic> initiateBorrow() async {
    if (isBorrowEligible) {
      BorrowResponse resp = await HttpAPI.borrowAccount(PublicKeyCoder().encodeToBase58(this.publicKey));
      if (resp == null) {
        isBorrowEligible = false;
      } else {
        isBorrowEligible = false;
        borrowedAccount = resp;
        return await this.getBalanceAndInsertBorrowed();
      }      
    }
    return null;
  }

  @action
  Future<RPCResponse> findAccountsRequest(FindAccountsRequest request) async {
    /// This custom request includes borrowed accounts
    request.id = this.rpcClient.id;
    String responseJson = await this.rpcClient.rpcPost(request.toJson());
    if (responseJson == null) {
      throw Exception('Did not receive a response');
    }
    // Parse base response
    BaseResponse resp = BaseResponse.fromJson(json.decode(responseJson));
    // Determine if error response
    if (resp is Map &&
        resp.result.containsKey('code') &&
        resp.result.containsKey('message')) {
      return ErrorResponse.fromJson(resp.result);
    }
    // Determine correct response type
    return AccountsResponseBorrowed.fromJson(json.decode(responseJson));
  }

  @action
  Future<List<PascalAccount>> findAccountsWithNameLike(String name) async {
    // TODO - this RPC request is broken when exact is set to false
    FindAccountsRequest findAccountsRequest = FindAccountsRequest(
      name: name,
      exact: true
    );
    RPCResponse resp = await this.rpcClient.makeRpcRequest(findAccountsRequest);
    if (resp.isError) {
      ErrorResponse err = resp;
      log.d("findaccounts returned error ${err.errorMessage}");
      return null;      
    }
    AccountsResponse accountsResponse = resp;
    return accountsResponse.accounts;
  }

  @action
  Future<bool> loadWallet() async {
    if (this.publicKey == null) {
      PrivateKey privKey = PrivateKeyCoder().decodeFromBytes(
          PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey()));
      this.publicKey = Keys.fromPrivateKey(privKey).publicKey;
    }

    /// Load the initial wallet, returns false if it loaded with an error
    if (this.rpcClient == null) {
      await initializeRpc();
    }
    // Get total balance and list of accounts
    // TODO - pagination?
    FindAccountsRequest findAccountsRequest = FindAccountsRequest(
        b58Pubkey: PublicKeyCoder().encodeToBase58(this.publicKey), max: 25);
    RPCResponse resp = await this.findAccountsRequest(findAccountsRequest);
    if (resp.isError) {
      ErrorResponse err = resp;
      log.d("findaccounts returned error ${err.errorMessage}");
      return false;
    }
    AccountsResponseBorrowed accountsResponse = resp;
    bool hasCustomDaemon = (await sl.get<SharedPrefsUtil>().getRpcUrl()) != AppConstants.DEFAULT_RPC_HTTP_URL;
    if (hasCustomDaemon) {
      PascalAccount borrowedAccount = this.walletAccounts.firstWhere((acct) => acct.isBorrowed, orElse: () => null);
      if (borrowedAccount != null && !accountsResponse.accounts.contains(borrowedAccount)) {
        accountsResponse.accounts.add(borrowedAccount);
      }
    } else if (accountsResponse.borrowedAccount != null) {
      accountsResponse.accounts.where((acct) => acct.account == accountsResponse.borrowedAccount.account).forEach((acct) {
        acct.isBorrowed = true;
      });
      this.borrowedAccount = accountsResponse.borrowedAccount;
      this.isBorrowEligible = false;
    } else if (accountsResponse.borrowedAccount == null) {
      this.isBorrowEligible = true;
      this.borrowedAccount = null;
    }
    if (accountsResponse.borrowEligible != null) {
      this.hasExceededBorrowLimit = !accountsResponse.borrowEligible;
    }
    // Check for freepasa account
    AccountNumber freepasaAccount = await sl.get<SharedPrefsUtil>().getFreepasaAccount();
    if (freepasaAccount != null) {
      PascalAccount fpasaAccount = PascalAccount(
        account: freepasaAccount,
        balance: Currency('0'),
        isFreepasa: true
      );
      fpasaAccount.name = AccountName("");
      if (!accountsResponse.accounts.contains(fpasaAccount)) {
        accountsResponse.accounts.add(fpasaAccount);
      }
    } 
    this.walletAccounts = accountsResponse.accounts;
    Currency totalBalance = Currency('0');
    this.walletAccounts.forEach((acct) {
      totalBalance += acct.balance;
    });
    if (hasCustomDaemon) { 
      this.updateBorrowed();
    }
    this.totalWalletBalance = totalBalance;
    this.walletLoading = false;
    return true;
  }

  @action
  Account getAccountState(PascalAccount account) {
    accountStateMap.putIfAbsent(account.account.account, () => Account(rpcClient: this.rpcClient, account: account));
    return accountStateMap[account.account.account];
  }
  
  @action
  void changeRpcUrl(String rpcUrl) {
    this.rpcClient = RPCClient(rpcAddress: rpcUrl);
    accountStateMap.forEach((k, v) {
      v.rpcClient = this.rpcClient;
    });
  }

  @action
  void removeAccount(PascalAccount account) {
    // Remove account from wallet
    this.totalWalletBalance -= account.balance;
    this.walletAccounts.removeWhere((acct) => acct == account);
    this.accountStateMap.remove(account.account.account);
    this.fcmDeleteAccount(account.account);
  }

  @action
  void updateAccountName(PascalAccount account, AccountName newName) {
    this.walletAccounts.where((acct) => acct.account == account.account).forEach((pa) {
      pa.name = newName;
    });
    if (this.accountStateMap.containsKey(account.account.account)) {
      this.accountStateMap[account.account.account].account.name = newName;
    }
  }

  @action
  List<PascalAccount> getNonzeroBalanceAccounts() {
    if (walletLoading || walletAccounts.length == 0) {
      return [];
    }
    List<PascalAccount> ret = [];
    walletAccounts.forEach((acct) {
      if (acct.balance > Currency('0')) {
        ret.add(acct);
      }
    });
    return ret;
  }

  @action
  bool shouldHaveFee() {
    for (Account accountState in accountStateMap.values) {
      if (accountState.operations == null) {
        continue;
      }
      if (accountState.operations.indexWhere((operation) => operation.maturation == null && operation.fee == NO_FEE && operation.signerAccount == accountState.account.account) > -1) {
        return true;
      }
    }
    return false;
  }

  @action
  String getLocalCurrencyDisplay({AvailableCurrency currency, Currency amount, int decimalDigits}) {
    if (localCurrencyPrice == null) {
      return null;
    }
    currency = currency ?? AvailableCurrency(AvailableCurrencyEnum.USD);
    Decimal converted = Decimal.parse(localCurrencyPrice.toString()) * Decimal.parse(amount.toStringOpt());
    return NumberFormat.currency(locale:currency.getLocale().toString(), name: currency.getIso4217Code(), symbol: currency.getCurrencySymbol(), decimalDigits: decimalDigits).format(converted.toDouble());
  }

  /// Websocket Actions
  // Websocket Methods
  @action
  void disconnect() {
    sl.get<WSClient>().reset(suspend: true);
  }

  @action
  void reconnect() {
    sl.get<WSClient>().initCommunication(unsuspend: true);
  }

  @action
  Future<void> requestUpdate() async {
    if (this.publicKey == null) {
      PrivateKey privKey = PrivateKeyCoder().decodeFromBytes(
          PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey()));
      this.publicKey = Keys.fromPrivateKey(privKey).publicKey;
    }
    String uuid = await sl.get<SharedPrefsUtil>().getUuid();
    AvailableCurrency curCurrency = await sl.get<SharedPrefsUtil>().getCurrency(Locale("en", "US"));
    String fcmToken = await FirebaseMessaging().getToken();
    bool notificationsEnabled = await sl.get<SharedPrefsUtil>().getNotificationsOn();
    sl.get<WSClient>().clearQueue();
    sl.get<WSClient>().queueRequest(SubscribeRequest(currency:curCurrency.getIso4217Code(), uuid:uuid, account: this.activeAccount == null ? null : this.activeAccount.account, fcmToken: fcmToken, notificationEnabled: notificationsEnabled, b58pubkey: PublicKeyCoder().encodeToBase58(this.publicKey)));
    sl.get<WSClient>().processQueue();
  }

  @action
  Future<void> fcmUpdate(AccountNumber account) async {
    if (this.publicKey == null) {
      PrivateKey privKey = PrivateKeyCoder().decodeFromBytes(
          PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey()));
      this.publicKey = Keys.fromPrivateKey(privKey).publicKey;
    }
    bool enabled = await sl.get<SharedPrefsUtil>().getNotificationsOn();
    String fcmToken = await FirebaseMessaging().getToken();
    sl.get<WSClient>().sendRequest(FcmUpdateRequest(account: account.account, enabled: enabled, fcmToken: fcmToken, b58pubkey: PublicKeyCoder().encodeToBase58(this.publicKey)));
  }

  @action
  Future<void> fcmDeleteAccount(AccountNumber account) async {
    String fcmToken = await FirebaseMessaging().getToken();
    sl.get<WSClient>().sendRequest(FcmDeleteAccountRequest(account: account.account, fcmToken: fcmToken));
  }

  @action
  Future<void> fcmUpdateBulk({bool forceDisable = false}) async {
    if (this.publicKey == null) {
      PrivateKey privKey = PrivateKeyCoder().decodeFromBytes(
          PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey()));
      this.publicKey = Keys.fromPrivateKey(privKey).publicKey;
    }
    if (walletLoading) {
      return;
    }
    bool enabled = forceDisable ? false : await sl.get<SharedPrefsUtil>().getNotificationsOn();
    String fcmToken = await FirebaseMessaging().getToken();
    List<int> accounts = [];
    for (PascalAccount acct in walletAccounts) {
      if (!acct.isBorrowed) {
        accounts.add(acct.account.account);
      }
    }
    sl.get<WSClient>().sendRequest(FcmUpdateBulkRequest(accounts: accounts, enabled: enabled, fcmToken: fcmToken, b58pubkey: PublicKeyCoder().encodeToBase58(this.publicKey)));
  }

  @action
  void addNewOp(PascalOperation op) {
    this.accountStateMap.forEach((k, acct) {
      if (op.senders.isNotEmpty && op.senders[0].sendingAccount == acct.account.account) {
        acct.addNewOperation(op);
      } else if (op.receivers.isNotEmpty && op.receivers[0].receivingAccount == acct.account.account) {
        acct.addNewOperation(op);
      }
    });
  }

  @action
  void reset() {
    // Reset all properties (for when logging out, etc)
    this.fcmUpdateBulk(forceDisable: true);
    this.walletLoading = true;
    this.totalWalletBalance = Currency('0');
    this.rpcClient = null;
    this.walletAccounts = [];
    this.publicKey = null;
    this.accountStateMap = Map();
    this.borrowedAccount = null;
    this.isBorrowEligible = false;
    this.hasExceededBorrowLimit = false;
  }
}