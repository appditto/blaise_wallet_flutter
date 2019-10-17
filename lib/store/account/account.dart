import 'dart:convert';
import 'dart:typed_data';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/update_history_event.dart';
import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
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
  Logger log = sl.get<Logger>();

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
  List<PascalOperation> operationsToDisplay;

  @observable
  bool paid;

  AccountBase({@required this.rpcClient, @required this.account}) {
    this.accountBalance = account.balance;
    this.paid = false;
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
  Future<RPCResponse> jRpcRequest(Map<String, dynamic> request) async {
    /// This custom request includes borrowed accounts
    request['id'] = this.rpcClient.id;
    String responseJson = await this.rpcClient.rpcPost(request);
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
    if (resp.result.containsKey('paid')) {
      this.paid = resp.result['paid'];
      resp.result.remove('paid');
    }
    return PascalAccount.fromJson(resp.result);
  }

  @action
  Future<bool> updateAccount() async {
    // Update account information via getaccount, return false is unsuccessful true otherwise
    bool hasCustomDaemon = (await sl.get<SharedPrefsUtil>().getRpcUrl()) != AppConstants.DEFAULT_RPC_HTTP_URL;
    GetAccountRequest request = GetAccountRequest(account: this.account.account.account);
    Map<String, dynamic> requestJson = request.toJson();
    if (!hasCustomDaemon && account.isBorrowed) {
      requestJson['params'].putIfAbsent('borrowed', () => true);
    }
    RPCResponse resp = await this.jRpcRequest(requestJson);
    if (resp.isError) {
      return false;
    }
    PascalAccount updatedAccount = resp;
    // See if this accounts borrowed status has changed
    if (this.account.isBorrowed) {
      String curAcctPubkey = PublicKeyCoder().encodeToBase58(updatedAccount.encPubkey);
      String curWalletPubkey = PublicKeyCoder().encodeToBase58(walletState.publicKey);
      if (curAcctPubkey != curWalletPubkey) {
        updatedAccount.isBorrowed = true;
      }
    }
    this.account = updatedAccount;
    this.accountBalance = updatedAccount.balance;
    return true;
  }

  @action
  void addNewOperation(PascalOperation op) {
    /// Add operation if:
    /// 1) We don't have it
    /// 2) We do have it, but it has since been confirmed
    /// 3) This account is not borrowed
    if (this.operations == null) {
      return;
    }
    if (!this.operations.contains(op) || this.operations.contains(op) && this.operations.firstWhere((nOp) => nOp == op).maturation == null && op.maturation != null) {
      if (this.operations.contains(op)) {
        this.operations.remove(op);
      }
      this.operations.insert(0, op);
      // Re-sort this list
      // Remove pendings
      List<PascalOperation> pendings = this.operations.where((op) => op.maturation == null).toList();
      this.operations.removeWhere((op) => op.maturation == null);
      // Sort by time
      this.operations.sort((a, b) => b.time.compareTo(a.time));
      this.operations.insertAll(0, pendings);
      // Update to display
      this.operationsToDisplay = getOperationsToDisplay();
      // Refresh total wallet balance
      EventTaxiImpl.singleton().fire(UpdateHistoryEvent());
    }
  }

  @action
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
      this.operationsToDisplay = getOperationsToDisplay();
    } else {
      // Diff and update operations
      this.diffAndSortOperations(opResp.operations);
      this.operationsToDisplay = getOperationsToDisplay();
      EventTaxiImpl.singleton().fire(UpdateHistoryEvent());
    }
    this.operationsLoading = false;
  }

  @action
  List<PascalOperation> getOperationsToDisplay() {
    return this.operations.where((op) => shouldDisplayOperation(op)).toList();
  }

  @action
  bool shouldDisplayOperation(PascalOperation op) {
    if (op.optype == OpType.TRANSACTION) {
      if (op.senders.length > 0 && op.receivers.length > 0 && op.senders[0].nOperation == 1 && op.receivers[0].receivingAccount == AccountNumber("1000")) {
        return false;
      }
      return true;
    } else if (op.optype == OpType.CHANGE_ACCOUNT_INFO) {
      if (op.changers.length > 0 && op.changers[0].newName != null) {
        return true;
      }
    } else if (op.optype == OpType.LIST_FORSALE) {
      if (op.changers.length >0 && op.changers[0].sellerAccount != null && op.changers[0].accountPrice != null) {
        return true;
      }
    } else if (op.optype == OpType.DELIST_FORSALE) {
      return true;
    }
    return false;
  }

  @action
  bool hasOperationsToDisplay() {
    if (this.operationsLoading || this.operations == null || this.operations.length == 0) {
      return false;
    }
    for (PascalOperation op in this.operations) {
      if (shouldDisplayOperation(op)) {
        return true;
      }
    }
    return false;
  }

  @action
  void changeAccountState(AccountState accountState) {
    this.account.state = accountState;
  }

  @action
  Future<RPCResponse> doSend({@required String amount, @required String destination, Currency fee, Uint8List encryptedPayload, String payload = ""}) async {
    fee = fee == null ? Currency('0') : fee;
    // Construct send
    TransactionOperation op = TransactionOperation(
      sender: this.account.account,
      target: AccountNumber(destination),
      amount: Currency(amount)
    )
    ..withNOperation(this.account.nOperation + 1)
    ..withPayload(encryptedPayload == null ? PDUtil.stringToBytesUtf8(payload) : encryptedPayload)
    ..withFee(fee)
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
  Future<RPCResponse> transferAccount(String strPubkey, {Currency fee}) async {
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
    fee = fee == null ? Currency('0') : fee;
    // Construct transfer
    ChangeKeyOperation op = ChangeKeyOperation(
      signer: account.account,
      newPublicKey: newPubkey
    )
    ..withNOperation(account.nOperation + 1)
    ..withPayload(PDUtil.stringToBytesUtf8(""))
    ..withFee(fee)
    ..sign(PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey())));
    // Construct execute request
    ExecuteOperationsRequest request = ExecuteOperationsRequest(
      rawOperations: PDUtil.byteToHex(RawOperationCoder.encodeToBytes(op))
    );
    // Make request
    RPCResponse resp = await this.rpcClient.makeRpcRequest(request);
    return resp;
  }

  @action
  Future<RPCResponse> changeAccountName(AccountName newName, {Currency fee}) async {
    fee = fee == null ? Currency('0') : fee;
    // Construct name change
    ChangeAccountInfoOperation op = ChangeAccountInfoOperation(
      accountSigner: account.account,
      targetSigner: account.account,
      newName: newName,
      withNewName: true
    )
    ..withNOperation(account.nOperation + 1)
    ..withPayload(PDUtil.stringToBytesUtf8(""))
    ..withFee(fee)
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
      this.account.nOperation++;
      this.getAccountOperations();
    }
    return resp;
  }

  @action
  Future<RPCResponse> listAccountForSale(Currency price, AccountNumber accountToPay, {PublicKey newPubKey, Currency fee}) async {
    fee = fee == null ? Currency('0') : fee;
    // Construct list for sale
    ListForSaleOperation op = ListForSaleOperation(
      accountSigner: account.account,
      targetSigner: account.account,
      price: price,
      accountToPay: accountToPay,
      newPublicKey: newPubKey
    )
    ..withNOperation(account.nOperation + 1)
    ..withPayload(PDUtil.stringToBytesUtf8(""))
    ..withFee(fee)
    ..sign(PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey())));
    // Execute request
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
      this.account.nOperation++;
      this.getAccountOperations();
    }
    return resp;
  }

  @action
  Future<RPCResponse> delistAccountForSale({Currency fee}) async {
    fee = fee == null ? Currency('0') : fee;
    // Construct list for sale
    DeListForSaleOperation op = DeListForSaleOperation(
      accountSigner: account.account,
      targetSigner: account.account
    )
    ..withNOperation(account.nOperation + 1)
    ..withPayload(PDUtil.stringToBytesUtf8(""))
    ..withFee(fee)
    ..sign(PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(await sl.get<Vault>().getPrivateKey())));
    // Execute request
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
      this.account.nOperation++;
      this.getAccountOperations();
    }
    return resp;
  }

  @action
  Future<Uint8List> encryptPayloadEcies(String payload, AccountNumber account) async {
    try {
      // Do getaccountrequest to get the public key of this account
      GetAccountRequest req = GetAccountRequest(
        account: account.account
      );
      // Execute request
      RPCResponse resp = await rpcClient.makeRpcRequest(req);
      if (resp.isError) {
        return null;
      }
      PascalAccount receiverAcct = resp;
      return EciesCrypt.encrypt(PDUtil.stringToBytesUtf8(payload), receiverAcct.encPubkey);
    } catch (e) {
      return null;
    }
  }
}

