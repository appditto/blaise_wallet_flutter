import 'package:json_annotation/json_annotation.dart';

part 'subscribe_response.g.dart';

double _toDouble(v) {
  return double.tryParse(v.toString());
}

/// For running in an isolate, needs to be top-level function
SubscribeResponse subscribeResponseFromJson(Map<dynamic, dynamic> json) {
  return SubscribeResponse.fromJson(json);
} 

@JsonSerializable()
class SubscribeResponse {
  // Server provides a uuid for each connection
  @JsonKey(name:'uuid')
  String uuid;

  @JsonKey(name:'price', fromJson:_toDouble)
  double price;

  @JsonKey(name:'btc', fromJson:_toDouble)
  double btcPrice;

  @JsonKey(name:'borrow_eligible', defaultValue: false)
  bool borrowEligible;

  SubscribeResponse();

  factory SubscribeResponse.fromJson(Map<String, dynamic> json) => _$SubscribeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeResponseToJson(this);
}