import 'package:pascaldart/common.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/operation_hash.dart';

void main() {
  group('common.coding.pascal.OperationHashCoder', () {
    OperationHashFixtures fixture;

    setUp(() {
      fixture = OperationHashFixtures();
    });
    test('can decode a pascalcoin Operationhash', () {
      fixture.hashes.forEach((hashData) {
        OperationHash oph = OperationHashCoder()
            .decodeFromBytes(PDUtil.hexToBytes(hashData['ophash']));

        expect(oph.block, hashData['block']);
        expect(oph.account.account, hashData['account']);
        expect(oph.nOperation, hashData['n_operation']);
        expect(
            PDUtil.byteToHex(oph.md160),
            hashData['ophash'].substring(
                hashData['ophash'].length - 40, hashData['ophash'].length));
      });
    });
    test('can encode a pascalcoin Operationhash', () {
      fixture.hashes.forEach((hashData) {
        OperationHash opHash = OperationHash(
            hashData['block'],
            hashData['account'],
            hashData['n_operation'],
            PDUtil.hexToBytes(hashData['ophash'].substring(
                hashData['ophash'].length - 40, hashData['ophash'].length)));
        String hex =
            PDUtil.byteToHex(OperationHashCoder().encodeToBytes(opHash));

        expect(hex, hashData['ophash']);
      });
    });
  });
}
