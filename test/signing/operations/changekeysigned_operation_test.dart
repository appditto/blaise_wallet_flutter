import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/signing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('signing.operations.ChangeKeySignedOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'sender': 1440500,
        'target': 1440503,
        'oldPublicKey':
            '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'newPublicKey':
            '3Ghhbommc5imqoAUAzXoEJpYo1qLiyVZip3Pwsj7WUXq7aFXwC4tw1MFsRrhPnA51CMAoeoyGJcMGV1dSU9FAqXRsnV2LLT7tBKDeY',
        'fee': 0.0002,
        'payload': 'techworker',
        'n_operation': 4003,
        's': 'AEB41A5FB2D7A1B89C17897E87959AE63B9864236397FBDCFF118E964B1211C8',
        'r': '5CAD340D46F1A926DCD3FA00962A0EFC856733E46285BF945B1F19A90DE2BEF8',
        'raw':
            '0100000007000000F4FA1500F7FA1500A30F000002000000000000000A0074656368776F726B65720000000000004600CA0220003078FA6B1419BD6F4D4F6A779358EBFA6BC12F3CE32E47A8D9F7CD5FA8956FF0200053A101778813DD24B90A5198BAE5EB9F8AA5EDFD30E4C130A69FDD62CAE774F920005CAD340D46F1A926DCD3FA00962A0EFC856733E46285BF945B1F19A90DE2BEF82000AEB41A5FB2D7A1B89C17897E87959AE63B9864236397FBDCFF118E964B1211C8'
      };
    });

    test('can be decode a signed operation', () {
      ChangeKeySignedOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.r)),
          fixture['r']);
      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.s)),
          fixture['s']);
      expect(decoded.signer.account, fixture['sender']);
      expect(decoded.target.account, fixture['target']);
      expect(decoded.nOperation, fixture['n_operation']);
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(PDUtil.bytesToUtf8String(decoded.payload), fixture['payload']);
      expect(PublicKeyCoder().encodeToBase58(decoded.newPublicKey),
          fixture['newPublicKey']);
    });

    test('can be decode signed operation and encode it again', () {
      ChangeKeySignedOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(RawOperationCoder.encodeToBytes(decoded)),
          fixture['raw']);
    });

    test('can be build by hand', () {
      ChangeKeySignedOperation op = ChangeKeySignedOperation(
          signer: AccountNumber.fromInt(fixture['sender']),
          target: AccountNumber.fromInt(fixture['target']),
          newPublicKey:
              PublicKeyCoder().decodeFromBase58(fixture['newPublicKey']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..withSignature(Signature(
            r: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['r'])),
            s: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['s']))));

      Uint8List encoded = RawOperationCoder.encodeToBytes(op);

      expect(PDUtil.byteToHex(encoded), fixture['raw']);
    });
    test('can be built by hand and signed', () {
      PrivateKey pk = PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(
          'CA02200046D101363B3330D65373A70F6E47BB7745FC8EE1F9B3F71992D6B82648158D73'));
      ChangeKeySignedOperation op = ChangeKeySignedOperation(
          signer: AccountNumber.fromInt(fixture['sender']),
          target: AccountNumber.fromInt(fixture['target']),
          newPublicKey:
              PublicKeyCoder().decodeFromBase58(fixture['newPublicKey']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..sign(pk);

      expect(op.signature.r.toString().length > 30, true);
      expect(op.signature.s.toString().length > 30, true);
    });
  });
}
