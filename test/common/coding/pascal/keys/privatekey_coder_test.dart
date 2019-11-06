import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/privatekey.dart';

void main() {
  group('common.coding.pascal.keys.PrivateKeyCoder', () {
    PrivateKeyCoder coder;
    PrivateKeyFixtures fixtures;

    setUp(() {
      coder = PrivateKeyCoder();
      fixtures = PrivateKeyFixtures();
    });
    test('can decode a pascalcoin private key', () {
      fixtures.curve714.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 714);
      });
      fixtures.curve715.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 715);
      });
      fixtures.curve716.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 716);
      });
      fixtures.curve729.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 729);
      });
    });
    test('can encode a pascalcoin private key', () {
      fixtures.curve714.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(PDUtil.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
      fixtures.curve715.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(PDUtil.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
      fixtures.curve716.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(PDUtil.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
      fixtures.curve729.forEach((c) {
        PrivateKey pk =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(PDUtil.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
    });
  });
}
