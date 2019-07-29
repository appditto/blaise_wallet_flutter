import 'package:blaise_wallet_flutter/network/model/response/subscribe_response.dart';
import 'package:event_taxi/event_taxi.dart';

class SubscribeEvent implements Event {
  final SubscribeResponse response;

  SubscribeEvent({this.response});
}