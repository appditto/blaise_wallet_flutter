import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

import './fixtures/privatekey.dart';

void main() {
  group('crypto.keys', () {
    final List<Curve> CURVE_INSTANCES = [
      Curve.fromString(Curve.CN_SECP256K1),
      Curve.fromString(Curve.CN_SECP384R1),
      Curve.fromString(Curve.CN_SECP521R1),
      Curve(Curve.CI_SECT283K1),
      Curve(0)
    ];

    PrivateKeyFixtures fixtures;

    setUp(() {
      fixtures = PrivateKeyFixtures();
    });
    test('can generate keypairs', () {
      CURVE_INSTANCES.forEach((curve) {
        if (curve.supported) {
          for (int i = 0; i < 100; i++) {
            KeyPair kp = Keys.generate(curve: curve);
            expect(kp is KeyPair, true);
            expect(kp.curve.id, curve.id);
            expect(
                PDUtil.byteToHex(
                    Keys.fromPrivateKey(kp.privateKey).publicKey.ec()),
                PDUtil.byteToHex(kp.publicKey.ec()));
          }
        }
      });
    });
    test('cannot generate unsupported curves', () {
      CURVE_INSTANCES.forEach((curve) {
        if (!curve.supported) {
          expect(() => Keys.generate(curve: curve), throwsUnsupportedError);
        }
      });
    });
    test('can retrieve a keypair from a private key', () {
      fixtures.curve714.forEach((c) {
        if (Curve(714).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 714);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(
              () => Keys.fromPrivateKey(PrivateKeyCoder()
                  .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']))),
              throwsException);
        }
      });
      fixtures.curve715.forEach((c) {
        if (Curve(715).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 715);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(
              () => Keys.fromPrivateKey(PrivateKeyCoder()
                  .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']))),
              throwsException);
        }
      });
      fixtures.curve716.forEach((c) {
        if (Curve(716).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 716);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(
              () => Keys.fromPrivateKey(PrivateKeyCoder()
                  .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']))),
              throwsException);
        }
      });
      fixtures.curve729.forEach((c) {
        if (Curve(729).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 729);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(
              () => Keys.fromPrivateKey(PrivateKeyCoder()
                  .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']))),
              throwsException);
        }
      });
    });
    test('can sign a value', () {
      fixtures.curve714.forEach((c) {
        if (Curve(714).supported && fixtures.curve714.indexOf(c) == 0) {
          PrivateKey pk = PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
          Signature sig = Keys.sign(pk, PDUtil.stringToBytesUtf8('test123'),
              hashMessage: false);
          expect(
              PDUtil.byteToHex(PDUtil.encodeBigInt(sig.r)),
              '4C3492DC3FB565D9D4C132575BCEAA55571491A983A82A5460E341198E38C250');
          expect(
              PDUtil.byteToHex(PDUtil.encodeBigInt(sig.s)),
              '7FA6FF43CD3B13F6E91F810FEF9BE6359CA355C53272C841D2BF934217EE53DE');
        }
      });
      fixtures.curve715.forEach((c) {
        if (Curve(715).supported && fixtures.curve715.indexOf(c) == 0) {
          PrivateKey pk = PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
          Signature sig = Keys.sign(pk, PDUtil.stringToBytesUtf8('test123'));
          expect(
              PDUtil.byteToHex(PDUtil.encodeBigInt(sig.r)).length == 96, true);
          expect(
              PDUtil.byteToHex(PDUtil.encodeBigInt(sig.s)).length == 96, true);
        }
      });
      fixtures.curve716.forEach((c) {
        if (Curve(716).supported && fixtures.curve716.indexOf(c) == 0) {
          PrivateKey pk = PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
          Signature sig = Keys.sign(pk, PDUtil.stringToBytesUtf8('test123'));
          expect(PDUtil.byteToHex(PDUtil.encodeBigInt(sig.r)).isNotEmpty, true);
          expect(PDUtil.byteToHex(PDUtil.encodeBigInt(sig.s)).isNotEmpty, true);
        }
      });
      fixtures.curve729.forEach((c) {
        if (Curve(729).supported) {
          PrivateKey pk = PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
          Signature sig = Keys.sign(pk, PDUtil.stringToBytesUtf8('test123'));
          expect(PDUtil.byteToHex(PDUtil.encodeBigInt(sig.r)).isNotEmpty, true);
          expect(PDUtil.byteToHex(PDUtil.encodeBigInt(sig.s)).isNotEmpty, true);
        }
      });
    });
    test('can retrieve a keypair from an encrypted private key', () {
      fixtures.curve714.forEach((c) {
        if (Curve(714).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(
              PDUtil.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 714);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(
                PDUtil.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });
      fixtures.curve715.forEach((c) {
        if (Curve(715).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(
              PDUtil.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 715);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(
                PDUtil.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });
      fixtures.curve716.forEach((c) {
        if (Curve(716).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(
              PDUtil.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 716);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(
                PDUtil.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });
      fixtures.curve729.forEach((c) {
        if (Curve(729).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(
              PDUtil.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 729);
          expect(
              PDUtil.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)),
              c['enc_privkey']);
          expect(
              PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(
                PDUtil.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });
    });
  });
}
