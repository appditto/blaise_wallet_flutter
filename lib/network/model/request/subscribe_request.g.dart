// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeRequest _$SubscribeRequestFromJson(Map<String, dynamic> json) {
  return SubscribeRequest(
    action: json['action'] as String,
    account: json['account'] as int,
    currency: json['currency'] as String,
    uuid: json['uuid'] as String,
    b58pubkey: json['b58_pubkey'] as String,
    fcmToken: json['fcm_token'] as String,
    notificationEnabled: json['notification_enabled'] as bool,
  );
}

Map<String, dynamic> _$SubscribeRequestToJson(SubscribeRequest instance) {
  final val = <String, dynamic>{
    'action': instance.action,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', instance.account);
  writeNotNull('currency', instance.currency);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('b58_pubkey', instance.b58pubkey);
  writeNotNull('fcm_token', instance.fcmToken);
  writeNotNull('notification_enabled', instance.notificationEnabled);
  return val;
}
