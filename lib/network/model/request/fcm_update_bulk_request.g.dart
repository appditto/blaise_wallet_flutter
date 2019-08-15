// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_update_bulk_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmUpdateBulkRequest _$FcmUpdateBulkRequestFromJson(Map<String, dynamic> json) {
  return FcmUpdateBulkRequest(
    accounts: (json['account'] as List)?.map((e) => e as int)?.toList(),
    fcmToken: json['fcm_token'] as String,
    enabled: json['enabled'] as bool,
    b58pubkey: json['b58_pubkey'] as String,
  )..action = json['action'] as String;
}

Map<String, dynamic> _$FcmUpdateBulkRequestToJson(
    FcmUpdateBulkRequest instance) {
  final val = <String, dynamic>{
    'action': instance.action,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', instance.accounts);
  writeNotNull('b58_pubkey', instance.b58pubkey);
  writeNotNull('fcm_token', instance.fcmToken);
  val['enabled'] = instance.enabled;
  return val;
}
