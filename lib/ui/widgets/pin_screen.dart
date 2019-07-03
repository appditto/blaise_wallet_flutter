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
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.maxFinite,
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0,
                          MediaQuery.of(context).padding.top,
                          0,
                          MediaQuery.of(context).padding.top),
                      decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // PIN header
                            Container(
                              child: AutoSizeText(
                                "Enter PIN",
                                style: AppStyles.modalHeader(context),
                              ),
                            ),
                            // PIN description
                            Container(
                              margin: EdgeInsetsDirectional.only(top: 4),
                              child: AutoSizeText(
                                "Enter your PIN to unlock",
                                style: AppStyles.pinDescription(context),
                              ),
                            ),
                            // Dots
                            Container(
                              margin: EdgeInsetsDirectional.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child: Icon(FontAwesomeIcons.solidCircle,
                                        size: 18),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child: Icon(FontAwesomeIcons.solidCircle,
                                        size: 18),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child:
                                        Icon(FontAwesomeIcons.circle, size: 18),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child:
                                        Icon(FontAwesomeIcons.circle, size: 18),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child:
                                        Icon(FontAwesomeIcons.circle, size: 18),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 4, 0),
                                    child:
                                        Icon(FontAwesomeIcons.circle, size: 18),
                                  ),
                                ],
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
                        height: MediaQuery.of(context).size.height * 0.65 + 16,
                        width: double.maxFinite,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            MediaQuery.of(context).size.width * 0.075,
                            MediaQuery.of(context).size.width * 0.075,
                            MediaQuery.of(context).size.width * 0.075,
                            MediaQuery.of(context).padding.bottom +
                                MediaQuery.of(context).size.width * 0.075),
                        decoration: BoxDecoration(
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            StateContainer.of(context).curTheme.shadowBottomBar,
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "1",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "2",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "3",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "4",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "5",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "6",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "7",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "8",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "9",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      child: Text(
                                        " ",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Text(
                                        "0",
                                        style: AppStyles.pinNumberPad(context),
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () => null,
                                      child: Icon(
                                        Icons.backspace,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .primary,
                                      ),
                                      padding: EdgeInsets.all(30),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )));
  }
}
