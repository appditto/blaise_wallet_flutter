// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmUpdateRequest _$FcmUpdateRequestFromJson(Map<String, dynamic> json) {
  return FcmUpdateRequest(
    account: json['account'] as int,
    fcmToken: json['fcm_token'] as String,
    enabled: json['enabled'] as bool,
    b58pubkey: json['b58_pubkey'] as String,
  )..action = json['action'] as String;
}

Map<String, dynamic> _$FcmUpdateRequestToJson(FcmUpdateRequest instance) {
  final val = <String, dynamic>{
    'action': instance.action,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', instance.account);
  writeNotNull('b58_pubkey', instance.b58pubkey);
  writeNotNull('fcm_token', instance.fcmToken);
  val['enabled'] = instance.enabled;
  return val;
}
