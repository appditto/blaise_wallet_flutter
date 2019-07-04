import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen>
    with SingleTickerProviderStateMixin {
  List<bool> dotStates;

  @override
  void initState() {
    super.initState();
    dotStates = [true, true, false, false, false, false];
  }

  Widget buildPINButton(String text) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: text == ""
          ? SizedBox()
          : InkWell(
              // Real tap function
              onTapDown: null,
              // For the splash effect
              onTap: () {},
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 8),
              child: Center(
                child: text == "-"
                    ? Icon(
                        Icons.backspace,
                        color: StateContainer.of(context).curTheme.primary,
                      )
                    : Text(
                        text,
                        style: AppStyles.pinNumberPad(context),
                      ),
              ),
            ),
    );
  }

  List<Widget> buildPINScreenDots() {
    List<Widget> ret = List();
    for (int i = 0; i < 6; i++) {
      ret.add(
        Container(
          margin: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
          child: Icon(
              dotStates[i]
                  ? FontAwesomeIcons.solidCircle
                  : FontAwesomeIcons.circle,
              size: 18),
        ),
      );
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    // Main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      // A Stack to achive the overlap between background gradient and number pad
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
              children: <Widget>[
                // Pin Text & Dots
                Container(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.width * 5 / 4),
                  width: double.maxFinite,
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0,
                      MediaQuery.of(context).padding.top,
                      0,
                      MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                      gradient:
                          StateContainer.of(context).curTheme.gradientPrimary),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // PIN header
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                          child: AutoSizeText(
                            "Enter PIN",
                            style: AppStyles.modalHeader(context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            minFontSize: 10,
                            stepGranularity: 0.1,
                          ),
                        ),
                        // PIN description
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 4, 30, 0),
                          child: AutoSizeText(
                            "Enter your PIN to unlock",
                            textAlign: TextAlign.center,
                            style: AppStyles.pinDescription(context),
                            maxLines: 2,
                            minFontSize: 10,
                            stepGranularity: 0.1,
                          ),
                        ),
                        // Dots
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buildPINScreenDots(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Number Pad
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 5 / 4 + 16,
                    width: double.maxFinite,
                    padding: EdgeInsetsDirectional.fromSTEB(
                        MediaQuery.of(context).size.width * 0.075,
                        MediaQuery.of(context).size.width * 0.075,
                        MediaQuery.of(context).size.width * 0.075,
                        MediaQuery.of(context).padding.bottom +
                            MediaQuery.of(context).size.width * 0.075),
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        StateContainer.of(context).curTheme.shadowBottomBar,
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                buildPINButton("1"),
                                buildPINButton("2"),
                                buildPINButton("3"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                buildPINButton("4"),
                                buildPINButton("5"),
                                buildPINButton("6"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                buildPINButton("7"),
                                buildPINButton("8"),
                                buildPINButton("9"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                buildPINButton(""),
                                buildPINButton("0"),
                                buildPINButton("-"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
