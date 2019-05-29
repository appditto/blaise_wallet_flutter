import 'package:blaise_wallet_flutter/ui/unicorn_outline_button.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class IntroWelcomePage extends StatefulWidget {
  @override
  _IntroWelcomePageState createState() => _IntroWelcomePageState();
}

class _IntroWelcomePageState extends State<IntroWelcomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
              children: <Widget>[
                //A widget that holds welcome animation + paragraph
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width*0.475,
                            decoration: BoxDecoration(
                              // Box decoration takes a gradient
                              gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.0, 1],
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Color(0xFFF7941F),
                                  Color(0xFFFCC642),
                                ],
                              ),
                            ),
                          ),
                          //Container for the animation
                          Container(
                            margin: EdgeInsetsDirectional.only(top: 20),
                            //Width/Height ratio for the animation is needed because BoxFit is not working as expected
                            width: double.infinity,
                            height:
                                MediaQuery.of(context).size.width * 250 / 400,
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
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 90),
                        child: AutoSizeText(
                          "Welcome to Blaise Wallet. To begin, you can create a new private key or import one.",
                          maxLines: 4,
                          stepGranularity: 0.5,
                          style: TextStyle(
                              color: Color(0xFF6B6C71),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
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
                              gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.0, 1],
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Color(0xFFF7941F),
                                  Color(0xFFFCC642),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFCC642).withOpacity(0.6),
                                    offset: Offset(0, 8),
                                    blurRadius: 16,
                                    spreadRadius: -4.0),
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
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                // Where the linear gradient begins and ends
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                // Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.0, 1],
                                colors: [
                                  // Colors are easy thanks to Flutter's Colors class.
                                  Color(0xFFFFFFFF),
                                  Color(0xFFFFFFFF),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFCC642).withOpacity(0.3),
                                    offset: Offset(0, 8),
                                    blurRadius: 16,
                                    spreadRadius: -4.0),
                              ],
                            ),
                            margin:
                                EdgeInsetsDirectional.fromSTEB(20, 16, 20, 20),
                            height: 45,
                            child: UnicornOutlineButton(
                              strokeWidth: 2.0,
                              radius: 12,
                              child: AutoSizeText(
                                "Import Private Key",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                stepGranularity: 0.5,
                                style: TextStyle(
                                    color: Color(0xFFF7941F),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              gradient: LinearGradient(
                                colors: [Color(0xFFF7941F), Color(0xFFFCC642)],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                return;
                              },
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
