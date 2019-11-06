import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/signing.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('signing.operations.ListForSaleOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'signerPublicKey':
            '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'signer': 1440500,
        'target': 1440503,
        'seller': 1440500,
        'lockedUntilBlock': 350000,
        'price': 0.0017,
        'newPublicKey':
            '3Ghhbommc5imqoAUAzXoEJpYo1qLiyVZip3Pwsj7WUXq7aFXwC4tw1MFsRrhPnA51CMAoeoyGJcMGV1dSU9FAqXRsnV2LLT7tBKDeY',
        'fee': 0.0002,
        'payload': 'techworker',
        'n_operation': 4003,
        's': '32D4CAF3A0FCF1854C00E18FA0838A2EF926C63FAEEF7C862E1750CB6D20DFD0',
        'r': 'A8A08439B6A54BF7E42EFB971B5709874E7F12F6B265684CAA9937BD28BDC793',
        'raw':
            '0100000004000000F4FA1500F7FA15000400A30F00001100000000000000F4FA15000000000000004600CA0220003078FA6B1419BD6F4D4F6A779358EBFA6BC12F3CE32E47A8D9F7CD5FA8956FF0200053A101778813DD24B90A5198BAE5EB9F8AA5EDFD30E4C130A69FDD62CAE774F93057050002000000000000000A0074656368776F726B65722000A8A08439B6A54BF7E42EFB971B5709874E7F12F6B265684CAA9937BD28BDC793200032D4CAF3A0FCF1854C00E18FA0838A2EF926C63FAEEF7C862E1750CB6D20DFD0'
      };
    });

    test('can be decode a signed operation', () {
      ListForSaleOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.r)),
          fixture['r']);
      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.s)),
          fixture['s']);
      expect(decoded.accountSigner.account, fixture['signer']);
      expect(decoded.targetSigner.account, fixture['target']);
      expect(decoded.accountToPay.account, fixture['seller']);
      expect(decoded.price.toStringOpt(), fixture['price'].toString());
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(decoded.nOperation, fixture['n_operation']);
      expect(decoded.lockedUntilBlock, fixture['lockedUntilBlock']);
      expect(PDUtil.bytesToUtf8String(decoded.payload), fixture['payload']);
      expect(PublicKeyCoder().encodeToBase58(decoded.newPublicKey),
          fixture['newPublicKey']);
    });
    test('can be decode signed operation and encode it again', () {
      ListForSaleOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(RawOperationCoder.encodeToBytes(decoded)),
          fixture['raw']);
    });
    test('can be built by hand', () {
      ListForSaleOperation op = ListForSaleOperation(
          accountSigner: AccountNumber.fromInt(fixture['signer']),
          targetSigner: AccountNumber.fromInt(fixture['target']),
          price: Currency(fixture['price'].toString()),
          accountToPay: AccountNumber.fromInt(fixture['seller']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..asPrivateSale(
            PublicKeyCoder().decodeFromBase58(fixture['newPublicKey']),
            fixture['lockedUntilBlock'])
        ..withSignature(Signature(
            r: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['r'])),
            s: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['s']))));

      Uint8List encoded = RawOperationCoder.encodeToBytes(op);

      expect(PDUtil.byteToHex(encoded), fixture['raw']);
    });
    test('can be built by hand and signed', () {
      PrivateKey pk = PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(
          'CA02200046D101363B3330D65373A70F6E47BB7745FC8EE1F9B3F71992D6B82648158D73'));
      ListForSaleOperation op = ListForSaleOperation(
          accountSigner: AccountNumber.fromInt(fixture['signer']),
          targetSigner: AccountNumber.fromInt(fixture['target']),
          price: Currency(fixture['price'].toString()),
          accountToPay: AccountNumber.fromInt(fixture['seller']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..asPrivateSale(
            PublicKeyCoder().decodeFromBase58(fixture['newPublicKey']),
            fixture['lockedUntilBlock'])
        ..sign(pk);

      expect(op.signature.r.toString().length > 30, true);
      expect(op.signature.s.toString().length > 30, true);
    });
  });
}
