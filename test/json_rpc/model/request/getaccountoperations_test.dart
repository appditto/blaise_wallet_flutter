import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.getaccountoperations.test', () {
    test('can serialize getaccountoperations', () {
      GetAccountOperationsRequest opsRequest =
          GetAccountOperationsRequest(account: 1234);
      expect(json.encode(opsRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getaccountoperations","id":0,"params":{"account":1234}}');
    });
  });
}
