import 'package:blaise_wallet_flutter/bus/update_history_event.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:logger/logger.dart';

part 'account.g.dart';

class Account = AccountBase with _$Account;

/// State for a specific account
abstract class AccountBase with Store {
  Logger log = Logger();

  @observable
  bool operationsLoading = true;

  @observable
  RPCClient rpcClient;

  @observable
  PascalAccount account;

  @observable
  Currency accountBalance;

  @observable
  List<PascalOperation> operations;

  @observable
  List<Widget> accountHistory;

  AccountBase({@required this.rpcClient, @required this.account}) {
    this.accountBalance = account.balance;
  }

  @action
  void decrementBalance(Currency delta) {
    this.account.balance -= delta;
    this.accountBalance -= delta;
  }

  @action
  void incrementBalance(Currency delta) {
    this.account.balance += delta;
    this.accountBalance += delta;
  }

  @action
  void updateAccountHistory(List<Widget> accountHistory) {
    this.accountHistory = accountHistory;
  }

  @action
  Future<bool> updateAccount() async {
    // Update account information via getaccount, return false is unsuccessful true otherwise
    GetAccountRequest request = GetAccountRequest(account: this.account.account.account);
    RPCResponse resp = await this.rpcClient.makeRpcRequest(request);
    if (resp.isError) {
      return false;
    }
    PascalAccount updatedAccount = resp;
    this.account = updatedAccount;
    this.accountBalance = updatedAccount.balance;
    return true;
  }

  void diffAndSortOperations(List<PascalOperation> newOperationList) {
    // Get pendings
    List<PascalOperation> pendingOperations = newOperationList.where((op) => op.maturation == null).toList();
    // Remove pendings that have since been confirmed
    this.operations.removeWhere((op) => op.maturation == null && !pendingOperations.contains(op));
    // Add all operations not already in the list and not pending
    this.operations.addAll(newOperationList.where((op) => (!this.operations.contains(op)) && op.maturation != null));
    // Sort by time
    this.operations.sort((a, b) => b.time.compareTo(a.time));
    // Add all pendings
    this.operations.removeWhere((op) => pendingOperations.contains(op));
    this.operations.insertAll(0, pendingOperations);
  }

  @action
  Future<void> getAccountOperations() async {
    GetAccountOperationsRequest request =
        GetAccountOperationsRequest(account: account.account.account,
                                    start: -1);
    RPCResponse resp = await this.rpcClient.makeRpcRequest(request);
    if (resp.isError) {
      ErrorResponse err = resp;
      log.e("getaccountoperations resulted in error ${err.errorMessage}");
      return null;
    }
    OperationsResponse opResp = resp;
    if (this.operations == null) {
      this.operations = opResp.operations;
    } else {
      // Diff and update operations
      this.diffAndSortOperations(opResp.operations);
      EventTaxiImpl.singleton().fire(UpdateHistoryEvent());
    }
    this.operationsLoading = false;
  }

  @action
  Future<RPCResponse> doSend({@required String amount, @required String destination, String payload = ""}) async {
    // Construct send
    TransactionOperation op = TransactionOperation(
      sender: this.account.account,
      target: AccountNumber(destination),
      amount: Currency(amount)
    )
    ..withNOperation(this.account.nOperation + 1)
    ..withPayload(PDUtil.stringToBytesUtf8(payload))
    ..withFee(Currency('0'))
    ..sign(PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey())));
    // Construct execute request
    ExecuteOperationsRequest request = ExecuteOperationsRequest(
      rawOperations: PDUtil.byteToHex(RawOperationCoder.encodeToBytes(op))
    );
    // Make request
    RPCResponse resp = await this.rpcClient.makeRpcRequest(request);
    if (resp.isError) {
      return resp;
    }
    OperationsResponse opResp = resp;
    if (opResp.operations[0].valid == null || opResp.operations[0].valid) {
      this.decrementBalance(Currency(amount));
      this.account.nOperation++;
      this.getAccountOperations();
    }
    return resp;
  }

  @action
  Future<RPCResponse> transferAccount(String strPubkey) async {
    PublicKey newPubkey;
    try {
      newPubkey = PublicKeyCoder().decodeFromBase58(strPubkey);
    } catch (e) {
      try {
        newPubkey = PublicKeyCoder().decodeFromBytes(PDUtil.hexToBytes(strPubkey));
      } catch (e) {
        throw Exception('Invalid Public key');
      }
    }
    // Construct transfer
    ChangeKeyOperation op = ChangeKeyOperation(
      signer: account.account,
      newPublicKey: newPubkey
    )
    ..withNOperation(account.nOperation + 1)
    ..withPayload(PDUtil.stringToBytesUtf8(""))
    ..withFee(Currency("0"))
    ..sign(PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey())));
    // Construct execute request
    ExecuteOperationsRequest request = ExecuteOperationsRequest(
      rawOperations: PDUtil.byteToHex(RawOperationCoder.encodeToBytes(op))
    );
    // Make request
    RPCResponse resp = await this.rpcClient.makeRpcRequest(request);
    return resp;
  }
}

