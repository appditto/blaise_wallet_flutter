import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'fcm_update_request.g.dart';

@JsonSerializable()
class FcmUpdateRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'account', includeIfNull: false)
  int account;

  @JsonKey(name:'b58_pubkey', includeIfNull: false)
  String b58pubkey;

  @JsonKey(name:'fcm_token', includeIfNull: false)
  String fcmToken;

  @JsonKey(name:'enabled')
  bool enabled;

  FcmUpdateRequest({@required this.account, @required this.fcmToken, @required this.enabled, @required this.b58pubkey}) : super() {
    this.action = 'fcm_update';
  }

  factory FcmUpdateRequest.fromJson(Map<String, dynamic> json) => _$FcmUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FcmUpdateRequestToJson(this);
}