import 'dart:ui';

import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/network/http_client.dart';
import 'package:blaise_wallet_flutter/network/model/request/fcm_delete_account_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/fcm_update_bulk_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/fcm_update_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/subscribe_request.dart';
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

  Logger log = Logger();

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

  @action
  Future<void> initializeRpc() async {
    this.rpcClient =
        RPCClient(rpcAddress: await sl.get<SharedPrefsUtil>().getRpcUrl());
  }

  @action
  Future<void> getBalanceAndInsertBorrowed() async {
    if (borrowedAccount != null && !this.walletAccounts.contains(borrowedAccount)) {
      RPCResponse resp = await rpcClient.makeRpcRequest(GetAccountRequest(account: borrowedAccount.account.account));
      if (resp is PascalAccount) {
        resp.isBorrowed = true;
        this.walletAccounts.removeWhere((acct) => acct.account == borrowedAccount.account);
        this.walletAccounts.add(resp);
      }
    }
  }

  @action
  Future<void> updateBorrowed() async {
    BorrowResponse resp = await HttpAPI.getBorrowed(PublicKeyCoder().encodeToBase58(this.publicKey));
    if (resp == null) {
      isBorrowEligible = false;
    } else if (resp.account == null) {
      isBorrowEligible = true;
      borrowedAccount = null;
    } else {
      isBorrowEligible = false;
      borrowedAccount = resp;
      await this.getBalanceAndInsertBorrowed();
    }
  }

  @action
  Future<void> initiateBorrow() async {
    if (isBorrowEligible) {
      BorrowResponse resp = await HttpAPI.borrowAccount(PublicKeyCoder().encodeToBase58(this.publicKey));
      if (resp == null) {
        isBorrowEligible = false;
      } else {
        isBorrowEligible = false;
        borrowedAccount = resp;
        await this.getBalanceAndInsertBorrowed();
      }      
    }
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
    RPCResponse resp = await this.rpcClient.makeRpcRequest(findAccountsRequest);
    if (resp.isError) {
      ErrorResponse err = resp;
      log.d("findaccounts returned error ${err.errorMessage}");
      return false;
    }
    AccountsResponse accountsResponse = resp;
    PascalAccount borrowedAccount = this.walletAccounts.firstWhere((acct) => acct.isBorrowed, orElse: () => null);
    if (borrowedAccount != null && !accountsResponse.accounts.contains(borrowedAccount)) {
      accountsResponse.accounts.add(borrowedAccount);
    }
    this.walletAccounts = accountsResponse.accounts;
    Currency totalBalance = Currency('0');
    this.walletAccounts.forEach((acct) {
      totalBalance += acct.balance;
    });
    this.updateBorrowed();
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
    switch (currency.getLocale().countryCode) {
      case "VE":
        return NumberFormat.currency(locale: currency.getLocale().toString(), name: currency.getIso4217Code(), symbol: "Bs.S", decimalDigits: 4).format(converted.toDouble());
      case "TR":
        return NumberFormat.currency(locale:currency.getLocale().toString(), name: currency.getIso4217Code(), symbol: "₺", decimalDigits: decimalDigits).format(converted.toDouble());
      default:
        return NumberFormat.currency(locale:currency.getLocale().toString(), name: currency.getIso4217Code(), symbol: currency.getCurrencySymbol(), decimalDigits: decimalDigits).format(converted.toDouble());
    }
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
    String uuid = await sl.get<SharedPrefsUtil>().getUuid();
    AvailableCurrency curCurrency = await sl.get<SharedPrefsUtil>().getCurrency(Locale("en", "US"));
    String fcmToken = await FirebaseMessaging().getToken();
    bool notificationsEnabled = await sl.get<SharedPrefsUtil>().getNotificationsOn();
    sl.get<WSClient>().clearQueue();
    sl.get<WSClient>().queueRequest(SubscribeRequest(currency:curCurrency.getIso4217Code(), uuid:uuid, account: this.activeAccount == null ? null : this.activeAccount.account, fcmToken: fcmToken, notificationEnabled: notificationsEnabled));
    sl.get<WSClient>().processQueue();
  }

  @action
  Future<void> fcmUpdate(AccountNumber account) async {
    bool enabled = await sl.get<SharedPrefsUtil>().getNotificationsOn();
    String fcmToken = await FirebaseMessaging().getToken();
    sl.get<WSClient>().sendRequest(FcmUpdateRequest(account: account.account, enabled: enabled, fcmToken: fcmToken));
  }

  @action
  Future<void> fcmDeleteAccount(AccountNumber account) async {
    String fcmToken = await FirebaseMessaging().getToken();
    sl.get<WSClient>().sendRequest(FcmDeleteAccountRequest(account: account.account, fcmToken: fcmToken));
  }

  @action
  Future<void> fcmUpdateBulk({bool forceDisable = false}) async {
    if (walletLoading) {
      return;
    }
    bool enabled = forceDisable ? false : await sl.get<SharedPrefsUtil>().getNotificationsOn();
    String fcmToken = await FirebaseMessaging().getToken();
    List<int> accounts = [];
    for (PascalAccount acct in walletAccounts) {
      accounts.add(acct.account.account);
    }
    sl.get<WSClient>().sendRequest(FcmUpdateBulkRequest(accounts: accounts, enabled: enabled, fcmToken: fcmToken));
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
  }
}
