import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:event_taxi/event_taxi.dart';

class ContactModifiedEvent implements Event {
  final Contact contact;

  ContactModifiedEvent({this.contact});
}