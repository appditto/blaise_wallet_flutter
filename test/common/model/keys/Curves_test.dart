import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.model.keys.Curves', () {
    test('can be created from a number', () {
      Curve c = Curve(714); // secp256k1

      expect(c.id, 714);
      expect(c.name, 'secp256k1');

      c = Curve(715); // secp384r1
      expect(c.id, 715);
      expect(c.name, 'secp384r1');

      c = Curve(716); // secp521r1
      expect(c.id, 716);
      expect(c.name, 'secp521r1');

      c = Curve(729); // sect283k1
      expect(c.id, 729);
      expect(c.name, 'sect283k1');
    });
    test('can be created from a name', () {
      Curve c = Curve.fromString('secp256k1');

      expect(c.id, 714);
      expect(c.name, 'secp256k1');

      c = Curve.fromString('secp384r1');
      expect(c.id, 715);
      expect(c.name, 'secp384r1');

      c = Curve.fromString('secp521r1');
      expect(c.id, 716);
      expect(c.name, 'secp521r1');

      c = Curve.fromString('sect283k1');
      expect(c.id, 729);
      expect(c.name, 'sect283k1');
    });
    test('will return false for sect283k1 supported', () {
      expect(Curve(Curve.CI_SECT283K1).supported, false);
      expect(Curve(Curve.CI_SECP256K1).supported, true);
      expect(Curve(Curve.CI_SECP384R1).supported, true);
      expect(Curve(Curve.CI_SECP521R1).supported, true);
    });
    test('will throw an error with unknown curve', () {
      expect(() => Curve.fromString('abc'), throwsException);
      expect(() => Curve(100101), throwsException);
    });
    test('will return the name on toString()', () {
      Curve c = Curve.fromString('secp521r1');

      expect(c.toString(), 'secp521r1');
    });
    test('will return secp256k1 as default curve()', () {
      Curve c = Curve.getDefaultCurve();

      expect(c.id, 714);
      expect(c.name, 'secp256k1');
    });
    test('provides constants to access the name in a controlled manner', () {
      expect(Curve.CN_SECP256K1, 'secp256k1');
      expect(Curve.CN_SECP384R1, 'secp384r1');
      expect(Curve.CN_SECT283K1, 'sect283k1');
      expect(Curve.CN_SECP521R1, 'secp521r1');
    });
  });
}
