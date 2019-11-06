import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('crypto.encrypt.pascal.KDF', () {
    test('generates key and iv without salt', () {
      KeyIV data = KDF.pascalCoin('test');
      expect(data.key is Uint8List, true);
      expect(data.iv is Uint8List, true);

      expect(data.key.length == 32, true);
      expect(data.iv.length == 16, true);
    });

    test('generates key and iv with salt', () {
      KeyIV data =
          KDF.pascalCoin('test', salt: PDUtil.stringToBytesUtf8('123456798'));
      expect(data.key is Uint8List, true);
      expect(data.iv is Uint8List, true);

      expect(data.key.length == 32, true);
      expect(data.iv.length == 16, true);
    });
  });
}
