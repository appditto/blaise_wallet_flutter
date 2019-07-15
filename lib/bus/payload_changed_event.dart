import 'package:event_taxi/event_taxi.dart';

class PayloadChangedEvent implements Event {
  final String payload;

  PayloadChangedEvent({this.payload});
}