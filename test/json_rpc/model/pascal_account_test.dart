import 'package:pascaldart/common.dart';
import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.pascal_account', () {
    test('can serialize getaccount response', () {
      Map<String, dynamic> rawResponse = {
        "jsonrpc": "2.0",
        "id": 123,
        "result": {
          "account": 1920,
          "enc_pubkey":
              "CA0220009D92DFA1D6F8B2CAE31194EE5433EE4AD457AE145C1C67E49A9196EE58A45B9F200046EAF20C0A26A80A7693E71C0222313A0187AFCA838209FF86FB740A4FFF7F0B",
          "balance": 29595.952,
          "n_operation": 0,
          "updated_b": 11973
        }
      };
      BaseResponse baseResp = BaseResponse.fromJson(rawResponse);
      expect(baseResp.jsonrpc, "2.0");
      expect(baseResp.id, 123);
      PascalAccount getAcctResp = PascalAccount.fromJson(baseResp.result);
      expect(getAcctResp.account.account, 1920);
      expect(
          PDUtil.byteToHex(
              PublicKeyCoder().encodeToBytes(getAcctResp.encPubkey)),
          'CA0220009D92DFA1D6F8B2CAE31194EE5433EE4AD457AE145C1C67E49A9196EE58A45B9F200046EAF20C0A26A80A7693E71C0222313A0187AFCA838209FF86FB740A4FFF7F0B');
      expect(getAcctResp.balance.toStringOpt(), '29595.952');
      expect(getAcctResp.nOperation, 0);
      expect(getAcctResp.updatedBlock, 11973);
    });
  });
}
