import 'package:blaise_wallet_flutter/network/model/response/borrow_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/pascaldart.dart';

part 'accounts_response_borrowed.g.dart';

@JsonSerializable()
class AccountsResponseBorrowed extends AccountsResponse {
  @JsonKey(name: 'borrowed_account')
  BorrowResponse borrowedAccount;

  @JsonKey(name: 'borrow_eligible')
  bool borrowEligible;

  AccountsResponseBorrowed({this.borrowedAccount, this.borrowEligible}) : super();

  factory AccountsResponseBorrowed.fromJson(Map<String, dynamic> json) => _$AccountsResponseBorrowedFromJson(json);
  Map<String, dynamic> toJson() => _$AccountsResponseBorrowedToJson(this);
}