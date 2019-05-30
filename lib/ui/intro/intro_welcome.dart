import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
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
                            width: double.infinity,
                            height:
                                MediaQuery.of(context).size.width * 262 / 400,
                            child: Center(
                              child: FlareActor(
                                "assets/welcome_animation.flr",
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
                          alignment: Alignment(0, -0.2),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: AutoSizeText(
                            "Welcome to Blaise Wallet. To begin, you can create a new private key or import one.",
                            maxLines: 4,
                            stepGranularity: 0.5,
                            style: TextStyle(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textDark,
                                fontSize: 14.0,
                                height: 1.3,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //A column with "New Private Key" and "Import Private Key" buttons
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              gradient: StateContainer.of(context)
                                  .curTheme
                                  .gradientPrimary,
                              boxShadow: [
                                StateContainer.of(context)
                                    .curTheme
                                    .shadowPrimary,
                              ],
                            ),
                            margin:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            height: 45,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: AutoSizeText(
                                "New Private Key",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                stepGranularity: 0.5,
                                style: TextStyle(
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textLight,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              splashColor: StateContainer.of(context).curTheme.backgroundPrimary30,
                              highlightColor: StateContainer.of(context).curTheme.backgroundPrimary15,
                              onPressed: () {
                                Navigator.pop(context);
                                return;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsetsDirectional.fromSTEB(
                              20,
                              16,
                              20,
                              (MediaQuery.of(context).padding.bottom) +
                                  (20 -
                                      (MediaQuery.of(context).padding.bottom) /
                                          2),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                StateContainer.of(context)
                                    .curTheme
                                    .shadowSecondary,
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: double.maxFinite,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: StateContainer.of(context)
                                            .curTheme
                                            .gradientPrimary,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      height: 41,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .backgroundPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.transparent,
                                  ),
                                  height: 45,
                                  width: double.maxFinite,
                                  child: FlatButton(
                                    child: AutoSizeText(
                                      "Import Private Key",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      stepGranularity: 0.5,
                                      style: TextStyle(
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    color: Colors.transparent,
                                    splashColor: StateContainer.of(context).curTheme.primary30,
                                    highlightColor: StateContainer.of(context).curTheme.primary15,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      return;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
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
