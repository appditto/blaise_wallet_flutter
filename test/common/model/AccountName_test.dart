import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.model.AccountName', () {
    test('can be initialized with a valid start pascal64 string', () {
      String startStr =
          r'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-+{}[]_:"|<>,.?/~';
      AccountName name = AccountName(startStr);
      expect(name.accountName, startStr);
    });
    test('cannot be initialized with an invalid char', () {
      for (int i = 0; i < 32; i++) {
        expect(() => AccountName(String.fromCharCode(i)), throwsException);
      }
    });
    test('will skip empty validation', () {
      AccountName a1 = AccountName('');

      expect(a1.toString(), '');
    });
    test('will throw an error if the encoding starts with a number', () {
      for (int i = 0; i < 10; i++) {
        expect(() => AccountName(i.toString() + 'techworker'), throwsException);
      }
    });
    test('will throw an error if the name is not at least 3 characters', () {
      expect(() => AccountName('t'), throwsException);
      expect(() => AccountName('te'), throwsException);
    });
    test('will throw an error if a wrong char is used beyond 3 chars', () {
      expect(() => AccountName('techä'), throwsException);
    });
    test('will escape certain characters', () {
      expect(AccountName('(abc').toStringEscaped(), '\\(abc');
      expect(AccountName(')abc').toStringEscaped(), '\\)abc');
      expect(AccountName('{abc').toStringEscaped(), '\\{abc');
      expect(AccountName('}abc').toStringEscaped(), '\\}abc');
      expect(AccountName('[abc').toStringEscaped(), '\\[abc');
      expect(AccountName(']abc').toStringEscaped(), '\\]abc');
      expect(AccountName(':abc').toStringEscaped(), '\\:abc');
      expect(AccountName('"abc').toStringEscaped(), '\\"abc');
      expect(AccountName('<abc').toStringEscaped(), '\\<abc');
      expect(AccountName('>abc').toStringEscaped(), '\\>abc');
    });
    test('will get a value identifying an escape sequence', () {
      expect(AccountName.isEscape('\\', '('), true);
      expect(AccountName.isEscape('\\', ')'), true);
      expect(AccountName.isEscape('\\', '{'), true);
      expect(AccountName.isEscape('\\', '}'), true);
      expect(AccountName.isEscape('\\', '['), true);
      expect(AccountName.isEscape('\\', ']'), true);
      expect(AccountName.isEscape('\\', ':'), true);
      expect(AccountName.isEscape('\\', '"'), true);
      expect(AccountName.isEscape('\\', '<'), true);
      expect(AccountName.isEscape('\\', '>'), true);

      expect(AccountName.isEscape('\\', 'A'), false);
      expect(AccountName.isEscape('\\', 'B'), false);
      expect(AccountName.isEscape('\\', 'C'), false);
      expect(AccountName.isEscape('\\', '1'), false);
      expect(AccountName.isEscape('\\', '2'), false);
      expect(AccountName.isEscape('\\', '3'), false);
    });
  });
}
