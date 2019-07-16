import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LockScreenPage extends StatefulWidget {
  @override
  _LockScreenPageState createState() => _LockScreenPageState();
}

class _LockScreenPageState extends State<LockScreenPage> {
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
            //A widget that holds lock icon and background
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // A stack for background gradient and the lock icon
                  Stack(
                    children: <Widget>[
                      // Container for the gradient background
                      Container(
                        height: (MediaQuery.of(context).padding.top +
                            MediaQuery.of(context).size.width * 0.4),
                        decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                        ),
                      ),
                      // "Locked" text
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).padding.top +
                                MediaQuery.of(context).size.width * 0.08),
                        alignment: Alignment(0, 0),
                        child: Text(
                          "LOCKED",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      // Lock Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                top: MediaQuery.of(context).padding.top +
                                    MediaQuery.of(context).size.width * 0.2),
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                gradient: StateContainer.of(context)
                                    .curTheme
                                    .gradientPrimary,
                                borderRadius: BorderRadius.circular(400)),
                            child: Icon(Icons.lock,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundPrimary,
                                size: MediaQuery.of(context).size.width * 0.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // "Unlock" button
            Row(
              children: <Widget>[
                AppButton(
                  type: AppButtonType.Primary,
                  text: "Unlock",
                  onPressed: () {
                    Navigator.of(context).pushNamed('/lockscreen');
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
