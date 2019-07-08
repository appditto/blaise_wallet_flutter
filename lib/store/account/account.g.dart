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
    _$operationsLoadingAtom.reportObserved();
    return super.operationsLoading;
  }

  @override
  set operationsLoading(bool value) {
    _$operationsLoadingAtom.context
        .checkIfStateModificationsAreAllowed(_$operationsLoadingAtom);
    super.operationsLoading = value;
    _$operationsLoadingAtom.reportChanged();
  }

  final _$rpcClientAtom = Atom(name: 'AccountBase.rpcClient');

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

  final _$accountAtom = Atom(name: 'AccountBase.account');

  @override
  PascalAccount get account {
    _$accountAtom.reportObserved();
    return super.account;
  }

  @override
  set account(PascalAccount value) {
    _$accountAtom.context.checkIfStateModificationsAreAllowed(_$accountAtom);
    super.account = value;
    _$accountAtom.reportChanged();
  }

  final _$accountBalanceAtom = Atom(name: 'AccountBase.accountBalance');

  @override
  Currency get accountBalance {
    _$accountBalanceAtom.reportObserved();
    return super.accountBalance;
  }

  @override
  set accountBalance(Currency value) {
    _$accountBalanceAtom.context
        .checkIfStateModificationsAreAllowed(_$accountBalanceAtom);
    super.accountBalance = value;
    _$accountBalanceAtom.reportChanged();
  }

  final _$operationsAtom = Atom(name: 'AccountBase.operations');

  @override
  List<PascalOperation> get operations {
    _$operationsAtom.reportObserved();
    return super.operations;
  }

  @override
  set operations(List<PascalOperation> value) {
    _$operationsAtom.context
        .checkIfStateModificationsAreAllowed(_$operationsAtom);
    super.operations = value;
    _$operationsAtom.reportChanged();
  }

  final _$accountHistoryAtom = Atom(name: 'AccountBase.accountHistory');

  @override
  List<Widget> get accountHistory {
    _$accountHistoryAtom.reportObserved();
    return super.accountHistory;
  }

  @override
  set accountHistory(List<Widget> value) {
    _$accountHistoryAtom.context
        .checkIfStateModificationsAreAllowed(_$accountHistoryAtom);
    super.accountHistory = value;
    _$accountHistoryAtom.reportChanged();
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
      {String amount, String destination, String payload = ""}) {
    return _$doSendAsyncAction.run(() => super
        .doSend(amount: amount, destination: destination, payload: payload));
  }

  final _$transferAccountAsyncAction = AsyncAction('transferAccount');

  @override
  Future<RPCResponse> transferAccount(String strPubkey) {
    return _$transferAccountAsyncAction
        .run(() => super.transferAccount(strPubkey));
  }

  final _$changeAccountNameAsyncAction = AsyncAction('changeAccountName');

  @override
  Future<RPCResponse> changeAccountName(AccountName newName) {
    return _$changeAccountNameAsyncAction
        .run(() => super.changeAccountName(newName));
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
  void updateAccountHistory(List<Widget> accountHistory) {
    final _$actionInfo = _$AccountBaseActionController.startAction();
    try {
      return super.updateAccountHistory(accountHistory);
    } finally {
      _$AccountBaseActionController.endAction(_$actionInfo);
    }
  }
}
