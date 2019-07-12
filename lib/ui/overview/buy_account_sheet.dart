import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class BuyAccountSheet extends StatefulWidget {
  _BuyAccountSheetState createState() => _BuyAccountSheetState();
}

class _BuyAccountSheetState extends State<BuyAccountSheet> {
  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: StateContainer.of(context).curTheme.overlay20,
              child: Center(
                child: //Container for the animation
                    Container(
                  margin: EdgeInsetsDirectional.only(
                      top: MediaQuery.of(context).padding.top),
                  //Width/Height ratio for the animation is needed because BoxFit is not working as expected
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.width,
                  child: Center(
                    child: FlareActor(
                      StateContainer.of(context).curTheme.animationGetAccount,
                      animation: "main",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(milliseconds: 1500));
    overlayEntry.remove();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: <Widget>[
                // Sheet header
                Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient:
                        StateContainer.of(context).curTheme.gradientPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Sized Box
                      SizedBox(
                        height: 50,
                        width: 65,
                      ),
                      // Header
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          "BUY ACCOUNT",
                          style: AppStyles.header(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Sized Box
                      SizedBox(
                        height: 50,
                        width: 65,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      // Container for the illustration
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          top: 30,
                        ),
                        child: SvgRepaintAsset(
                            asset: StateContainer.of(context).curTheme.illustrationBorrowed,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width *
                                0.8 *
                                132 /
                                295),
                      ),
                      // Paragraph
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "To buy an account, first you’ll need to borrow one for free. If you send at least",
                                style: AppStyles.paragraph(context),
                              ),
                              TextSpan(
                                text: " 0.25 PASCAL (~\$0.07)",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text: "  to the account in the",
                                style: AppStyles.paragraph(context),
                              ),
                              TextSpan(
                                text: " following 7 days",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text: ", the account will be yours and",
                                style: AppStyles.paragraph(context),
                              ),
                              TextSpan(
                                text: " 0.25 PASCAL",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text:
                                    " will be deducted from your balance automatically.\nOtherwise, it’ll return back to us at the end of 7 days and won’t be useable anymore.",
                                style: AppStyles.paragraph(context),
                              ),
                            ],
                          ),
                          stepGranularity: 0.5,
                          maxLines: 9,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                //"Borrow an Account" and "Cancel" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Borrow an Account",
                      buttonTop: true,
                      onPressed: () async {
                        return;
                        // TODO
                        /*
                        await showOverlay(context);
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/account_borrowed');
                        */
                      },
                    ),
                  ],
                ),
                // "Close" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: "Cancel",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
