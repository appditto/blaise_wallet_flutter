import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/signing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('signing.operations.TransactionOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'sender': 1440500,
        'target': 1440503,
        'senderPubkey':
            '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'targetPubkey':
            '3GhhbojvCFtyYSPxXfuk86uvJhURBEzF2fxV7x6kuW3Gi7ApSDd1scztAXGyeqphytxi6XibueQCoAG3yBCkXvg1BfGnosd6xKnKPT',
        'amount': 0.0015,
        'fee': 0.0002,
        'payload': 'techworker',
        'n_operation': 4003,
        'r': '1201D10D537B0F6D7CB2032A768A851E0EF2426AA37756BCADB994AF189D124A',
        's': '9DACA47597ADFB3E529B82EB231396F464EE1C4E76DC6E85CD10CA3711C2D6C2',
        'raw':
            '0100000001000000F4FA1500A30F0000F7FA15000F0000000000000002000000000000000A0074656368776F726B657200000000000020001201D10D537B0F6D7CB2032A768A851E0EF2426AA37756BCADB994AF189D124A20009DACA47597ADFB3E529B82EB231396F464EE1C4E76DC6E85CD10CA3711C2D6C2'
      };
    });

    test('can be decode a signed operation', () {
      TransactionOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.r)),
          fixture['r']);
      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.s)),
          fixture['s']);
      expect(decoded.sender.account, fixture['sender']);
      expect(decoded.target.account, fixture['target']);
      expect(decoded.amount.toStringOpt(), fixture['amount'].toString());
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(decoded.nOperation, fixture['n_operation']);
      expect(PDUtil.bytesToUtf8String(decoded.payload), fixture['payload']);
    });
    test('can be decode signed operation and encode it again', () {
      TransactionOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(RawOperationCoder.encodeToBytes(decoded)),
          fixture['raw']);
    });
    test('can be built by hand', () {
      TransactionOperation op = TransactionOperation(
          sender: AccountNumber.fromInt(fixture['sender']),
          target: AccountNumber.fromInt(fixture['target']),
          amount: Currency(fixture['amount'].toString()))
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
      TransactionOperation op = TransactionOperation(
          sender: AccountNumber.fromInt(fixture['sender']),
          target: AccountNumber.fromInt(fixture['target']),
          amount: Currency(fixture['amount'].toString()))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..sign(pk);

      expect(op.signature.r.toString().length > 30, true);
      expect(op.signature.s.toString().length > 30, true);
    });
    test('can calculate digest correctly', () {
      TransactionOperation op = TransactionOperation(
        sender: AccountNumber.fromInt(1440500),
        target: AccountNumber.fromInt(1440503),
        amount: Currency('0.0015')
      )
      ..withFee(Currency('0'))
      ..withPayload(PDUtil.stringToBytesUtf8(''))
      ..withNOperation(4003);
      expect(PDUtil.byteToHex(op.digest()), 'F4FA1500A30F0000F7FA15000F000000000000000000000000000000000001');
      TransactionOperation op2 = TransactionOperation(
        sender: AccountNumber.fromInt(1440500),
        target: AccountNumber.fromInt(1440503),
        amount: Currency('0.0015')
      )
      ..withFee(Currency('0.0002'))
      ..withPayload(PDUtil.stringToBytesUtf8('techworker'))
      ..withNOperation(4003);
      expect(PDUtil.byteToHex(op2.digest()), 'F4FA1500A30F0000F7FA15000F00000000000000020000000000000074656368776F726B6572000001');
    });
  });
}
