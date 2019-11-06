import 'package:pascaldart/common.dart';
import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.pascal_operation', () {
    test('can serialize operation response', () {
      Map<String, dynamic> rawResponse = {
        "jsonrpc": "2.0",
        "id": 123,
        "result": {
          "block": 21555,
          "opblock": 0,
          "optype": 2,
          "time": 1561919606,
          "account": 101740,
          "optxt": "Change Key to secp256k1",
          "amount": 0,
          "fee": 0,
          "balance": 0,
          "payload": "",
          "enc_pubkey":
              "CA02200078D867C93D58C2C46C66667A139543DCF8420D9119B7A0E06197D22A5BBCE5542000EA2E492FD8B90E48AF3D9EF438C6FBEA57C8A8E75889807DE588B490B1D57187",
          "ophash":
              "335400006C8D0100020000003330433034464446453130354434444445424141"
        }
      };

      BaseResponse baseResp = BaseResponse.fromJson(rawResponse);
      expect(baseResp.jsonrpc, "2.0");
      expect(baseResp.id, 123);
      PascalOperation op = PascalOperation.fromJson(baseResp.result);
      expect(op.block, 21555);
      expect(op.opblock, 0);
      expect(op.optype, 2);
      expect(op.time.millisecondsSinceEpoch ~/ 1000, 1561919606);
      expect(op.time.year, 2019);
      expect(op.account.account, 101740);
      expect(op.optxt, "Change Key to secp256k1");
      expect(op.amount.pasc, BigInt.zero);
      expect(op.fee.pasc, BigInt.zero);
      expect(op.balance.pasc, BigInt.zero);
      expect(op.payload, "");
      expect(PDUtil.byteToHex(PublicKeyCoder().encodeToBytes(op.encPubkey)),
          'CA02200078D867C93D58C2C46C66667A139543DCF8420D9119B7A0E06197D22A5BBCE5542000EA2E492FD8B90E48AF3D9EF438C6FBEA57C8A8E75889807DE588B490B1D57187');
      expect(op.ophash,
          '335400006C8D0100020000003330433034464446453130354434444445424141');
    });
  });
}
