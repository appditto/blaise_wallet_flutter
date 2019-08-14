import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/pin_screen.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';

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
                            // The header
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  30, 24, 30, 24),
                              child: AutoSizeText(
                                AppLocalization.of(context).backUpKeyHeader,
                                style: AppStyles.header(context),
                                maxLines: 3,
                                stepGranularity: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Container for the illustration
                            Container(
                              child: SvgRepaintAsset(
                                asset: StateContainer.of(context).curTheme.illustrationBackup,
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.width *
                                    0.6 *
                                    (183 / 230),
                              ),
                            ),
                            //Container for the paragraph
                            Container(
                              alignment: Alignment(-1, 0),
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  30, 30, 30, 12),
                              child: AutoSizeText(
                                AppLocalization.of(context).newKeyBackUpConfirmParagraph,
                                maxLines: 5,
                                stepGranularity: 0.1,
                                style: AppStyles.paragraph(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //"YES, I'M SURE" and "NO, GO BACK" buttons
                // "YES, I'M SURE" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: toUppercase(AppLocalization.of(context).yesImSureButton, context),
                      buttonTop: true,
                      onPressed: () {
                        sl
                            .get<SharedPrefsUtil>()
                            .setPrivateKeyBackedUp(true)
                            .then((_) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PinScreen(
                                      type: PinOverlayType.NEW_PIN,
                                      onSuccess: (pin) {
                                        sl.get<Vault>().setPin(pin).then((_) {
                                          walletState.requestUpdate();
                                          Navigator.of(context).pushNamedAndRemoveUntil(
                                              '/overview', (Route<dynamic> route) => false);                      
                                        });
                                      }
                                    );
                                  }
                                )
                              );
                        });
                      },
                    ),
                  ],
                ),
                // "No, Go Back" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: toUppercase(AppLocalization.of(context).noGoBackButton, context),
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
