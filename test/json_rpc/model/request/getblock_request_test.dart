import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.GetBlockRequest', () {
    test('can serialize GetBlockRequest', () {
      GetBlockRequest blockRequest = GetBlockRequest(block: 1234);
      expect(json.encode(blockRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getblock","id":0,"params":{"block":1234}}');
    });
  });
}
