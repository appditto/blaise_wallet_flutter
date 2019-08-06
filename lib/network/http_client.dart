import 'package:blaise_wallet_flutter/network/model/request/borrow_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/getborrowed_request.dart';
import 'package:blaise_wallet_flutter/network/model/response/borrow_response.dart';
import 'package:blaise_wallet_flutter/network/model/response/getborrowed_response.dart';
import 'package:blaise_wallet_flutter/network/price/price_request.dart';
import 'package:blaise_wallet_flutter/network/price/price_response.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Blaise HTTP API Client
class HttpAPI {
  static const String API_URL = 'https://blaiseapi.appditto.com/v1';

  static Future<BorrowResponse> getBorrowed(String b58pubkey) async {
    try {
      GetBorrowedRequest request = GetBorrowedRequest(b58pubkey: b58pubkey);
      http.Response response = await http.post(API_URL, body: json.encode(request.toJson()));
      if (response.statusCode != 200) {
        return null;
      }
      Map<dynamic, dynamic> jsonResp = json.decode(response.body);
      if (jsonResp.containsKey('borrowed_account') && jsonResp['borrowed_account'] != '') {
        GetBorrowedResponse bResp = GetBorrowedResponse.fromJson(jsonResp);
        return bResp.account;
      } else if (jsonResp['borrowed_account'] == '') {
        return BorrowResponse();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<BorrowResponse> borrowAccount(String b58pubkey) async {
    try {
      BorrowRequest request = BorrowRequest(b58pubkey: b58pubkey);
      http.Response response = await http.post(API_URL, body: json.encode(request.toJson()));
      if (response.statusCode != 200) {
        return null;
      }
      Map<dynamic, dynamic> jsonResp = json.decode(response.body);
      if (jsonResp.containsKey('pasa')) {
        BorrowResponse bResp = BorrowResponse.fromJson(jsonResp);
        return bResp;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}