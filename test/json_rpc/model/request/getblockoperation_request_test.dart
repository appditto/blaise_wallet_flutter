import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.getblockoperation.test', () {
    test('can serialize getblockoperation', () {
      GetBlockOperationRequest opsRequest =
          GetBlockOperationRequest(block: 1234);
      expect(json.encode(opsRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getblockoperation","id":0,"params":{"block":1234,"opblock":0}}');
    });
  });
}
