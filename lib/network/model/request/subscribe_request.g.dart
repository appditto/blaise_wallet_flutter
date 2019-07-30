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
  return val;
}
