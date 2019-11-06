import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.findoperation_request', () {
    test('can serialize findoperation', () {
      FindOperationRequest request = FindOperationRequest(ophash: '1234');
      expect(json.encode(request.toJson()),
          '{"jsonrpc":"2.0","method":"findoperation","id":0,"params":{"ophash":"1234"}}');
    });
  });
}
