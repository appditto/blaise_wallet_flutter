import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:mobx/mobx.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:logger/logger.dart';

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

  @action
  Future<void> initializeRpc() async {
    this.rpcClient =
        RPCClient(rpcAddress: await sl.get<SharedPrefsUtil>().getRpcUrl());
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
        b58Pubkey: PublicKeyCoder().encodeToBase58(this.publicKey), max: 10);
    RPCResponse resp = await this.rpcClient.makeRpcRequest(findAccountsRequest);
    if (resp.isError) {
      ErrorResponse err = resp;
      log.d("findaccounts returned error ${err.errorMessage}");
      return false;
    }
    AccountsResponse accountsResponse = resp;
    this.walletAccounts = accountsResponse.accounts;
    Currency totalBalance = Currency('0');
    this.walletAccounts.forEach((acct) {
      totalBalance += acct.balance;
    });
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
  bool shouldHaveFee() {
    for (Account accountState in accountStateMap.values) {
      if (accountState.operations.indexWhere((operation) => operation.maturation == null && operation.fee == NO_FEE) > -1) {
        return true;
      }
    }
    return false;
  }

  @action
  void reset() {
    // Reset all properties (for when logging out, etc)
    this.walletLoading = true;
    this.totalWalletBalance = Currency('0');
    this.rpcClient = null;
    this.walletAccounts = [];
    this.publicKey = null;
    this.accountStateMap = Map();
  }
}
