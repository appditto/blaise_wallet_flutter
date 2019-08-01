// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BorrowResponse _$BorrowResponseFromJson(Map<String, dynamic> json) {
  return BorrowResponse()
    ..account = intToAccountNum(json['pasa'] as int)
    ..expiry = toDateTime(json['expiry'] as int)
    ..price = pascalToCurrency(json['price'] as num);
}

Map<String, dynamic> _$BorrowResponseToJson(BorrowResponse instance) {
  final val = <String, dynamic>{
    'pasa': accountNumToInt(instance.account),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expiry', fromDateTime(instance.expiry));
  writeNotNull('price', currencyToDouble(instance.price));
  return val;
}
