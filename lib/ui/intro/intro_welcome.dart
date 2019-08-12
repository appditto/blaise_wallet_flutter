import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/available_languages.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class IntroWelcomePage extends StatefulWidget {
  @override
  _IntroWelcomePageState createState() => _IntroWelcomePageState();
}

class _IntroWelcomePageState extends State<IntroWelcomePage> {

  List<DialogListItem> getLanguageList() {
    List<DialogListItem> ret = [];
    AvailableLanguage.values.forEach((AvailableLanguage value) {
      LanguageSetting setting = LanguageSetting(value);
      ret.add(DialogListItem(
          option: setting.getDisplayName(context),
          action: () {
            if (setting != StateContainer.of(context).curLanguage) {
              sl
                  .get<SharedPrefsUtil>()
                  .setLanguage(setting)
                  .then((result) {
                StateContainer.of(context).updateLanguage(setting);
              });
            }
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: <Widget>[
            //A widget that holds welcome animation + paragraph
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // A stack for background gradient and the animation
                  Stack(
                    children: <Widget>[
                      // Container for the gradient background
                      Container(
                        height: (MediaQuery.of(context).padding.top +
                                (MediaQuery.of(context).size.width *
                                    262 /
                                    400)) -
                            (MediaQuery.of(context).size.width * 80 / 400),
                        decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                        ),
                      ),
                      //Container for the animation
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).padding.top),
                        //Width/Height ratio for the animation is needed because BoxFit is not working as expected
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.width * 262 / 400,
                        child: Center(
                          child: FlareActor(
                            StateContainer.of(context)
                                .curTheme
                                .animationWelcome,
                            animation: "main",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Container for the paragraph
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: AutoSizeText(
                            AppLocalization.of(context).welcomeParagraph,
                            maxLines: 4,
                            stepGranularity: 0.1,
                            style: AppStyles.paragraph(context),
                          ),
                        ),
                        // "Language" button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundPrimary,
                                boxShadow: [
                                  StateContainer.of(context)
                                      .curTheme
                                      .shadowTextDark,
                                ],
                              ),
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(120.0)),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-100),
                                  padding: EdgeInsetsDirectional.only(start: 4, end: 4),
                                  child: AutoSizeText.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: AppLocalization.of(context).languageColonHeader,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: " ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: StateContainer.of(context).curLanguage.getDisplayName(context),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .textDark,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ]),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    stepGranularity: 0.1,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                onPressed: () {
                                  showAppDialog(
                                      context: context,
                                      builder: (_) => DialogOverlay(
                                          title: AppLocalization.of(context)
                                              .languageHeader,
                                          optionsList: getLanguageList()));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //"New Private Key" and "Import Private Key" buttons
            Row(
              children: <Widget>[
                AppButton(
                  type: AppButtonType.Primary,
                  text: AppLocalization.of(context).newPrivateKeyButton,
                  buttonTop: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/intro_security_first');
                  },
                ),
              ],
            ),
            // "Import Private Key" button
            Row(
              children: <Widget>[
                AppButton(
                  type: AppButtonType.PrimaryOutline,
                  text: AppLocalization.of(context).importPrivateKeyButton,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/intro_import_private_key');
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
