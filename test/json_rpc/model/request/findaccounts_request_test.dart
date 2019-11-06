import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.findaccounts_request', () {
    test('can serialize findaccounts', () {
      FindAccountsRequest request =
          FindAccountsRequest(name: 'bbedward', exact: true);
      expect(json.encode(request.toJson()),
          '{"jsonrpc":"2.0","method":"findaccounts","id":0,"params":{"name":"bbedward","exact":true}}');
    });
  });
}
