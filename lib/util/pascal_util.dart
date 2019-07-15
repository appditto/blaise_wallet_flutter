import 'package:pascaldart/pascaldart.dart';

/// A higher-level wrapper for pascaldart functions
class PascalUtil {
  /// Generates a new key pair
  KeyPair generateKeyPair() {
    return Keys.generate(curve: Curve.getDefaultCurve());
  }

  /// Turns a string into a pascal PublicKey object, returns null if invalid
  PublicKey decipherPublicKey(String publicKey) {
    try {
      PublicKey pubKey = PublicKeyCoder().decodeFromBase58(publicKey.trim());
      return pubKey;
    } catch (e) {
      try {
        PublicKey pubKey = PublicKeyCoder().decodeFromBytes(PDUtil.hexToBytes(publicKey.trim()));
        return pubKey;
      } catch (e) {
        return null;
      }
    }
  }
}