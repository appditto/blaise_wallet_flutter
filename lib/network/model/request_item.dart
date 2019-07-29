import 'dart:convert';

/// Top-level function for running in isolate via flutter compute function
String encodeRequestItem(dynamic request) {
  return json.encode(request.toJson());
}

class RequestItem<T> {
  // After this time a request will expire
  static const int EXPIRE_TIME_S = 15;

  DateTime expireDt;
  bool isProcessing;
  T request;

  RequestItem(T request) {
    this.expireDt = DateTime.now().add(new Duration(seconds: EXPIRE_TIME_S));
    this.isProcessing = false;
    this.request = request;
  }
}