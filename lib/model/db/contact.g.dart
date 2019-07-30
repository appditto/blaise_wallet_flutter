// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    name: json['name'] as String,
    account: intToAccountNum(json['account'] as int),
    payload: json['payload'] as String,
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'account': accountNumToInt(instance.account),
      'payload': instance.payload,
    };
