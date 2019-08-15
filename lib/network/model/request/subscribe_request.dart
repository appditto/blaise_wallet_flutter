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

  @JsonKey(name:'b58_pubkey', includeIfNull: false)
  String b58pubkey;

  @JsonKey(name:'fcm_token', includeIfNull: false)
  String fcmToken;

  @JsonKey(name:'notification_enabled', includeIfNull: false)
  bool notificationEnabled;

  SubscribeRequest({this.action = "account_subscribe", this.account, this.currency, this.uuid, this.b58pubkey, this.fcmToken, this.notificationEnabled}) : super();

  factory SubscribeRequest.fromJson(Map<String, dynamic> json) => _$SubscribeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribeRequestToJson(this);
}