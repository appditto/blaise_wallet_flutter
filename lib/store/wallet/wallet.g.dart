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
    _$walletLoadingAtom.context.enforceReadPolicy(_$walletLoadingAtom);
    _$walletLoadingAtom.reportObserved();
    return super.walletLoading;
  }

  @override
  set walletLoading(bool value) {
    _$walletLoadingAtom.context.conditionallyRunInAction(() {
      super.walletLoading = value;
      _$walletLoadingAtom.reportChanged();
    }, _$walletLoadingAtom, name: '${_$walletLoadingAtom.name}_set');
  }

  final _$totalWalletBalanceAtom = Atom(name: 'WalletBase.totalWalletBalance');

  @override
  Currency get totalWalletBalance {
    _$totalWalletBalanceAtom.context
        .enforceReadPolicy(_$totalWalletBalanceAtom);
    _$totalWalletBalanceAtom.reportObserved();
    return super.totalWalletBalance;
  }

  @override
  set totalWalletBalance(Currency value) {
    _$totalWalletBalanceAtom.context.conditionallyRunInAction(() {
      super.totalWalletBalance = value;
      _$totalWalletBalanceAtom.reportChanged();
    }, _$totalWalletBalanceAtom, name: '${_$totalWalletBalanceAtom.name}_set');
  }

  final _$walletAccountsAtom = Atom(name: 'WalletBase.walletAccounts');

  @override
  List<PascalAccount> get walletAccounts {
    _$walletAccountsAtom.context.enforceReadPolicy(_$walletAccountsAtom);
    _$walletAccountsAtom.reportObserved();
    return super.walletAccounts;
  }

  @override
  set walletAccounts(List<PascalAccount> value) {
    _$walletAccountsAtom.context.conditionallyRunInAction(() {
      super.walletAccounts = value;
      _$walletAccountsAtom.reportChanged();
    }, _$walletAccountsAtom, name: '${_$walletAccountsAtom.name}_set');
  }

  final _$rpcClientAtom = Atom(name: 'WalletBase.rpcClient');

  @override
  RPCClient get rpcClient {
    _$rpcClientAtom.context.enforceReadPolicy(_$rpcClientAtom);
    _$rpcClientAtom.reportObserved();
    return super.rpcClient;
  }

  @override
  set rpcClient(RPCClient value) {
    _$rpcClientAtom.context.conditionallyRunInAction(() {
      super.rpcClient = value;
      _$rpcClientAtom.reportChanged();
    }, _$rpcClientAtom, name: '${_$rpcClientAtom.name}_set');
  }

  final _$publicKeyAtom = Atom(name: 'WalletBase.publicKey');

  @override
  PublicKey get publicKey {
    _$publicKeyAtom.context.enforceReadPolicy(_$publicKeyAtom);
    _$publicKeyAtom.reportObserved();
    return super.publicKey;
  }

  @override
  set publicKey(PublicKey value) {
    _$publicKeyAtom.context.conditionallyRunInAction(() {
      super.publicKey = value;
      _$publicKeyAtom.reportChanged();
    }, _$publicKeyAtom, name: '${_$publicKeyAtom.name}_set');
  }

  final _$accountStateMapAtom = Atom(name: 'WalletBase.accountStateMap');

  @override
  Map<int, Account> get accountStateMap {
    _$accountStateMapAtom.context.enforceReadPolicy(_$accountStateMapAtom);
    _$accountStateMapAtom.reportObserved();
    return super.accountStateMap;
  }

  @override
  set accountStateMap(Map<int, Account> value) {
    _$accountStateMapAtom.context.conditionallyRunInAction(() {
      super.accountStateMap = value;
      _$accountStateMapAtom.reportChanged();
    }, _$accountStateMapAtom, name: '${_$accountStateMapAtom.name}_set');
  }

  final _$usdPriceAtom = Atom(name: 'WalletBase.usdPrice');

  @override
  double get usdPrice {
    _$usdPriceAtom.context.enforceReadPolicy(_$usdPriceAtom);
    _$usdPriceAtom.reportObserved();
    return super.usdPrice;
  }

  @override
  set usdPrice(double value) {
    _$usdPriceAtom.context.conditionallyRunInAction(() {
      super.usdPrice = value;
      _$usdPriceAtom.reportChanged();
    }, _$usdPriceAtom, name: '${_$usdPriceAtom.name}_set');
  }

  final _$localCurrencyPriceAtom = Atom(name: 'WalletBase.localCurrencyPrice');

  @override
  double get localCurrencyPrice {
    _$localCurrencyPriceAtom.context
        .enforceReadPolicy(_$localCurrencyPriceAtom);
    _$localCurrencyPriceAtom.reportObserved();
    return super.localCurrencyPrice;
  }

  @override
  set localCurrencyPrice(double value) {
    _$localCurrencyPriceAtom.context.conditionallyRunInAction(() {
      super.localCurrencyPrice = value;
      _$localCurrencyPriceAtom.reportChanged();
    }, _$localCurrencyPriceAtom, name: '${_$localCurrencyPriceAtom.name}_set');
  }

  final _$btcPriceAtom = Atom(name: 'WalletBase.btcPrice');

  @override
  double get btcPrice {
    _$btcPriceAtom.context.enforceReadPolicy(_$btcPriceAtom);
    _$btcPriceAtom.reportObserved();
    return super.btcPrice;
  }

  @override
  set btcPrice(double value) {
    _$btcPriceAtom.context.conditionallyRunInAction(() {
      super.btcPrice = value;
      _$btcPriceAtom.reportChanged();
    }, _$btcPriceAtom, name: '${_$btcPriceAtom.name}_set');
  }

  final _$uuidAtom = Atom(name: 'WalletBase.uuid');

  @override
  String get uuid {
    _$uuidAtom.context.enforceReadPolicy(_$uuidAtom);
    _$uuidAtom.reportObserved();
    return super.uuid;
  }

  @override
  set uuid(String value) {
    _$uuidAtom.context.conditionallyRunInAction(() {
      super.uuid = value;
      _$uuidAtom.reportChanged();
    }, _$uuidAtom, name: '${_$uuidAtom.name}_set');
  }

  final _$updatePriceDataAsyncAction = AsyncAction('updatePriceData');

  @override
  Future<void> updatePriceData() {
    return _$updatePriceDataAsyncAction.run(() => super.updatePriceData());
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
  void removeAccount(PascalAccount account) {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.removeAccount(account);
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateAccountName(PascalAccount account, AccountName newName) {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.updateAccountName(account, newName);
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<PascalAccount> getNonzeroBalanceAccounts() {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.getNonzeroBalanceAccounts();
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool shouldHaveFee() {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.shouldHaveFee();
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String totalBalanceUsd() {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.totalBalanceUsd();
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
