import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.getpendings_request', () {
    test('can serialize getpendings', () {
      GetPendingsRequest request = GetPendingsRequest(max: 0);
      expect(json.encode(request.toJson()),
          '{"jsonrpc":"2.0","method":"getpendings","id":0,"params":{"max":0}}');
    });
  });
}
