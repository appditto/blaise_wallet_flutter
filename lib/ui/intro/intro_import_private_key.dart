import 'dart:async';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class IntroImportPrivateKeyPage extends StatefulWidget {
  @override
  _IntroImportPrivateKeyPageState createState() =>
      _IntroImportPrivateKeyPageState();
}

class _IntroImportPrivateKeyPageState extends State<IntroImportPrivateKeyPage> {
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
                      // Container for the header
                      Container(
                        padding: EdgeInsetsDirectional.only(
                          top: (MediaQuery.of(context).padding.top) +
                              (24 - (MediaQuery.of(context).padding.top) / 2),
                        ),
                        decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                        ),
                        // Row for back button and the header
                        child: Row(
                          children: <Widget>[
                            // The header
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  30, 24, 30, 24),
                              child: AutoSizeText(
                                "Import Private Key",
                                style: AppStyles.header(context),
                                maxLines: 1,
                                stepGranularity: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Container for the paragraph
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        alignment: Alignment(-1, 0),
                        child: AutoSizeText(
                          "Enter your private key below.",
                          maxLines: 2,
                          stepGranularity: 0.1,
                          style: AppStyles.paragraph(context),
                        ),
                      ),
                      // Container for the text field
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(-1, 0),
                              child: AutoSizeText(
                                'Private Key',
                                style: AppStyles.textFieldLabel(context),
                              ),
                            ),
                            Container(
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  hintColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .primary15,
                                ),
                                child: TextField(
                                  style: AppStyles.privateKeyPrimary(context),
                                  cursorColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textInputAction: TextInputAction.done,
                                  maxLines: null,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                      height: 30,
                                      width: 70,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .gradientPrimary,
                                            ),
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              shape: CircleBorder(),
                                              onPressed: () {
                                                return null;
                                              },
                                              splashColor:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .backgroundPrimary30,
                                              highlightColor:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .backgroundPrimary15,
                                              child: Icon(
                                                AppIcons.scan,
                                                size: 18,
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .backgroundPrimary,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsetsDirectional.only(
                                                start: 10),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .gradientPrimary,
                                            ),
                                            child: FlatButton(
                                              padding: EdgeInsets.all(0),
                                              shape: CircleBorder(),
                                              onPressed: () {
                                                return null;
                                              },
                                              splashColor:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .backgroundPrimary30,
                                              highlightColor:
                                                  StateContainer.of(context)
                                                      .curTheme
                                                      .backgroundPrimary15,
                                              child: Icon(
                                                AppIcons.paste,
                                                size: 18,
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .backgroundPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //A column with "New Private Key" and "Import Private Key" buttons
                Column(
                  children: <Widget>[
                    // "I've Backed It Up" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.Primary,
                          text: "Import",
                          buttonTop: true,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/intro_backup_confirm');
                          },
                        ),
                      ],
                    ),
                    // "Go Back" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.PrimaryOutline,
                          text: "Go Back",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
