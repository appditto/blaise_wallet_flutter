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
        builder: (context, constraints) => SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.10,
              ),
              child: Column(
                children: <Widget>[
                  //A widget that holds welcome animation + paragraph
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Container for the animation
                        Container(
                          //Width/Height ratio for the animation is needed because BoxFit is not working as expected
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 5 / 8,
                          child: Center(
                            child: FlareActor(
                              "assets/welcome_animation.flr",
                              animation: "main",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        //Container for the paragraph
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: AutoSizeText(
                            "Welcome",
                            maxLines: 4,
                            stepGranularity: 0.5,
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
                        ],
                      ),
                      Row(
                        children: <Widget>[
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}