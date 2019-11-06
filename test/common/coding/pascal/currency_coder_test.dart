import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.coding.pascal.CurrencyCoder', () {
    CurrencyCoder coder;
    setUp(() {
      coder = CurrencyCoder();
    });
    test('can encode a pascalcoin currency', () {
      expect(PDUtil.byteToHex(coder.encodeToBytes(Currency('0.0015'))),
          '0F00000000000000');
    });
    test('can decode a pascalcoin currency', () {
      expect(
          coder
              .decodeFromBytes(PDUtil.hexToBytes('0F00000000000000'))
              .toString(),
          '0.0015');
      expect(
          coder.decodeFromBytes(
              PDUtil.hexToBytes('0474657374'.padRight(16, '0'))) is Currency,
          true);
    });
  });
}
