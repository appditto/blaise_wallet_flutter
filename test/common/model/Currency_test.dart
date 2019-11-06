import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.model.Currency', () {
    test('can be created from various types', () {
      Currency c = Currency('1');
      expect(c.toStringOpt(), '1');
      c = Currency('1.1');
      expect(c.toStringOpt(), '1.1');
      c = Currency('1.1110');
      expect(c.toStringOpt(), '1.111');
    });
    test('can add', () {
      Currency c1 = Currency('1.1');
      Currency c2 = Currency('1.2');

      expect((c1 + c2).toStringOpt(), '2.3');
    });
    test('can sub', () {
      Currency c1 = Currency('1.2');
      Currency c2 = Currency('1.1');

      expect((c1 - c2).toStringOpt(), '0.1');
    });
    test('can output a fixed decimal', () {
      Currency c1 = Currency('1.2');

      expect(c1.toString(), '1.2000');
    });
    test('can output a optimized decimal', () {
      Currency c1 = Currency('1.2000');

      expect(c1.toStringOpt(), '1.2');
    });
    test('can output molina', () {
      Currency c1 = Currency('1.2000');

      expect(c1.toMolina(), "12000");
    });
    test('can handle negatives', () {
      Currency c1 = Currency('-1.2000');
      Currency c2 = Currency((-0.0001).toString());
      expect(c1.toMolina(), "-12000");
      expect(c1.toStringOpt(), "-1.2");
      expect(c2.toStringOpt(), '-0.0001');
    });
    test('can make a negative value positive', () {
      Currency c1 = Currency('-1.2000');

      expect(c1.toPositive().toMolina(), "12000");
    });
    test('skips when a positive value should be converted to positive', () {
      Currency c1 = Currency('1.2000');

      expect(c1.toPositive().toMolina(), "12000");
    });
    test('can compare values if they are equal', () {
      Currency c1 = Currency('1.2000');
      Currency c2 = Currency('1.2000');
      Currency c3 = Currency('1.3000');
      Currency c4 = Currency('-1.2000');

      expect(c1 == c2, true);
      expect(c1 == c3, false);
      expect(c1 == c4, false);
    });
    test('can compare values if they are lower', () {
      Currency c1 = Currency('1.2000');
      Currency c2 = Currency('1.2000');
      Currency c3 = Currency('1.3000');
      Currency c4 = Currency('-1.2000');

      expect(c1 < c2, false);
      expect(c1 < c3, true);
      expect(c1 < c4, false);
    });

    test('can compare values if they are greater', () {
      Currency c1 = Currency('1.2000');
      Currency c2 = Currency('1.2000');
      Currency c3 = Currency('1.3000');
      Currency c4 = Currency('-1.2000');

      expect(c1 > c2, false);
      expect(c1 > c3, false);
      expect(c1 > c4, true);
    });

    test('can compare values if they are greater or equal', () {
      Currency c1 = Currency('1.2000');
      Currency c2 = Currency('1.2000');
      Currency c3 = Currency('1.3000');
      Currency c4 = Currency('-1.2000');

      expect(c1 >= c2, true);
      expect(c1 >= c3, false);
      expect(c1 >= c4, true);
    });

    test('can compare values if they are lower or equal', () {
      Currency c1 = Currency('1.2000');
      Currency c2 = Currency('1.2000');
      Currency c3 = Currency('1.3000');
      Currency c4 = Currency('-1.2000');

      expect(c1 <= c2, true);
      expect(c1 <= c3, true);
      expect(c1 <= c4, false);
    });
  });
}
