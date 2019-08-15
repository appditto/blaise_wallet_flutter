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

  @JsonKey(name:'b58_pubkey', includeIfNull: false)
  String b58pubkey;

  @JsonKey(name:'fcm_token', includeIfNull: false)
  String fcmToken;

  @JsonKey(name:'enabled')
  bool enabled;

  FcmUpdateBulkRequest({@required this.accounts, @required this.fcmToken, @required this.enabled, @required this.b58pubkey}) : super() {
    this.action = 'fcm_update_bulk';
  }

  factory FcmUpdateBulkRequest.fromJson(Map<String, dynamic> json) => _$FcmUpdateBulkRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FcmUpdateBulkRequestToJson(this);
}