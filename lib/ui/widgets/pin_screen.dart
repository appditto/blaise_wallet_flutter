import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

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
                      height: MediaQuery.of(context).size.height * 0.3,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Number Pad
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7 + 16,
                        width: double.maxFinite,
                        padding: EdgeInsetsDirectional.only(
                            bottom: MediaQuery.of(context).padding.bottom),
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
                      ),
                    ),
                  ],
                )));
  }
}
