import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class IntroNewPrivateKeyPage extends StatefulWidget {
  @override
  _IntroNewPrivateKeyPageState createState() => _IntroNewPrivateKeyPageState();
}

class _IntroNewPrivateKeyPageState extends State<IntroNewPrivateKeyPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
                        child: Row(
                          children: <Widget>[
                            // Back Button
                            Container(
                              margin: EdgeInsetsDirectional.only(start: 10),
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
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(4, 24, 4, 24),
                              child: AutoSizeText(
                                "New Private Key",
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
                        child: AutoSizeText(
                          "Below is your new wallet’s private key. It is crucial that you backup your private key and never store it as plaintext or a screenshot. We recommend writing it on a piece of paper and storing it offline.",
                          maxLines: 5,
                          stepGranularity: 0.5,
                          style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.textDark,
                              fontSize: 14.0,
                              height: 1.3,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      // Container for the seed
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                        padding: EdgeInsetsDirectional.fromSTEB(32, 16, 32, 16),
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .primary15),
                          color: StateContainer.of(context).curTheme.primary10,
                        ),
                        child: AutoSizeText(
                          "CA02200046B7A086680D208272F6982F574FE226042F30D049F9A226283FC3346506411D",
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          stepGranularity: 0.5,
                          style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              fontSize: 14.0,
                              height: 1,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SourceCodePro'),
                        ),
                      ),
                      // Container for the "Copy to Clipboard" button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundPrimary,
                              boxShadow: [
                                StateContainer.of(context)
                                    .curTheme
                                    .shadowSecondary,
                              ],
                            ),
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                            height: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              child: AutoSizeText(
                                "Copy to Clipboard",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                stepGranularity: 0.1,
                                style: AppStyles.buttonMiniBg(context),
                              ),
                              splashColor:
                                  StateContainer.of(context).curTheme.primary30,
                              highlightColor:
                                  StateContainer.of(context).curTheme.primary15,
                              onPressed: () {
                                return null;
                              },
                            ),
                          ),
                        ],
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
                        AppButton.buildAppButton(context, AppButtonType.Primary,
                            "I've Backed It Up", buttonTop: true),
                      ],
                    ),
                    // "Go Back" button
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context, AppButtonType.PrimaryOutline, "Go Back",
                            onPressed: () {
                          Navigator.pop(context);
                        }),
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
