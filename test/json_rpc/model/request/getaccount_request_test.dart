import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.GetAccountRequest', () {
    test('can serialize GetAccountRequest', () {
      GetAccountRequest acctRequest = GetAccountRequest(account: 1234);
      expect(json.encode(acctRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getaccount","id":0,"params":{"account":1234}}');
    });
  });
}
