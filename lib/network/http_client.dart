import 'package:blaise_wallet_flutter/network/model/request/borrow_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/freepasa_get_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/freepasa_verify_request.dart';
import 'package:blaise_wallet_flutter/network/model/request/getborrowed_request.dart';
import 'package:blaise_wallet_flutter/network/model/response/borrow_response.dart';
import 'package:blaise_wallet_flutter/network/model/response/getborrowed_response.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

/// Blaise HTTP API Client
class HttpAPI {
  static const String API_URL = 'https://blaiseapi.appditto.com/v1';
  static Logger log = sl.get<Logger>();


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

  /// Request a FreePASA, using phone number
  /// Response is a request ID, which can be used in the verify phone number request
  static Future<String> getFreePASA(String isoCode, String phoneNumber, String b58pubkey) async {
    try {
      FreePASAGetRequest request = FreePASAGetRequest(
        phoneIso: isoCode,
        phoneNumber: phoneNumber,
        b58pubkey: b58pubkey
      );
      http.Response response = await http.post(API_URL, body: json.encode(request.toJson()));
      if (response.statusCode != 200) {
        return null;
      }
      Map<dynamic, dynamic> jsonResp = json.decode(response.body);
      if (jsonResp.containsKey('success')) {
        return jsonResp['success'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Verify a FreePASA, using phone number
  /// Response is the account that has been received
  static Future<int> verifyFreePASA(String requestId, String code) async {
    try {
      FreePASAVerifyRequest request = FreePASAVerifyRequest(
        requestId: requestId,
        code: code
      );
      http.Response response = await http.post(API_URL, body: json.encode(request.toJson()));
      if (response.statusCode != 200) {
        log.d("RECEIVED STATUS CODE NOT OK ${response.statusCode}");
        return null;
      }
      Map<dynamic, dynamic> jsonResp = json.decode(response.body);
      log.d("Received response ${response.body}");
      if (jsonResp.containsKey('success')) {
        log.d("New account is ${jsonResp['success']}");
        return int.parse(jsonResp['success'].toString());
      }
      return null;
    } catch (e) {
      log.e("Caughe exception in freepasa request ${e.toString()}", e);
      return null;
    }
  }
}