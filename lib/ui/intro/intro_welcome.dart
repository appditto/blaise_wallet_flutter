import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/pascal_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class IntroWelcomePage extends StatefulWidget {
  @override
  _IntroWelcomePageState createState() => _IntroWelcomePageState();
}

class _IntroWelcomePageState extends State<IntroWelcomePage> {
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
                            height:
                                MediaQuery.of(context).size.width * 262 / 400,
                            child: Center(
                              child: FlareActor(
                                "assets/animation_welcome.flr",
                                animation: "main",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Container for the paragraph
                      Expanded(
                        child: Container(
                          alignment: Alignment(-1, -0.2),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: AutoSizeText(
                            "Welcome to Blaise Wallet. To begin, you can create a new private key or import one.",
                            maxLines: 4,
                            stepGranularity: 0.1,
                            style: AppStyles.paragraph(context),
                          ),
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
                      text: "New Private Key",
                      buttonTop: true,
                      onPressed: () {
                        sl.get<Vault>().setPrivateKey(sl.get<PascalUtil>().generateKeyPair().privateKey).then((key) {
                          Navigator.of(context).pushNamed('/intro_new_private_key');
                        });
                      },
                    ),
                  ],
                ),
                // "Import Private Key" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: "Import Private Key",
                      onPressed: () {
                        Navigator.of(context).pushNamed('/intro_import_private_key');
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
