import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'freepasa_get_request.g.dart';

@JsonSerializable()
class FreePASAGetRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'phone_iso')
  String phoneIso;

  @JsonKey(name:'phone_number')
  String phoneNumber;

  @JsonKey(name:'b58_pubkey')
  String b58pubkey;


  FreePASAGetRequest({@required this.phoneIso, @required this.phoneNumber, @required this.b58pubkey}) : super() {
    this.action = 'freepasa_get';
  }

  factory FreePASAGetRequest.fromJson(Map<String, dynamic> json) => _$FreePASAGetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FreePASAGetRequestToJson(this);
}