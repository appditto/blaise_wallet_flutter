import 'dart:async';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class IntroSettingsPage extends StatefulWidget {
  @override
  _IntroSettingsPageState createState() => _IntroSettingsPageState();
}

class _IntroSettingsPageState extends State<IntroSettingsPage> {
  bool _keyCopied;
  Timer _keyCopiedTimer;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _keyCopied = false;
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
              children: <Widget>[
                //A widget that holds welcome animation + paragraph
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          // Container for the gradient background
                          Container(
                            height: 121 +
                                (MediaQuery.of(context).padding.top) +
                                (24 - (MediaQuery.of(context).padding.top) / 2),
                            decoration: BoxDecoration(
                              gradient: StateContainer.of(context)
                                  .curTheme
                                  .gradientPrimary,
                            ),
                          ),
                          // Column for the rest
                          Column(
                            children: <Widget>[
                              // Container for the header and button
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                  top: (MediaQuery.of(context).padding.top) +
                                      (24 -
                                          (MediaQuery.of(context).padding.top) /
                                              2),
                                ),
                                // Row for back button and the header
                                child: Row(
                                  children: <Widget>[
                                    // Back Button
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(start: 10),
                                      height: 50,
                                      width: 50,
                                      child: FlatButton(
                                          highlightColor:
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .textLight15,
                                          splashColor:
                                              StateContainer.of(context)
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
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          4, 24, 24, 24),
                                      child: AutoSizeText(
                                        "Settings",
                                        style: AppStyles.header(context),
                                        maxLines: 1,
                                        stepGranularity: 0.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container for the list
                              Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
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
                                child: Column(
                                  children: <Widget>[
                                    // Preferences text
                                    Container(
                                      alignment: Alignment(-1, 0),
                                      margin: EdgeInsetsDirectional.only(
                                            start: 24, end: 24, top: 16, bottom: 8),
                                      child: AutoSizeText(
                                        "Preferences",
                                        style: AppStyles.settingsHeader(
                                            context),
                                        maxLines: 1,
                                        stepGranularity: 0.1,
                                      ),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 1,
                                      color: StateContainer.of(context).curTheme.textDark10,
                                    ),
                                    // List Item
                                    Container(
                                      width: double.maxFinite,
                                      height: 68,
                                      child: FlatButton(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 24, end: 24),
                                        onPressed: () {
                                          return null;
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Icon(AppIcons.currency,
                                                  size: 24,
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .primary),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      start: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    "Currency",
                                                    style: AppStyles
                                                        .settingsItemHeader(
                                                            context),
                                                    maxLines: 1,
                                                    stepGranularity: 0.1,
                                                  ),
                                                  AutoSizeText(
                                                    "\$ US Dollar",
                                                    style: AppStyles
                                                        .settingsItemSubHeader(
                                                            context),
                                                    maxLines: 1,
                                                    stepGranularity: 0.1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
