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
  List<PascalOperation> operations;

  AccountBase({@required this.rpcClient, @required this.account});

  // TODO - this will be one to add pagination to
  @action
  Future<void> getAccountOperations() async {
    GetAccountOperationsRequest request =
        GetAccountOperationsRequest(account: account.account.account);
    RPCResponse resp = await this.rpcClient.makeRpcRequest(request);
    if (resp.isError) {
      ErrorResponse err = resp;
      log.e("getaccountoperations resulted in error ${err.errorMessage}");
      return null;
    }
    OperationsResponse opResp = resp;
    this.operations = opResp.operations;
    this.operationsLoading = false;
  }
}
