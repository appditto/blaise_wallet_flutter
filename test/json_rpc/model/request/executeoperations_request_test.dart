import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.executeoperations.test', () {
    test('can serialize executeoperations', () {
      ExecuteOperationsRequest opsRequest =
          ExecuteOperationsRequest(rawOperations: 'hexastring');
      expect(json.encode(opsRequest.toJson()),
          '{"jsonrpc":"2.0","method":"executeoperations","id":0,"params":{"rawoperations":"hexastring"}}');
    });
  });
}
