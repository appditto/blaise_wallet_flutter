import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/signing.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('signing.operations.BuyAccountOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'signerPublicKey':
            '3Ghhboo1Q8CFLc9BTdcweNX75Nctifx8aW1ovF58F1VyjHRxuDQRx2xUcSSm6ragsTRUZHGPSvdwM1HnReE4Je8aYeVeZHFJf23H2z',
        'buyerAccount': 1430880,
        'accountToBuy': 1440500,
        'price': 0.0001,
        'fee': 0.0002,
        'payload': 'techworker',
        'seller': 1440500,
        'n_operation': 4004,
        'r': '3B3FF1BA82E8923F6FA8B92B10FEA291CC73E563D4CB92E58039F3D25DB98FA1',
        's': '7449069D5E034AD0B3419532B11530B52E3EBDBBBB1E754CDEADB6E709291B6B',
        'raw':
            '010000000600000060D51500A40F0000F4FA1500000000000000000002000000000000000A0074656368776F726B6572000000000000020100000000000000F4FA150000000000000020003B3FF1BA82E8923F6FA8B92B10FEA291CC73E563D4CB92E58039F3D25DB98FA120007449069D5E034AD0B3419532B11530B52E3EBDBBBB1E754CDEADB6E709291B6B'
      };
    });

    test('can be decode a signed operation', () {
      BuyAccountOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.r)),
          fixture['r']);
      expect(PDUtil.byteToHex(PDUtil.encodeBigInt(decoded.signature.s)),
          fixture['s']);
      expect(decoded.sender.account, fixture['buyerAccount']);
      expect(decoded.target.account, fixture['accountToBuy']);
      expect(decoded.seller.account, fixture['seller']);
      expect(decoded.price.toStringOpt(), fixture['price'].toString());
      expect(decoded.amount.toStringOpt(), '0');
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(decoded.nOperation, fixture['n_operation']);
      expect(PDUtil.bytesToUtf8String(decoded.payload), fixture['payload']);
    });
    test('can be decode signed operation and encode it again', () {
      BuyAccountOperation decoded =
          RawOperationCoder.decodeFromBytes(PDUtil.hexToBytes(fixture['raw']));

      expect(PDUtil.byteToHex(RawOperationCoder.encodeToBytes(decoded)),
          fixture['raw']);
    });
    test('can be built by hand', () {
      BuyAccountOperation op = BuyAccountOperation(
          sender: AccountNumber.fromInt(fixture['buyerAccount']),
          target: AccountNumber.fromInt(fixture['accountToBuy']),
          seller: AccountNumber.fromInt(fixture['seller']),
          price: Currency(fixture['price'].toString()))
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
      BuyAccountOperation op = BuyAccountOperation(
          sender: AccountNumber.fromInt(fixture['buyerAccount']),
          target: AccountNumber.fromInt(fixture['accountToBuy']),
          seller: AccountNumber.fromInt(fixture['seller']),
          price: Currency(fixture['price'].toString()))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(PDUtil.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..sign(pk);

      expect(op.signature.r.toString().length > 30, true);
      expect(op.signature.s.toString().length > 30, true);
    });
  });
}
