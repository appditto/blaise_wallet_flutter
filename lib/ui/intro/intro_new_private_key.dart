import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntroNewPrivateKeyPage extends StatefulWidget {
  @override
  _IntroNewPrivateKeyPageState createState() => _IntroNewPrivateKeyPageState();
}

class _IntroNewPrivateKeyPageState extends State<IntroNewPrivateKeyPage> {
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
                      gradient:
                          StateContainer.of(context).curTheme.gradientPrimary,
                    ),
                    // Row for back button and the header
                    child: Row(
                      children: <Widget>[
                        // The header
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          margin:
                              EdgeInsetsDirectional.fromSTEB(30, 24, 30, 24),
                          child: AutoSizeText(
                            AppLocalization.of(context).newPrivateKeyHeader,
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
                    alignment: Alignment(-1, 0),
                    margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                    child: AutoSizeText(
                      AppLocalization.of(context).newPrivateKeyParagraph,
                      maxLines: 5,
                      stepGranularity: 0.1,
                      style: AppStyles.paragraph(context),
                    ),
                  ),
                  // Container for the private key
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                    padding: EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1,
                          color: _keyCopied
                              ? StateContainer.of(context).curTheme.success15
                              : StateContainer.of(context).curTheme.primary15),
                      color: _keyCopied
                          ? StateContainer.of(context).curTheme.success10
                          : StateContainer.of(context).curTheme.primary10,
                    ),
                    child: FutureBuilder(
                        future: sl.get<Vault>().getPrivateKey(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return AutoSizeText(
                              snapshot.data,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              stepGranularity: 0.5,
                              style: _keyCopied
                                  ? AppStyles.privateKeySuccess(context)
                                  : AppStyles.privateKeyPrimary(context),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ),
                  // Container for the "Copy to Clipboard" button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: _keyCopied
                              ? StateContainer.of(context).curTheme.success
                              : StateContainer.of(context)
                                  .curTheme
                                  .backgroundPrimary,
                          boxShadow: [
                            StateContainer.of(context).curTheme.shadowTextDark,
                          ],
                        ),
                        margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        height: 40,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          child: AutoSizeText(
                            _keyCopied
                                ? AppLocalization.of(context).copiedButton
                                : AppLocalization.of(context).copyButton,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                            style: _keyCopied
                                ? AppStyles.buttonMiniSuccess(context)
                                : AppStyles.buttonMiniBg(context),
                          ),
                          splashColor: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary60,
                          highlightColor: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary30,
                          onPressed: () {
                            sl.get<Vault>().getPrivateKey().then((key) {
                              UserDataUtil.setSecureClipboardItem(key);
                            });
                            setState(() {
                              _keyCopied = true;
                            });
                            if (_keyCopiedTimer != null) {
                              _keyCopiedTimer.cancel();
                            }
                            _keyCopiedTimer =
                                Timer(const Duration(milliseconds: 1500), () {
                              if (mounted) {
                                setState(() {
                                  _keyCopied = false;
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //"I've Backed It Up" and "Go Back" buttons
            Row(
              children: <Widget>[
                AppButton(
                  type: AppButtonType.Primary,
                  text: AppLocalization.of(context).iHaveBackedItUpButton,
                  buttonTop: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/intro_backup_confirm');
                  },
                ),
              ],
            ),
            // "Go Back" button
            Row(
              children: <Widget>[
                AppButton(
                  type: AppButtonType.PrimaryOutline,
                  text: AppLocalization.of(context).goBackButton,
                  onPressed: () {
                    Navigator.of(context).pop();
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
