import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/publickey.dart';

void main() {
  group('common.model.keys.PublicKey', () {
    const List<int> curves = [
      Curve.CI_SECP256K1,
      Curve.CI_SECT283K1,
      Curve.CI_SECP521R1,
      Curve.CI_SECP384R1
    ];
    PublicKeyFixtures fixtures;
    PublicKeyCoder coder;

    setUp(() {
      coder = PublicKeyCoder();
      fixtures = PublicKeyFixtures();
    });

    test('can be created as an empty key (used by pasc v2)', () {
      PublicKey pubkey = PublicKey.empty();

      expect(pubkey.curve.id, 0);
      expect(pubkey.x.length, 0);
      expect(pubkey.y.length, 0);
    });

    test('cannot be created with wronfues managed by the curve', () {
      curves.forEach((c) {
        Curve curve = Curve(c);

        expect(
            () => {
                  PublicKey(
                      PDUtil.hexToBytes(
                          List.filled(curve.xylPublicKey() + 1, '00').join()),
                      PDUtil.hexToBytes(
                          List.filled(curve.xylPublicKey(), '00').join()),
                      curve)
                },
            throwsException);
        expect(
            () => {
                  PublicKey(
                      PDUtil.hexToBytes(
                          List.filled(curve.xylPublicKey(), '00').join()),
                      PDUtil.hexToBytes(
                          List.filled(curve.xylPublicKey() + 1, '00').join()),
                      curve)
                },
            throwsException);
      });
    });

    test('can return a value only containing x and y', () {
      fixtures.curve714.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.ec()), c['x'] + c['y']);
      });
      fixtures.curve715.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.ec()), c['x'] + c['y']);
      });
      fixtures.curve716.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.ec()), c['x'] + c['y']);
      });
      fixtures.curve729.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.ec()), c['x'] + c['y']);
      });
    });
  });
}
