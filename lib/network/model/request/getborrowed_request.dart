import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getborrowed_request.g.dart';

@JsonSerializable()
class GetBorrowedRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'b58_pubkey')
  String b58pubkey;

  GetBorrowedRequest({this.action = "getborrowed", this.b58pubkey}) : super();

  factory GetBorrowedRequest.fromJson(Map<String, dynamic> json) => _$GetBorrowedRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetBorrowedRequestToJson(this);
}