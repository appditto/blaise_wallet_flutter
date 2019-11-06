import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.GetBlocksRequest', () {
    test('can serialize GetBlocksRequest with last', () {
      GetBlocksRequest blockRequest = GetBlocksRequest(last: 1234);
      expect(json.encode(blockRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getblocks","id":0,"params":{"last":1234}}');
    });
    test('can serialize GetBlocksRequest with start and end', () {
      GetBlocksRequest blockRequest = GetBlocksRequest(start: 1, end: 100);
      expect(json.encode(blockRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getblocks","id":0,"params":{"start":1,"end":100}}');
    });
    test('throws exceptions with bad arguments', () {
      expect(() => GetBlocksRequest(start: 1), throwsArgumentError);
    });
  });
}
