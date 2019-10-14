// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freepasa_get_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreePASAGetRequest _$FreePASAGetRequestFromJson(Map<String, dynamic> json) {
  return FreePASAGetRequest(
    phoneIso: json['phone_iso'] as String,
    phoneNumber: json['phone_number'] as String,
    b58pubkey: json['b58_pubkey'] as String,
  )..action = json['action'] as String;
}

Map<String, dynamic> _$FreePASAGetRequestToJson(FreePASAGetRequest instance) =>
    <String, dynamic>{
      'action': instance.action,
      'phone_iso': instance.phoneIso,
      'phone_number': instance.phoneNumber,
      'b58_pubkey': instance.b58pubkey,
    };
