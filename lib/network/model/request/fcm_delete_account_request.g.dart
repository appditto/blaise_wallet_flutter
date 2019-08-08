// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_delete_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmDeleteAccountRequest _$FcmDeleteAccountRequestFromJson(
    Map<String, dynamic> json) {
  return FcmDeleteAccountRequest(
    account: json['account'] as int,
    fcmToken: json['fcm_token'] as String,
  )..action = json['action'] as String;
}

Map<String, dynamic> _$FcmDeleteAccountRequestToJson(
    FcmDeleteAccountRequest instance) {
  final val = <String, dynamic>{
    'action': instance.action,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', instance.account);
  writeNotNull('fcm_token', instance.fcmToken);
  return val;
}
