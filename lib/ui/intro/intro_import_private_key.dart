import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class IntroImportPrivateKeyPage extends StatefulWidget {
  @override
  _IntroImportPrivateKeyPageState createState() =>
      _IntroImportPrivateKeyPageState();
}

class _IntroImportPrivateKeyPageState extends State<IntroImportPrivateKeyPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override

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
                        child: AppTextField(
                          label: "Private Key",
                          style: AppStyles.privateKeyPrimary(context),
                          firstButton: TextFieldButton(
                            icon: AppIcons.paste,
                            onPressed: () {
                              // Paste private key TODO
                            },
                          ),
                          secondButton: TextFieldButton(
                            icon: AppIcons.scan,
                            onPressed: () {
                              // Scan private key TODO
                            },
                          )
                        )
                      ),
                    ],
                  ),
                ),

                //"Import" and "Go Back" buttons
                // "Import" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.Primary,
                          text: "Import",
                          buttonTop: true,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/intro_decrypt_and_import_private_key');
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
      ),
    );
  }
}
