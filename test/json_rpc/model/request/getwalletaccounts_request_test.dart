import 'dart:convert';

import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.request.getwalletaccounts_request', () {
    test('can serialize getwalletaccounts', () {
      GetWalletAccountsRequest acctRequest = GetWalletAccountsRequest(
          encPubkey:
              'CA0220009D92DFA1D6F8B2CAE31194EE5433EE4AD457AE145C1C67E49A9196EE58A45B9F200046EAF20C0A26A80A7693E71C0222313A0187AFCA838209FF86FB740A4FFF7F0B');
      expect(json.encode(acctRequest.toJson()),
          '{"jsonrpc":"2.0","method":"getwalletaccounts","id":0,"params":{"enc_pubkey":"CA0220009D92DFA1D6F8B2CAE31194EE5433EE4AD457AE145C1C67E49A9196EE58A45B9F200046EAF20C0A26A80A7693E71C0222313A0187AFCA838209FF86FB740A4FFF7F0B"}}');
    });
  });
}
