import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('common.model.AccountNumber', () {
    test('can be created from a non-checksum pasa number', () {
      AccountNumber an = AccountNumber.fromInt(77);

      expect(an.toString(), '77-44');
    });
    test('can be created from a non-checksum pasa string', () {
      AccountNumber an = AccountNumber('77');

      expect(an.toString(), '77-44');
    });
    test('can be created from a checksummed pasa', () {
      AccountNumber an = AccountNumber('77-44');

      expect(an.toString(), '77-44');
    });
    test('will fail with an invalid account number', () {
      expect(() => AccountNumber('-77'), throwsException);
    });
    test('will fail with an invalid account checksum', () {
      expect(() => AccountNumber('77-33'), throwsException);
    });
    test('will deliver the correct block info', () {
      AccountNumber an = AccountNumber.fromInt(77);

      expect(an.createdInBlock, 15);
      an = AccountNumber.fromInt(75);
      expect(an.createdInBlock, 15);
      an = AccountNumber.fromInt(80);
      expect(an.createdInBlock, 16);
      an = AccountNumber.fromInt(0);
      expect(an.createdInBlock, 0);
    });
    test('will return the correct account number', () {
      AccountNumber an = AccountNumber.fromInt(77);

      expect(an.account, 77);
    });
    test('will return the correct checksum', () {
      AccountNumber an = AccountNumber.fromInt(77);

      expect(an.checksum, 44);
    });
    test('will detect if it is a developer reward account', () {
      AccountNumber an = AccountNumber.fromInt(77);

      expect(an.isFoundationReward, false);
      an = AccountNumber.fromInt(1050000);
      expect(an.isFoundationReward, false);

      // first dev reward account
      an = AccountNumber.fromInt(1050004);
      expect(an.isFoundationReward, true);
    });
    test('can compare account number objects', () {
      AccountNumber an = AccountNumber.fromInt(77);

      expect(an == AccountNumber.fromInt(77), true);
      an = AccountNumber.fromInt(77);
      expect(an == AccountNumber.fromInt(99), false);
    });
  });
}
