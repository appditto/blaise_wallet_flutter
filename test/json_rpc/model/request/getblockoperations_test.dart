import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.getblockoperations.test', () {
    test('can serialize getblockoperations', () {
      GetBlockOperationsRequest opsRequest =
          GetBlockOperationsRequest(block: 1234);
      expect(json.encode(opsRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getblockoperations","id":0,"params":{"block":1234}}');
    });
  });
}
