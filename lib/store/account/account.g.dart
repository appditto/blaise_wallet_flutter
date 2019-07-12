// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$Account on AccountBase, Store {
  final _$operationsLoadingAtom = Atom(name: 'AccountBase.operationsLoading');

  @override
  bool get operationsLoading {
    _$operationsLoadingAtom.context.enforceReadPolicy(_$operationsLoadingAtom);
    _$operationsLoadingAtom.reportObserved();
    return super.operationsLoading;
  }

  @override
  set operationsLoading(bool value) {
    _$operationsLoadingAtom.context.conditionallyRunInAction(() {
      super.operationsLoading = value;
      _$operationsLoadingAtom.reportChanged();
    }, _$operationsLoadingAtom, name: '${_$operationsLoadingAtom.name}_set');
  }

  final _$rpcClientAtom = Atom(name: 'AccountBase.rpcClient');

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

  final _$accountAtom = Atom(name: 'AccountBase.account');

  @override
  PascalAccount get account {
    _$accountAtom.context.enforceReadPolicy(_$accountAtom);
    _$accountAtom.reportObserved();
    return super.account;
  }

  @override
  set account(PascalAccount value) {
    _$accountAtom.context.conditionallyRunInAction(() {
      super.account = value;
      _$accountAtom.reportChanged();
    }, _$accountAtom, name: '${_$accountAtom.name}_set');
  }

  final _$accountBalanceAtom = Atom(name: 'AccountBase.accountBalance');

  @override
  Currency get accountBalance {
    _$accountBalanceAtom.context.enforceReadPolicy(_$accountBalanceAtom);
    _$accountBalanceAtom.reportObserved();
    return super.accountBalance;
  }

  @override
  set accountBalance(Currency value) {
    _$accountBalanceAtom.context.conditionallyRunInAction(() {
      super.accountBalance = value;
      _$accountBalanceAtom.reportChanged();
    }, _$accountBalanceAtom, name: '${_$accountBalanceAtom.name}_set');
  }

  final _$operationsAtom = Atom(name: 'AccountBase.operations');

  @override
  List<PascalOperation> get operations {
    _$operationsAtom.context.enforceReadPolicy(_$operationsAtom);
    _$operationsAtom.reportObserved();
    return super.operations;
  }

  @override
  set operations(List<PascalOperation> value) {
    _$operationsAtom.context.conditionallyRunInAction(() {
      super.operations = value;
      _$operationsAtom.reportChanged();
    }, _$operationsAtom, name: '${_$operationsAtom.name}_set');
  }

  final _$operationsToDisplayAtom =
      Atom(name: 'AccountBase.operationsToDisplay');

  @override
  List<PascalOperation> get operationsToDisplay {
    _$operationsToDisplayAtom.context
        .enforceReadPolicy(_$operationsToDisplayAtom);
    _$operationsToDisplayAtom.reportObserved();
    return super.operationsToDisplay;
  }

  @override
  set operationsToDisplay(List<PascalOperation> value) {
    _$operationsToDisplayAtom.context.conditionallyRunInAction(() {
      super.operationsToDisplay = value;
      _$operationsToDisplayAtom.reportChanged();
    }, _$operationsToDisplayAtom,
        name: '${_$operationsToDisplayAtom.name}_set');
  }

  final _$updateAccountAsyncAction = AsyncAction('updateAccount');

  @override
  Future<bool> updateAccount() {
    return _$updateAccountAsyncAction.run(() => super.updateAccount());
  }

  final _$getAccountOperationsAsyncAction = AsyncAction('getAccountOperations');

  @override
  Future<void> getAccountOperations() {
    return _$getAccountOperationsAsyncAction
        .run(() => super.getAccountOperations());
  }

  final _$doSendAsyncAction = AsyncAction('doSend');

  @override
  Future<RPCResponse> doSend(
      {String amount, String destination, Currency fee, String payload = ""}) {
    return _$doSendAsyncAction.run(() => super.doSend(
        amount: amount, destination: destination, fee: fee, payload: payload));
  }

  final _$transferAccountAsyncAction = AsyncAction('transferAccount');

  @override
  Future<RPCResponse> transferAccount(String strPubkey, {Currency fee}) {
    return _$transferAccountAsyncAction
        .run(() => super.transferAccount(strPubkey, fee: fee));
  }

  final _$changeAccountNameAsyncAction = AsyncAction('changeAccountName');

  @override
  Future<RPCResponse> changeAccountName(AccountName newName, {Currency fee}) {
    return _$changeAccountNameAsyncAction
        .run(() => super.changeAccountName(newName, fee: fee));
  }

  final _$AccountBaseActionController = ActionController(name: 'AccountBase');

  @override
  void decrementBalance(Currency delta) {
    final _$actionInfo = _$AccountBaseActionController.startAction();
    try {
      return super.decrementBalance(delta);
    } finally {
      _$AccountBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementBalance(Currency delta) {
    final _$actionInfo = _$AccountBaseActionController.startAction();
    try {
      return super.incrementBalance(delta);
    } finally {
      _$AccountBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<PascalOperation> getOperationsToDisplay() {
    final _$actionInfo = _$AccountBaseActionController.startAction();
    try {
      return super.getOperationsToDisplay();
    } finally {
      _$AccountBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool shouldDisplayOperation(PascalOperation op) {
    final _$actionInfo = _$AccountBaseActionController.startAction();
    try {
      return super.shouldDisplayOperation(op);
    } finally {
      _$AccountBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool hasOperationsToDisplay() {
    final _$actionInfo = _$AccountBaseActionController.startAction();
    try {
      return super.hasOperationsToDisplay();
    } finally {
      _$AccountBaseActionController.endAction(_$actionInfo);
    }
  }
}
