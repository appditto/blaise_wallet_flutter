
import 'package:event_taxi/event_taxi.dart';

enum AUTH_EVENT_TYPE { SEND, TRANSFER, CHANGE, BACKUP, LIST_FORSALE, DELIST_FORSALE }

class AuthenticatedEvent implements Event {
  final AUTH_EVENT_TYPE authType;

  AuthenticatedEvent(this.authType);
}