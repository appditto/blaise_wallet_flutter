import 'package:event_taxi/event_taxi.dart';
import 'package:pascaldart/pascaldart.dart';

class NewOperationEvent implements Event {
  final PascalOperation operation;

  NewOperationEvent({this.operation});
}