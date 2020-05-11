// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

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

  final _$activeAccountAtom = Atom(name: 'WalletBase.activeAccount');

  @override
  AccountNumber get activeAccount {
    _$activeAccountAtom.context.enforceReadPolicy(_$activeAccountAtom);
    _$activeAccountAtom.reportObserved();
    return super.activeAccount;
  }

  @override
  set activeAccount(AccountNumber value) {
    _$activeAccountAtom.context.conditionallyRunInAction(() {
      super.activeAccount = value;
      _$activeAccountAtom.reportChanged();
    }, _$activeAccountAtom, name: '${_$activeAccountAtom.name}_set');
  }

  final _$borrowedAccountAtom = Atom(name: 'WalletBase.borrowedAccount');

  @override
  BorrowResponse get borrowedAccount {
    _$borrowedAccountAtom.context.enforceReadPolicy(_$borrowedAccountAtom);
    _$borrowedAccountAtom.reportObserved();
    return super.borrowedAccount;
  }

  @override
  set borrowedAccount(BorrowResponse value) {
    _$borrowedAccountAtom.context.conditionallyRunInAction(() {
      super.borrowedAccount = value;
      _$borrowedAccountAtom.reportChanged();
    }, _$borrowedAccountAtom, name: '${_$borrowedAccountAtom.name}_set');
  }

  final _$isBorrowEligibleAtom = Atom(name: 'WalletBase.isBorrowEligible');

  @override
  bool get isBorrowEligible {
    _$isBorrowEligibleAtom.context.enforceReadPolicy(_$isBorrowEligibleAtom);
    _$isBorrowEligibleAtom.reportObserved();
    return super.isBorrowEligible;
  }

  @override
  set isBorrowEligible(bool value) {
    _$isBorrowEligibleAtom.context.conditionallyRunInAction(() {
      super.isBorrowEligible = value;
      _$isBorrowEligibleAtom.reportChanged();
    }, _$isBorrowEligibleAtom, name: '${_$isBorrowEligibleAtom.name}_set');
  }

  final _$hasExceededBorrowLimitAtom =
      Atom(name: 'WalletBase.hasExceededBorrowLimit');

  @override
  bool get hasExceededBorrowLimit {
    _$hasExceededBorrowLimitAtom.context
        .enforceReadPolicy(_$hasExceededBorrowLimitAtom);
    _$hasExceededBorrowLimitAtom.reportObserved();
    return super.hasExceededBorrowLimit;
  }

  @override
  set hasExceededBorrowLimit(bool value) {
    _$hasExceededBorrowLimitAtom.context.conditionallyRunInAction(() {
      super.hasExceededBorrowLimit = value;
      _$hasExceededBorrowLimitAtom.reportChanged();
    }, _$hasExceededBorrowLimitAtom,
        name: '${_$hasExceededBorrowLimitAtom.name}_set');
  }

  final _$hasReceivedSubscribeResponseAtom =
      Atom(name: 'WalletBase.hasReceivedSubscribeResponse');

  @override
  bool get hasReceivedSubscribeResponse {
    _$hasReceivedSubscribeResponseAtom.context
        .enforceReadPolicy(_$hasReceivedSubscribeResponseAtom);
    _$hasReceivedSubscribeResponseAtom.reportObserved();
    return super.hasReceivedSubscribeResponse;
  }

  @override
  set hasReceivedSubscribeResponse(bool value) {
    _$hasReceivedSubscribeResponseAtom.context.conditionallyRunInAction(() {
      super.hasReceivedSubscribeResponse = value;
      _$hasReceivedSubscribeResponseAtom.reportChanged();
    }, _$hasReceivedSubscribeResponseAtom,
        name: '${_$hasReceivedSubscribeResponseAtom.name}_set');
  }

  final _$initializeRpcAsyncAction = AsyncAction('initializeRpc');

  @override
  Future<void> initializeRpc() {
    return _$initializeRpcAsyncAction.run(() => super.initializeRpc());
  }

  final _$getBalanceAndInsertBorrowedAsyncAction =
      AsyncAction('getBalanceAndInsertBorrowed');

  @override
  Future<dynamic> getBalanceAndInsertBorrowed() {
    return _$getBalanceAndInsertBorrowedAsyncAction
        .run(() => super.getBalanceAndInsertBorrowed());
  }

  final _$updateBorrowedAsyncAction = AsyncAction('updateBorrowed');

  @override
  Future<dynamic> updateBorrowed() {
    return _$updateBorrowedAsyncAction.run(() => super.updateBorrowed());
  }

  final _$initiateBorrowAsyncAction = AsyncAction('initiateBorrow');

  @override
  Future<dynamic> initiateBorrow() {
    return _$initiateBorrowAsyncAction.run(() => super.initiateBorrow());
  }

  final _$findAccountsRequestAsyncAction = AsyncAction('findAccountsRequest');

  @override
  Future<RPCResponse> findAccountsRequest(FindAccountsRequest request) {
    return _$findAccountsRequestAsyncAction
        .run(() => super.findAccountsRequest(request));
  }

  final _$findAccountsWithNameLikeAsyncAction =
      AsyncAction('findAccountsWithNameLike');

  @override
  Future<List<PascalAccount>> findAccountsWithNameLike(String name) {
    return _$findAccountsWithNameLikeAsyncAction
        .run(() => super.findAccountsWithNameLike(name));
  }

  final _$loadWalletAsyncAction = AsyncAction('loadWallet');

  @override
  Future<bool> loadWallet() {
    return _$loadWalletAsyncAction.run(() => super.loadWallet());
  }

  final _$requestUpdateAsyncAction = AsyncAction('requestUpdate');

  @override
  Future<void> requestUpdate() {
    return _$requestUpdateAsyncAction.run(() => super.requestUpdate());
  }

  final _$fcmUpdateAsyncAction = AsyncAction('fcmUpdate');

  @override
  Future<void> fcmUpdate(AccountNumber account) {
    return _$fcmUpdateAsyncAction.run(() => super.fcmUpdate(account));
  }

  final _$fcmDeleteAccountAsyncAction = AsyncAction('fcmDeleteAccount');

  @override
  Future<void> fcmDeleteAccount(AccountNumber account) {
    return _$fcmDeleteAccountAsyncAction
        .run(() => super.fcmDeleteAccount(account));
  }

  final _$fcmUpdateBulkAsyncAction = AsyncAction('fcmUpdateBulk');

  @override
  Future<void> fcmUpdateBulk({bool forceDisable = false}) {
    return _$fcmUpdateBulkAsyncAction
        .run(() => super.fcmUpdateBulk(forceDisable: forceDisable));
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
  String getLocalCurrencyDisplay(
      {AvailableCurrency currency, Currency amount, int decimalDigits}) {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.getLocalCurrencyDisplay(
          currency: currency, amount: amount, decimalDigits: decimalDigits);
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disconnect() {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.disconnect();
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reconnect() {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.reconnect();
    } finally {
      _$WalletBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewOp(PascalOperation op) {
    final _$actionInfo = _$WalletBaseActionController.startAction();
    try {
      return super.addNewOp(op);
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

  @override
  String toString() {
    final string =
        'walletLoading: ${walletLoading.toString()},totalWalletBalance: ${totalWalletBalance.toString()},walletAccounts: ${walletAccounts.toString()},rpcClient: ${rpcClient.toString()},publicKey: ${publicKey.toString()},accountStateMap: ${accountStateMap.toString()},localCurrencyPrice: ${localCurrencyPrice.toString()},btcPrice: ${btcPrice.toString()},uuid: ${uuid.toString()},activeAccount: ${activeAccount.toString()},borrowedAccount: ${borrowedAccount.toString()},isBorrowEligible: ${isBorrowEligible.toString()},hasExceededBorrowLimit: ${hasExceededBorrowLimit.toString()},hasReceivedSubscribeResponse: ${hasReceivedSubscribeResponse.toString()}';
    return '{$string}';
  }
}
