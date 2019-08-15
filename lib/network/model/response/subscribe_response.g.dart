// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeResponse _$SubscribeResponseFromJson(Map<String, dynamic> json) {
  return SubscribeResponse()
    ..uuid = json['uuid'] as String
    ..price = _toDouble(json['price'])
    ..btcPrice = _toDouble(json['btc'])
    ..borrowEligible = json['borrow_eligible'] as bool ?? false;
}

Map<String, dynamic> _$SubscribeResponseToJson(SubscribeResponse instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'price': instance.price,
      'btc': instance.btcPrice,
      'borrow_eligible': instance.borrowEligible,
    };
