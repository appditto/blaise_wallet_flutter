import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'fcm_delete_account_request.g.dart';

@JsonSerializable()
class FcmDeleteAccountRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'account', includeIfNull: false)
  int account;

  @JsonKey(name:'fcm_token', includeIfNull: false)
  String fcmToken;

  FcmDeleteAccountRequest({@required int account, @required String fcmToken}) : super() {
    this.action = 'fcm_update';
    this.account = account;
    this.fcmToken = fcmToken;
  }

  factory FcmDeleteAccountRequest.fromJson(Map<String, dynamic> json) => _$FcmDeleteAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FcmDeleteAccountRequestToJson(this);
}