import 'package:pascaldart/common.dart';
import 'package:pascaldart/json_rpc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('json_rpc.model.pascal_block', () {
    test('can serialize block response', () {
      Map<String, dynamic> rawResponse = {
        "jsonrpc": "2.0",
        "id": 123,
        "result": {
          "block": 8888,
          "enc_pubkey":
              "CA0220000E60B6F76778CFE8678E30369BA7B2C38D0EC93FC3F39E61468E29FEC39F13BF2000572EDE3C44CF00FF86AFF651474D53CCBDF86B953F1ECE5FB8FC7BB6FA16F114",
          "reward": 100,
          "fee": 0,
          "ver": 1,
          "ver_a": 0,
          "timestamp": 1473161258,
          "target": 559519020,
          "nonce": 131965022,
          "payload":
              "New Node 9/4/2016 10:10:13 PM - Pascal Coin Miner & Explorer Build:1.0.2.0",
          "sbh":
              "5B75D33D9EFBF560EF5DA9B4A603528808626FE6C1FCEC44F83AF2330C6607EF",
          "oph":
              "81BE87831F03A2FE272C89BC6D2406DD57614846D9CEF30096BF574AB4AB3EE9",
          "pow":
              "00000000213A39EBBAB6D1FAEAA1EE528E398A587848F81FF66F7DA6113FC754",
          "operations": 1
        }
      };

      BaseResponse baseResp = BaseResponse.fromJson(rawResponse);
      expect(baseResp.jsonrpc, "2.0");
      expect(baseResp.id, 123);
      PascalBlock block = PascalBlock.fromJson(baseResp.result);
      expect(block.block, 8888);
      expect(PDUtil.byteToHex(PublicKeyCoder().encodeToBytes(block.encPubkey)),
          'CA0220000E60B6F76778CFE8678E30369BA7B2C38D0EC93FC3F39E61468E29FEC39F13BF2000572EDE3C44CF00FF86AFF651474D53CCBDF86B953F1ECE5FB8FC7BB6FA16F114');
      expect(block.reward.toStringOpt(), '100');
      expect(block.fee.toStringOpt(), '0');
      expect(block.ver, 1);
      expect(block.ver_a, 0);
      expect(block.timestamp.millisecondsSinceEpoch ~/ 1000, 1473161258);
      expect(block.target, 559519020);
      expect(block.nonce, 131965022);
      expect(block.payload,
          "New Node 9/4/2016 10:10:13 PM - Pascal Coin Miner & Explorer Build:1.0.2.0");
      expect(block.sbh,
          "5B75D33D9EFBF560EF5DA9B4A603528808626FE6C1FCEC44F83AF2330C6607EF");
      expect(block.oph,
          "81BE87831F03A2FE272C89BC6D2406DD57614846D9CEF30096BF574AB4AB3EE9");
      expect(block.pow,
          "00000000213A39EBBAB6D1FAEAA1EE528E398A587848F81FF66F7DA6113FC754");
      expect(block.operations, 1);
    });
  });
}
