import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/settings/contacts/add_contact_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/contacts/contact_detail_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/settings_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ContactsPage extends StatefulWidget {
  final Account account;

  ContactsPage({this.account}) : super();

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final Logger log = sl.get<Logger>();

  List<Contact> _contacts;
  String documentsDirectory;

  StreamSubscription<ContactAddedEvent> _contactAddedSub;
  StreamSubscription<ContactRemovedEvent> _contactRemovedSub;

  void _registerBus() {
    // Contact added bus event
    _contactAddedSub = EventTaxiImpl.singleton()
        .registerTo<ContactAddedEvent>()
        .listen((event) {
      setState(() {
        _contacts.add(event.contact);
        //Sort by name
        _contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      });
      // Full update which includes downloading new monKey
      _updateContacts();
    });
    // Contact removed bus event
    _contactRemovedSub = EventTaxiImpl.singleton()
        .registerTo<ContactRemovedEvent>()
        .listen((event) {
      setState(() {
        _contacts.remove(event.contact);
      });
    });
  }

  void _destroyBus() {
    if (_contactAddedSub != null) {
      _contactAddedSub.cancel();
    }
    if (_contactRemovedSub != null) {
      _contactRemovedSub.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    // Populate contacts
    _contacts = [];
    _updateContacts();
    // Get FS directory for export
    getApplicationDocumentsDirectory().then((directory) {
      documentsDirectory = directory.path;
      setState(() {
        documentsDirectory = directory.path;
      });
      _updateContacts();
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void _updateContacts() {
    sl.get<DBHelper>().getContacts().then((contacts) {
      for (Contact c in contacts) {
        if (!_contacts.contains(c)) {
          setState(() {
            _contacts.add(c);
          });
        }
      }
      // Re-sort list
      setState(() {
        _contacts.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      });
    });
  }

  Future<void> _exportContacts() async {
    List<Contact> contacts = await sl.get<DBHelper>().getContacts();
    if (contacts.length == 0) {
      UIUtil.showSnackbar(
          AppLocalization.of(context).noContactsToExportError, context);
      return;
    }
    List<Map<String, dynamic>> jsonList = List();
    contacts.forEach((contact) {
      jsonList.add(contact.toJson());
    });
    DateTime exportTime = DateTime.now();
    String filename =
        "blaisecontacts_${exportTime.year}${exportTime.month}${exportTime.day}${exportTime.hour}${exportTime.minute}${exportTime.second}.txt";
    Directory baseDirectory = await getApplicationDocumentsDirectory();
    File contactsFile = File("${baseDirectory.path}/$filename");
    await contactsFile.writeAsString(json.encode(jsonList));
    UIUtil.cancelLockEvent();
    Share.shareFile(contactsFile);
  }

  Future<void> _importContacts() async {
    UIUtil.cancelLockEvent();
    String filePath = await FilePicker.getFilePath(
        type: FileType.custom, allowedExtensions: ["txt"]);
    File f = File(filePath);
    if (!await f.exists()) {
      UIUtil.showSnackbar(
          AppLocalization.of(context).failedToImportContactsError, context);
      return;
    }
    try {
      String contents = await f.readAsString();
      Iterable contactsJson = json.decode(contents);
      List<Contact> contacts = List();
      List<Contact> contactsToAdd = List();
      contactsJson.forEach((contact) {
        contacts.add(Contact.fromJson(contact));
      });
      for (Contact contact in contacts) {
        if (!await sl.get<DBHelper>().contactExistsWithName(contact.name) &&
            !await sl
                .get<DBHelper>()
                .contactExistsWithAccount(contact.account)) {
          // Contact doesnt exist, make sure name and address are valid
          if (contact.account != null &&
              contact.account.toString().length > 0) {
            if (contact.name.length <= 20) {
              contactsToAdd.add(contact);
            }
          }
        }
      }
      // Save all the new contacts and update states
      int numSaved = await sl.get<DBHelper>().saveContacts(contactsToAdd);
      if (numSaved > 0) {
        _updateContacts();
        EventTaxiImpl.singleton().fire(ContactModifiedEvent(
            contact: Contact(name: "", account: AccountNumber.fromInt(0))));
        UIUtil.showSnackbar(
            AppLocalization.of(context)
                .successfullyImportedContactsParagraph
                .replaceAll("%1", numSaved.toString()),
            context);
      } else {
        UIUtil.showSnackbar(
            AppLocalization.of(context).noContactsToImportError, context);
      }
    } catch (e) {
      log.e(e.toString());
      UIUtil.showSnackbar(
          AppLocalization.of(context).failedToImportContactsError, context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: <Widget>[
            // Container for the gradient background
            Container(
              height: 104 +
                  (MediaQuery.of(context).padding.top) +
                  (36 - (MediaQuery.of(context).padding.top) / 2),
              decoration: BoxDecoration(
                gradient: StateContainer.of(context).curTheme.gradientPrimary,
              ),
            ),
            // Column for the rest
            Column(
              children: <Widget>[
                // Container for the header and the buttons
                Container(
                  margin: EdgeInsetsDirectional.only(
                    top: (MediaQuery.of(context).padding.top) +
                        (36 - (MediaQuery.of(context).padding.top) / 2),
                    bottom: 8,
                  ),
                  // Row for the header and the buttons
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Back button and header
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Back Button
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 2),
                            height: 50,
                            width: 50,
                            child: FlatButton(
                                highlightColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight15,
                                splashColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight30,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(AppIcons.back,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textLight,
                                    size: 24)),
                          ),
                          // The header
                          Container(
                            width: MediaQuery.of(context).size.width - 200,
                            margin: EdgeInsetsDirectional.fromSTEB(4, 0, 24, 0),
                            child: AutoSizeText(
                              AppLocalization.of(context).contactsHeader,
                              style: AppStyles.header(context),
                              maxLines: 1,
                              stepGranularity: 0.1,
                            ),
                          ),
                        ],
                      ),
                      // Import and export buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // Import Button
                          Container(
                            height: 40,
                            width: 40,
                            child: FlatButton(
                                highlightColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight15,
                                splashColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight30,
                                onPressed: () {
                                  _importContacts();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(AppIcons.import_icon,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textLight,
                                    size: 24)),
                          ),
                          // Export Button
                          Container(
                            margin:
                                EdgeInsetsDirectional.only(start: 4, end: 12),
                            height: 40,
                            width: 40,
                            child: FlatButton(
                                highlightColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight15,
                                splashColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight30,
                                onPressed: () {
                                  _exportContacts();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(AppIcons.export_icon,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textLight,
                                    size: 24)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Expanded list
                Expanded(
                  // Container for the list
                  child: Container(
                    margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        StateContainer.of(context).curTheme.shadowSettingsList,
                      ],
                    ),
                    // Settings List
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Stack(
                        children: <Widget>[
                          ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsetsDirectional.only(
                                bottom:
                                    MediaQuery.of(context).padding.bottom + 12),
                            itemCount: _contacts.length,
                            itemBuilder: (context, index) {
                              return SettingsListItem(
                                contactName: _contacts[index].name,
                                contactAddress:
                                    _contacts[index].account.toString(),
                                contact: true,
                                onPressed: () {
                                  AppSheets.showBottomSheet(
                                      context: context,
                                      widget: ContactDetailSheet(
                                          contact: _contacts[index],
                                          account: widget.account));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bottom bar
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        StateContainer.of(context).curTheme.shadowBottomBar,
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsetsDirectional.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          AppButton(
                            text: AppLocalization.of(context).addContactButton,
                            type: AppButtonType.Primary,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context, widget: AddContactSheet());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
