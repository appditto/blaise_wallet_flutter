import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/privatekey.dart';

void main() {
  group('common.model.keys.PrivateKey', () {
    PrivateKeyFixtures fixtures;
    setUp(() {
      fixtures = PrivateKeyFixtures();
    });

    test('cannot be created with wrong length values managed by the curve', () {
      expect(
          () => PrivateKey(
              PDUtil.hexToBytes(List.filled(35, '00').join()), Curve(714)),
          throwsException);
      expect(
          () => PrivateKey(
              PDUtil.hexToBytes(List.filled(51, '00').join()), Curve(715)),
          throwsException);
      expect(
          () => PrivateKey(
              PDUtil.hexToBytes(List.filled(69, '00').join()), Curve(716)),
          throwsException);
      expect(
          () => PrivateKey(
              PDUtil.hexToBytes(List.filled(39, '00').join()), Curve(729)),
          throwsException);
    });
    test('returns key as ec', () {
      fixtures.curve714.forEach((c) {
        PrivateKey pkey = PrivateKeyCoder()
            .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(PDUtil.byteToHex(pkey.key), PDUtil.byteToHex(pkey.ec()));
      });
      fixtures.curve715.forEach((c) {
        PrivateKey pkey = PrivateKeyCoder()
            .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(PDUtil.byteToHex(pkey.key), PDUtil.byteToHex(pkey.ec()));
      });
      fixtures.curve716.forEach((c) {
        PrivateKey pkey = PrivateKeyCoder()
            .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(PDUtil.byteToHex(pkey.key), PDUtil.byteToHex(pkey.ec()));
      });
      fixtures.curve729.forEach((c) {
        PrivateKey pkey = PrivateKeyCoder()
            .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(PDUtil.byteToHex(pkey.key), PDUtil.byteToHex(pkey.ec()));
      });
    });
  });
}
