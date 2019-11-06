import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/signing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('signing.operations.ChangeAccountInfoOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'signerPublicKey':
            '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'signer': 1440500,
        'target': 1440503,
        'newPublicKey':
            '3Ghhbommc5imqoAUAzXoEJpYo1qLiyVZip3Pwsj7WUXq7aFXwC4tw1MFsRrhPnA51CMAoeoyGJcMGV1dSU9FAqXRsnV2LLT7tBKDeY',
        'newName': 'techworker123',
        'newType': '345',
        'n_operation': 4003,
        'fee': 0.0002,
        'payload': 'techworker',
        'r': '28D54FB4B87C8DEA5884876FA6DDD30115B1EAECEA50869181CC05D788C74D6A',
        's': '61E719DCEE48E93B94BC0938D1CADDBCB7E59F259097C622C98E5D0C758BB5AC',
        'raw':
            '0100000008000000F4FA1500F7FA1500A30F000002000000000000000A0074656368776F726B657200000000000007CA0220003078FA6B1419BD6F4D4F6A779358EBFA6BC12F3CE32E47A8D9F7CD5FA8956FF0200053A101778813DD24B90A5198BAE5EB9F8AA5EDFD30E4C130A69FDD62CAE774F90D0074656368776F726B65723132335901200028D54FB4B87C8DEA5884876FA6DDD30115B1EAECEA50869181CC05D788C74D6A200061E719DCEE48E93B94BC0938D1CADDBCB7E59F259097C622C98E5D0C758BB5AC'
      };
    });

    test('can be decode a signed operation', () {
      ChangeAccountInfoOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.r)),
          fixture['r']);
      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.s)),
          fixture['s']);
      expect(decoded.accountSigner.account, fixture['signer']);
      expect(decoded.targetSigner.account, fixture['target']);
      expect(decoded.nOperation, fixture['n_operation']);
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(decoded.changeType & 1, 1);
      expect(decoded.changeType & 2, 2);
      expect(decoded.changeType & 4, 4);
      expect(PDUtil.bytesToUtf8String(decoded.payload), fixture['payload']);
      expect(decoded.newName.toString(), fixture['newName']);
      expect(decoded.newType.toString(), fixture['newType']);
      expect(PublicKeyCoder().encodeToBase58(decoded.newPublicKey),
          fixture['newPublicKey']);
    });

    test('can be decode signed operation and encode it again', () {
      ChangeAccountInfoOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(RawOperationCoder.encodeToBytes(decoded)),
          fixture['raw']);
    });

    test('can be build by hand', () {
      ChangeAccountInfoOperation op = ChangeAccountInfoOperation(
          accountSigner: AccountNumber.fromInt(fixture['signer']),
          targetSigner: AccountNumber.fromInt(fixture['target']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..setNewName(AccountName(fixture['newName']))
        ..setNewType(int.parse(fixture['newType']))
        ..setNewPublickey(
            PublicKeyCoder().decodeFromBase58(fixture['newPublicKey']))
        ..withSignature(Signature(
            r: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['r'])),
            s: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['s']))));

      Uint8List encoded = RawOperationCoder.encodeToBytes(op);

      expect(PDUtil.byteToHex(encoded), fixture['raw']);
    });
    test('can be built by hand and signed', () {
      PrivateKey pk = PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(
          'CA02200046D101363B3330D65373A70F6E47BB7745FC8EE1F9B3F71992D6B82648158D73'));
      ChangeAccountInfoOperation op = ChangeAccountInfoOperation(
          accountSigner: AccountNumber.fromInt(fixture['signer']),
          targetSigner: AccountNumber.fromInt(fixture['target']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..setNewName(AccountName(fixture['newName']))
        ..setNewType(int.parse(fixture['newType']))
        ..setNewPublickey(
            PublicKeyCoder().decodeFromBase58(fixture['newPublicKey']))
        ..sign(pk);

      expect(op.signature.r.toString().length > 30, true);
      expect(op.signature.s.toString().length > 30, true);
    });
    test('can compute digest correctly', () {
      ChangeAccountInfoOperation op = ChangeAccountInfoOperation(
        accountSigner: AccountNumber.fromInt(1440500),
        targetSigner: AccountNumber.fromInt(1440500),
        newName: AccountName('bbedward'),
        withNewName: true
      )
      ..withNOperation(20)
      ..withPayload(PDUtil.stringToBytesUtf8(""))
      ..withFee(Currency("0"))
        ..withSignature(Signature(
            r: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['r'])),
            s: PDUtil.decodeBigInt(PDUtil.hexToBytes(fixture['s']))));
        expect(PDUtil.byteToHex(op.digest()), 'F4FA1500F4FA150014000000000000000000000000000000000000000200000000000008006262656477617264000008');
    });
  });
}
