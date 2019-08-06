import 'package:blaise_wallet_flutter/network/model/response/borrow_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/pascaldart.dart';

part 'getborrowed_response.g.dart';

@JsonSerializable()
class GetBorrowedResponse {
  @JsonKey(name:'borrowed_account')
  BorrowResponse account;

  GetBorrowedResponse();

  factory GetBorrowedResponse.fromJson(Map<String, dynamic> json) => _$GetBorrowedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetBorrowedResponseToJson(this);
}