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

  @JsonKey(name:'fcm_token', includeIfNull: false)
  String fcmToken;

  @JsonKey(name:'enabled')
  bool enabled;

  FcmUpdateRequest({@required int account, @required String fcmToken, @required bool enabled}) : super() {
    this.action = 'fcm_update';
    this.account = account;
    this.fcmToken = fcmToken;
    this.enabled = enabled;
  }

  factory FcmUpdateRequest.fromJson(Map<String, dynamic> json) => _$FcmUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FcmUpdateRequestToJson(this);
}