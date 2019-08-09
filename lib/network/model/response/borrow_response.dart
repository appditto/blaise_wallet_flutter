import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/pascaldart.dart';

part 'borrow_response.g.dart';

DateTime _toDateTime(int v) {
  return v == null ? null : DateTime.fromMillisecondsSinceEpoch(v);
}

int _fromDateTime(DateTime v) {
  return v?.millisecondsSinceEpoch;
}

@JsonSerializable()
class BorrowResponse {
  @JsonKey(name:'pasa', fromJson: intToAccountNum, toJson: accountNumToInt)
  AccountNumber account;

  @JsonKey(
      name: 'expires',
      fromJson: _toDateTime,
      toJson: _fromDateTime,
      includeIfNull: false)
  DateTime expiry;

  @JsonKey(
      name: 'price',
      includeIfNull: false,
      toJson: currencyToDouble,
      fromJson: pascalToCurrency)
  Currency price;

  @JsonKey(name: 'paid')
  bool paid;

  @JsonKey(name: 'transferred')
  bool transferred;

  BorrowResponse();

  factory BorrowResponse.fromJson(Map<String, dynamic> json) => _$BorrowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BorrowResponseToJson(this);
}