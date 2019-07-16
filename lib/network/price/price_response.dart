import 'package:json_annotation/json_annotation.dart';

part 'price_response.g.dart';

double _toDouble(v) {
  return double.tryParse(v.toString());
}


@JsonSerializable()
class PriceResponse {
  @JsonKey(name:'price', fromJson: _toDouble)
  double price;

  PriceResponse({this.price});

  factory PriceResponse.fromJson(Map<String, dynamic> json) => _$PriceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PriceResponseToJson(this);
}