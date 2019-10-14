// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freepasa_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreePASAVerifyRequest _$FreePASAVerifyRequestFromJson(
    Map<String, dynamic> json) {
  return FreePASAVerifyRequest(
    requestId: json['request_id'] as String,
    code: json['code'] as String,
  )..action = json['action'] as String;
}

Map<String, dynamic> _$FreePASAVerifyRequestToJson(
        FreePASAVerifyRequest instance) =>
    <String, dynamic>{
      'action': instance.action,
      'request_id': instance.requestId,
      'code': instance.code,
    };
