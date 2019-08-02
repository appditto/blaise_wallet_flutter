import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'fcm_update_bulk_request.g.dart';

@JsonSerializable()
class FcmUpdateBulkRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'account', includeIfNull: false)
  List<int> accounts;

  @JsonKey(name:'fcm_token', includeIfNull: false)
  String fcmToken;

  @JsonKey(name:'enabled')
  bool enabled;

  FcmUpdateBulkRequest({@required List<int> accounts, @required String fcmToken, @required bool enabled}) : super() {
    this.action = 'fcm_update_bulk';
    this.accounts = accounts;
    this.fcmToken = fcmToken;
    this.enabled = enabled;
  }

  factory FcmUpdateBulkRequest.fromJson(Map<String, dynamic> json) => _$FcmUpdateBulkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FcmUpdateBulkRequestToJson(this);
}