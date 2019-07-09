import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/core.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  @JsonKey(ignore:true)
  int id;
  @JsonKey(name:'name')
  String name;
  @JsonKey(name:'account', fromJson: intToAccountNum, toJson: accountNumToInt)
  AccountNumber account;
  @JsonKey(name:'payload')
  String payload;

  Contact({@required this.name, @required this.account, this.id, this.payload = ""});

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  bool operator ==(o) => o is Contact && o.name == name && o.account == account && o.payload == payload;
  int get hashCode => hash3(name.hashCode, account.hashCode, payload.hashCode);
}