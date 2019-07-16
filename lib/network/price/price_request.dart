import 'package:json_annotation/json_annotation.dart';

part 'price_request.g.dart';

@JsonSerializable()
class PriceRequest {
  @JsonKey(name:'action')
  String action;

  PriceRequest({this.action = 'price_data'});

  factory PriceRequest.fromJson(Map<String, dynamic> json) => _$PriceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PriceRequestToJson(this);
}