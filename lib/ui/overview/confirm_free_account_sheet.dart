import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class ConfirmFreeAccountSheet extends StatefulWidget {
  final String requestId;

  ConfirmFreeAccountSheet({@required this.requestId}) : super();

  _ConfirmFreeAccountSheetState createState() =>
      _ConfirmFreeAccountSheetState();
}

class _ConfirmFreeAccountSheetState extends State<ConfirmFreeAccountSheet> {
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
    return TapOutsideUnfocus(
      child: Column(
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
                            AppLocalization.of(context).freeAccountSheetHeader,
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
                        //Container for the paragraph
                        Container(
                          alignment: Alignment(-1, 0),
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context).enterConfirmationCodeParagraph,
                            maxLines: 3,
                            stepGranularity: 0.1,
                            style: AppStyles.paragraph(context),
                          ),
                        ),
                        Expanded(
                          child: KeyboardAvoider(
                            duration: Duration(milliseconds: 0),
                            autoScroll: true,
                            focusPadding: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Container for country code field
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 30),
                                  child: AppTextField(
                                    label: AppLocalization.of(context).confirmationCodeTextFieldHeader,
                                    style: AppStyles.paragraphMedium(context),
                                    inputType: TextInputType.number,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //"CONFIRM" and "Go Back" buttons
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.Primary,
                        text: toUppercase(AppLocalization.of(context).confirmButton, context),
                        buttonTop: true,
                        onPressed: () async {
                          return;
                          // TODO
                          /*
                          await showOverlay(context);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/account_new');
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
                        text: toUppercase(AppLocalization.of(context).goBackButton, context),
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
      ),
    );
  }
}
