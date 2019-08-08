// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getborrowed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBorrowedResponse _$GetBorrowedResponseFromJson(Map<String, dynamic> json) {
  return GetBorrowedResponse()
    ..account = json['borrowed_account'] == null
        ? null
        : BorrowResponse.fromJson(
            json['borrowed_account'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetBorrowedResponseToJson(
        GetBorrowedResponse instance) =>
    <String, dynamic>{
      'borrowed_account': instance.account,
    };
