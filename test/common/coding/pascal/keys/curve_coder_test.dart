import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.coding.pascal.keys.CurveCoder', () {
    CurveCoder curveCoder;
    setUp(() {
      curveCoder = CurveCoder();
    });
    test('can encode a pascalcoin key curve', () {
      Uint8List encoded =
          curveCoder.encodeToBytes(Curve.fromString(Curve.CN_SECP256K1).id);
      expect(PDUtil.byteToHex(encoded), 'CA02');
    });
    test('can decode a pascalcoin key curve', () {
      expect(
          curveCoder.decodeFromBytes(PDUtil.hexToBytes('CA02')) is Curve, true);
      expect(curveCoder.decodeFromBytes(PDUtil.hexToBytes('CA02')).id, 714);
    });
  });
}
