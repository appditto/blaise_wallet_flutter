// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BorrowRequest _$BorrowRequestFromJson(Map<String, dynamic> json) {
  return BorrowRequest(
    action: json['action'] as String,
    b58pubkey: json['b58_pubkey'] as String,
  );
}

Map<String, dynamic> _$BorrowRequestToJson(BorrowRequest instance) =>
    <String, dynamic>{
      'action': instance.action,
      'b58_pubkey': instance.b58pubkey,
    };
