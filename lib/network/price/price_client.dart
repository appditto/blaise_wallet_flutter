import 'package:blaise_wallet_flutter/network/price/price_request.dart';
import 'package:blaise_wallet_flutter/network/price/price_response.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceAPI {
  static const String API_URL = 'https://blaiseapi.appditto.com/v1';

  static Future<String> getAndCacheAPIResponse(Map<String, dynamic> requestJson) async {
    http.Response response = await http.post(API_URL, body: json.encode(requestJson));
    if (response.statusCode != 200) {
      return null;
    }
    await sl.get<SharedPrefsUtil>().setPriceAPICache(response.body);
    return response.body;
  }

  static Future<double> getPrice() async {
    try {
    String httpResponseBody = await getAndCacheAPIResponse(PriceRequest().toJson());
    if (httpResponseBody == null) {
      return null;
    }
    PriceResponse resp = PriceResponse.fromJson(json.decode(httpResponseBody));
    return resp.price;
    } catch (e) {
      return null;
    } 
  }

  static Future<double> getCachedPrice() async {
    String rawJson = await sl.get<SharedPrefsUtil>().getPriceAPICache();
    if (rawJson == null) {
      return null;
    }
    PriceResponse resp = PriceResponse.fromJson(json.decode(rawJson));
    return resp.price;  
  }
}