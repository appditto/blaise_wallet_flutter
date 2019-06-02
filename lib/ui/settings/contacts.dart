import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/settings_list_item.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
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
                    gradient:
                        StateContainer.of(context).curTheme.gradientPrimary,
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
                                      Navigator.pop(context);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
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
                                margin:
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 24, 0),
                                child: AutoSizeText(
                                  "Contacts",
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
                                      return null;
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(AppIcons.import_icon,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textLight,
                                        size: 24)),
                              ),
                              // Export Button
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 4, end: 12),
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
                                      return null;
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
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
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            StateContainer.of(context)
                                .curTheme
                                .shadowSettingsList,
                          ],
                        ),
                        // Settings List
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: Stack(
                            children: <Widget>[
                              ListView(
                                padding: EdgeInsetsDirectional.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom +
                                            12),
                                children: <Widget>[
                                  // List Items
                                  SettingsListItem(
                                    contactName: "@bbedward",
                                    contactAddress: "186418-64",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@herman",
                                    contactAddress: "212823-56",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@hugle",
                                    contactAddress: "581319-11",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@mosu_forge",
                                    contactAddress: "112131-21",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@odm4rk",
                                    contactAddress: "883103-20",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@redmonski",
                                    contactAddress: "102103-95",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@techworker",
                                    contactAddress: "191919-19",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                  SettingsListItem(
                                    contactName: "@yekta",
                                    contactAddress: "578706-79",
                                    contact: true,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    height: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark10,
                                  ),
                                ],
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
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary,
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
                                text: "Add Contact",
                                type: AppButtonType.Primary,
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
