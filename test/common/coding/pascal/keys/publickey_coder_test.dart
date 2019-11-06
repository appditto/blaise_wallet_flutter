import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/publickey.dart';

void main() {
  group('common.coding.pascal.keys.PublicKeyCoder', () {
    PublicKeyCoder coder;
    PublicKeyFixtures fixtures;

    setUp(() {
      coder = PublicKeyCoder();
      fixtures = PublicKeyFixtures();
    });
    test('can decode a pascalcoin pubkey', () {
      fixtures.curve714.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
      fixtures.curve715.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
      fixtures.curve716.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
      fixtures.curve729.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
    });
    test('can decode a pascalcoin pubkey from base58', () {
      fixtures.curve714.forEach((c) {
        PublicKey key = coder.decodeFromBase58(c['b58_pubkey']);
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
      fixtures.curve715.forEach((c) {
        PublicKey key = coder.decodeFromBase58(c['b58_pubkey']);
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
      fixtures.curve716.forEach((c) {
        PublicKey key = coder.decodeFromBase58(c['b58_pubkey']);
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
      fixtures.curve729.forEach((c) {
        PublicKey key = coder.decodeFromBase58(c['b58_pubkey']);
        expect(PDUtil.byteToHex(key.x), c['x']);
        expect(PDUtil.byteToHex(key.y), c['y']);
        expect(key.curve.id, c['ec_nid']);
      });
    });
    test('can encode a pascalcoin pubkey', () {
      fixtures.curve714.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));
        expect(PDUtil.byteToHex(coder.encodeToBytes(key)), c['enc_pubkey']);
      });
      fixtures.curve715.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(PDUtil.byteToHex(coder.encodeToBytes(key)), c['enc_pubkey']);
      });
      fixtures.curve716.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(PDUtil.byteToHex(coder.encodeToBytes(key)), c['enc_pubkey']);
      });
      fixtures.curve729.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(PDUtil.byteToHex(coder.encodeToBytes(key)), c['enc_pubkey']);
      });
    });
    test('can encode a pascalcoin pubkey to base58', () {
      fixtures.curve714.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(coder.encodeToBase58(key), c['b58_pubkey']);
      });
      fixtures.curve715.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(coder.encodeToBase58(key), c['b58_pubkey']);
      });
      fixtures.curve716.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(coder.encodeToBase58(key), c['b58_pubkey']);
      });
      fixtures.curve729.forEach((c) {
        PublicKey key =
            coder.decodeFromBytes(PDUtil.hexToBytes(c['enc_pubkey']));

        expect(coder.encodeToBase58(key), c['b58_pubkey']);
      });
    });
  });
}
