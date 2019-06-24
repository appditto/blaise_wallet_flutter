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
      this.operations.addAll(opResp.operations.where((op) => !this.operations.contains(op)));
      this.operations.sort((a, b) => a.time.compareTo(b.time));
    }
    this.operationsLoading = false;
  }
}
