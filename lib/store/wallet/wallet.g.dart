// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Wallet on WalletBase, Store {
  final _$walletLoadingAtom = Atom(name: 'WalletBase.walletLoading');

  @override
  bool get walletLoading {
    _$walletLoadingAtom.reportObserved();
    return super.walletLoading;
  }

  @override
  set walletLoading(bool value) {
    _$walletLoadingAtom.context
        .checkIfStateModificationsAreAllowed(_$walletLoadingAtom);
    super.walletLoading = value;
    _$walletLoadingAtom.reportChanged();
  }

  final _$totalWalletBalanceAtom = Atom(name: 'WalletBase.totalWalletBalance');

  @override
  Currency get totalWalletBalance {
    _$totalWalletBalanceAtom.reportObserved();
    return super.totalWalletBalance;
  }

  @override
  set totalWalletBalance(Currency value) {
    _$totalWalletBalanceAtom.context
        .checkIfStateModificationsAreAllowed(_$totalWalletBalanceAtom);
    super.totalWalletBalance = value;
    _$totalWalletBalanceAtom.reportChanged();
  }

  final _$walletAccountsAtom = Atom(name: 'WalletBase.walletAccounts');

  @override
  List<PascalAccount> get walletAccounts {
    _$walletAccountsAtom.reportObserved();
    return super.walletAccounts;
  }

  @override
  set walletAccounts(List<PascalAccount> value) {
    _$walletAccountsAtom.context
        .checkIfStateModificationsAreAllowed(_$walletAccountsAtom);
    super.walletAccounts = value;
    _$walletAccountsAtom.reportChanged();
  }

  final _$rpcClientAtom = Atom(name: 'WalletBase.rpcClient');

  @override
  RPCClient get rpcClient {
    _$rpcClientAtom.reportObserved();
    return super.rpcClient;
  }

  @override
  set rpcClient(RPCClient value) {
    _$rpcClientAtom.context
        .checkIfStateModificationsAreAllowed(_$rpcClientAtom);
    super.rpcClient = value;
    _$rpcClientAtom.reportChanged();
  }

  final _$publicKeyAtom = Atom(name: 'WalletBase.publicKey');

  @override
  PublicKey get publicKey {
    _$publicKeyAtom.reportObserved();
    return super.publicKey;
  }

  @override
  set publicKey(PublicKey value) {
    _$publicKeyAtom.context
        .checkIfStateModificationsAreAllowed(_$publicKeyAtom);
    super.publicKey = value;
    _$publicKeyAtom.reportChanged();
  }

  final _$accountStateMapAtom = Atom(name: 'WalletBase.accountStateMap');

  @override
  Map<int, Account> get accountStateMap {
    _$accountStateMapAtom.reportObserved();
    return super.accountStateMap;
  }

  @override
  set accountStateMap(Map<int, Account> value) {
    _$accountStateMapAtom.context
        .checkIfStateModificationsAreAllowed(_$accountStateMapAtom);
    super.accountStateMap = value;
    _$accountStateMapAtom.reportChanged();
  }

  final _$initializeRpcAsyncAction = AsyncAction('initializeRpc');

  @override
  Future<void> initializeRpc() {
    return _$initializeRpcAsyncAction.run(() => super.initializeRpc());
  }

  final _$loadWalletAsyncAction = AsyncAction('loadWallet');

  @override
  Future<bool> loadWallet() {
    return _$loadWalletAsyncAction.run(() => super.loadWallet());
  }

  final _$WalletBaseActionController = ActionController(name: 'WalletBase');

  @override
  Account getAccountState(PascalAccount account) {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.getAccountState(account);
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeRpcUrl(String rpcUrl) {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.changeRpcUrl(rpcUrl);
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }
}
