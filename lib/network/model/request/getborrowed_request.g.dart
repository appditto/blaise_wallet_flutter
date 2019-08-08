// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getborrowed_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBorrowedRequest _$GetBorrowedRequestFromJson(Map<String, dynamic> json) {
  return GetBorrowedRequest(
    action: json['action'] as String,
    b58pubkey: json['b58_pubkey'] as String,
  );
}

Map<String, dynamic> _$GetBorrowedRequestToJson(GetBorrowedRequest instance) =>
    <String, dynamic>{
      'action': instance.action,
      'b58_pubkey': instance.b58pubkey,
    };
