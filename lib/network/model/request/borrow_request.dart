import 'package:blaise_wallet_flutter/network/model/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'borrow_request.g.dart';

@JsonSerializable()
class BorrowRequest extends BaseRequest {
  @JsonKey(name:'action')
  String action;

  @JsonKey(name:'b58_pubkey')
  String b58pubkey;

  BorrowRequest({this.action = "borrow_account", this.b58pubkey}) : super();

  factory BorrowRequest.fromJson(Map<String, dynamic> json) => _$BorrowRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BorrowRequestToJson(this);
}