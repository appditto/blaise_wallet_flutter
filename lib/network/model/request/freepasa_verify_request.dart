import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'freepasa_verify_request.g.dart';

@JsonSerializable()
class FreePASAVerifyRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'request_id')
  String requestId;

  @JsonKey(name:'code')
  String code;

  FreePASAVerifyRequest({@required this.requestId, @required this.code}) : super() {
    this.action = 'freepasa_verify';
  }

  factory FreePASAVerifyRequest.fromJson(Map<String, dynamic> json) => _$FreePASAVerifyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FreePASAVerifyRequestToJson(this);
}