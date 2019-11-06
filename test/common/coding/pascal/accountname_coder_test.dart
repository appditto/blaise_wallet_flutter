import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.coding.pascal.accountNameCoder', () {
    AccountNameCoder coderBS2;
    AccountNameCoder coderBS1;
    setUp(() {
      coderBS2 = AccountNameCoder();
      coderBS1 = AccountNameCoder(byteSize: 1);
    });
    test('can decode a pascalcoin account name', () {
      expect(
          coderBS2
              .decodeFromBytes(PDUtil.hexToBytes('040074657374'))
              .toString(),
          'test');
      expect(
          coderBS2.decodeFromBytes(PDUtil.hexToBytes('040074657374'))
              is AccountName,
          true);
      expect(
          coderBS1.decodeFromBytes(PDUtil.hexToBytes('0474657374')).toString(),
          'test');
      expect(
          coderBS1.decodeFromBytes(PDUtil.hexToBytes('0474657374'))
              is AccountName,
          true);
    });
    test('can encode a pascalcoin account name', () {
      expect(PDUtil.byteToHex(coderBS2.encodeToBytes(AccountName('test'))),
          '040074657374');
      expect(PDUtil.byteToHex(coderBS1.encodeToBytes(AccountName('test'))),
          '0474657374');
    });
  });
}
