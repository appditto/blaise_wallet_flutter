import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Common.Util', () {
    test('test hex to byte array and back', () {
      String hex =
          '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
      Uint8List byteArray = PDUtil.hexToBytes(
          '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
      expect(PDUtil.byteToHex(byteArray), hex);
    });
    test('test hex to binary and back', () {
      String hex =
          '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
      String binary = PDUtil.hexToBinary(
          '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
      expect(PDUtil.binaryToHex(binary), hex);
    });
    test('can concat one or more byte arrays', () {
      final List<Uint8List> hexas = ['ABCD', '0020', 'FFFFFFDD']
          .map((hex) => PDUtil.hexToBytes(hex))
          .toList();

      expect(PDUtil.byteToHex(PDUtil.concat(hexas)), 'ABCD0020FFFFFFDD');
    });
    test('can convert int to byte array and back', () {
      final Uint8List h = PDUtil.intToBytes(714);

      expect(PDUtil.bytesToInt(h), 714);
    });
    test('can decode and encode a bigint to little-endian byte array', () {
      BigInt a = BigInt.from(1000);
      Uint8List encoded = PDUtil.encodeBigInt(a);
      String hex = 'E803';
      expect(PDUtil.byteToHex(encoded), hex);
      expect(PDUtil.decodeBigInt(encoded), a);
    });
    test('can decode and encode a bigint to big-endian byte array', () {
      BigInt a = BigInt.from(1000);
      Uint8List encoded = PDUtil.encodeBigInt(a, endian: Endian.big);
      String hex = '03E8';
      expect(PDUtil.byteToHex(encoded), hex);
      expect(PDUtil.decodeBigInt(encoded, endian: Endian.big), a);
    });
  });
}
