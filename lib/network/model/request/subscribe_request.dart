import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscribe_request.g.dart';

@JsonSerializable()
class SubscribeRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'account', includeIfNull: false)
  int account;

  @JsonKey(name:'currency', includeIfNull: false)
  String currency;

  @JsonKey(name:'uuid', includeIfNull: false)
  String uuid;

  SubscribeRequest({this.action = "account_subscribe", this.account, this.currency, this.uuid}) : super();

  factory SubscribeRequest.fromJson(Map<String, dynamic> json) => _$SubscribeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeRequestToJson(this);
}