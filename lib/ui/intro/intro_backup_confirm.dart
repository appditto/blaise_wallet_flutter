import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroBackupConfirmPage extends StatefulWidget {
  @override
  _IntroBackupConfirmPageState createState() => _IntroBackupConfirmPageState();
}

class _IntroBackupConfirmPageState extends State<IntroBackupConfirmPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
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
                            // The header
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(4, 24, 4, 24),
                              child: AutoSizeText(
                                "Backup Your Key",
                                style: AppStyles.header(context),
                                maxLines: 1,
                                stepGranularity: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container for the illustration
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: SvgPicture.asset(
                            'assets/illustration_backup.svg',
                            width: MediaQuery.of(context).size.width / 1.75),
                      ),
                      //Container for the paragraph
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText(
                          "Are you sure that you have backed up your new wallet’s private key?",
                          maxLines: 5,
                          stepGranularity: 0.5,
                          style: AppStyles.paragraph(context),
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
                        AppButton.buildAppButton(
                            context, AppButtonType.Primary, "YES, I'M SURE",
                            buttonTop: true),
                      ],
                    ),
                    // "Go Back" button
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PrimaryOutline,
                            "NO, GO BACK", onPressed: () {
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
