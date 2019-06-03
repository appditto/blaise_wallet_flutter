import 'package:pascaldart/pascaldart.dart';

/// A higher-level wrapper for pascaldart functions
class PascalUtil {
  /// Generates a new key pair
  KeyPair generateKeyPair() {
    return Keys.generate(curve: Curve.getDefaultCurve());
  }
}