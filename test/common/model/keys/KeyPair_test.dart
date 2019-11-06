import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/privatekey.dart';

void main() {
  PrivateKeyCoder privCoder;
  PublicKeyCoder pubCoder;
  PrivateKeyFixtures fixtures;

  setUp(() {
    privCoder = PrivateKeyCoder();
    pubCoder = PublicKeyCoder();
    fixtures = PrivateKeyFixtures();
  });

  group('common.model.keys.KeyPair', () {
    test('can be created from a public and private key', () {
      fixtures.curve714.forEach((c) {
        PrivateKey priv =
            privCoder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        PublicKey pub = pubCoder.decodeFromBase58(c['b58_pubkey']);

        KeyPair kp = KeyPair(priv, pub);

        expect(pubCoder.encodeToBase58(kp.publicKey), c['b58_pubkey']);
        expect(PDUtil.byteToHex(privCoder.encodeToBytes(kp.privateKey)),
            c['enc_privkey']);
        expect(kp.curve.id, 714);
      });
    });
    test('does not allow different curves', () {
      fixtures.curve714.forEach((c) {
        PrivateKey priv =
            privCoder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        String b58wrong =
            'gD8AW4sifppye1utSGPZn2TpTkTXd1EAxGiGTfEEZe87JXCx7oCKFw3ew6hz8E5RB66NuMjSzp59qWu4YrwSEjBh4P9RSsb2Xhc5z7rA4feG5eCAz9mQYqCTQRYsDQHwtftCxMRB625c5X7b4';
        PublicKey pub = pubCoder.decodeFromBase58(b58wrong);

        expect(() => KeyPair(priv, pub), throwsException);
      });
      fixtures.curve715.forEach((c) {
        PrivateKey priv =
            privCoder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        String b58wrong =
            '3GhhbopVb9wfo4HzecYwKYMWRvLCssTeFWjocfnWv12Yt3GtaW3seeatH9GqhVmnYrF586RKLwjFFMYn7Txq8X2D4qT7CbqrZgbdRm';
        PublicKey pub = pubCoder.decodeFromBase58(b58wrong);

        expect(() => KeyPair(priv, pub), throwsException);
      });
      fixtures.curve716.forEach((c) {
        PrivateKey priv =
            privCoder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        String b58wrong =
            '3GhhbopVb9wfo4HzecYwKYMWRvLCssTeFWjocfnWv12Yt3GtaW3seeatH9GqhVmnYrF586RKLwjFFMYn7Txq8X2D4qT7CbqrZgbdRm';
        PublicKey pub = pubCoder.decodeFromBase58(b58wrong);

        expect(() => KeyPair(priv, pub), throwsException);
      });
      fixtures.curve729.forEach((c) {
        PrivateKey priv =
            privCoder.decodeFromBytes(PDUtil.hexToBytes(c['enc_privkey']));
        String b58wrong =
            '3GhhbopVb9wfo4HzecYwKYMWRvLCssTeFWjocfnWv12Yt3GtaW3seeatH9GqhVmnYrF586RKLwjFFMYn7Txq8X2D4qT7CbqrZgbdRm';
        PublicKey pub = pubCoder.decodeFromBase58(b58wrong);

        expect(() => KeyPair(priv, pub), throwsException);
      });
    });
  });
}
