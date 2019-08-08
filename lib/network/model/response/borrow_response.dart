import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/pascaldart.dart';

part 'borrow_response.g.dart';

@JsonSerializable()
class BorrowResponse {
  @JsonKey(name:'pasa', fromJson: intToAccountNum, toJson: accountNumToInt)
  AccountNumber account;

  @JsonKey(
      name: 'expiry',
      fromJson: toDateTime,
      toJson: fromDateTime,
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