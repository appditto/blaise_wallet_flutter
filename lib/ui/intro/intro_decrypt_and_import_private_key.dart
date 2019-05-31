import 'dart:async';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class IntroDecryptAndImportPrivateKeyPage extends StatefulWidget {
  @override
  _IntroDecryptAndImportPrivateKeyPageState createState() =>
      _IntroDecryptAndImportPrivateKeyPageState();
}

class _IntroDecryptAndImportPrivateKeyPageState extends State<IntroDecryptAndImportPrivateKeyPage> {
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
                                "Decrypt & Import",
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
                          "This looks like an encrypted private key, please enter the password to decrypt and import it.",
                          maxLines: 3,
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
                                'Password',
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
                                  textSelectionColor: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                ),
                                child: TextField(
                                  obscureText: true,
                                  style: AppStyles.privateKeyPrimary(context),
                                  cursorColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 1,
                                  minLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //A column with "Import" and "Go Back" buttons
                Column(
                  children: <Widget>[
                    // "Import" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.Primary,
                          text: "Import",
                          buttonTop: true,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/accounts');
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
