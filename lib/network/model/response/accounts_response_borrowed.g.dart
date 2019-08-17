// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_response_borrowed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsResponseBorrowed _$AccountsResponseBorrowedFromJson(
    Map<String, dynamic> json) {
  return AccountsResponseBorrowed(
    borrowedAccount: json['borrowed_account'] == null
        ? null
        : BorrowResponse.fromJson(
            json['borrowed_account'] as Map<String, dynamic>),
    borrowEligible: json['borrow_eligible'] as bool,
  )..accounts = (json['result'] as List)
      ?.map((e) =>
          e == null ? null : PascalAccount.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$AccountsResponseBorrowedToJson(
        AccountsResponseBorrowed instance) =>
    <String, dynamic>{
      'result': instance.accounts,
      'borrowed_account': instance.borrowedAccount,
      'borrow_eligible': instance.borrowEligible,
    };
