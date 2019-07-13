import 'package:event_taxi/event_taxi.dart';

class DaemonChangedEvent implements Event {
  final String newDaemon;

  DaemonChangedEvent({this.newDaemon});
}