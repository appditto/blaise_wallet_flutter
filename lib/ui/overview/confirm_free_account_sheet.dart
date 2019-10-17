import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/network/http_client.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/routes.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:logger/logger.dart';
import 'package:pascaldart/pascaldart.dart';

class ConfirmFreeAccountSheet extends StatefulWidget {
  final String requestId;

  ConfirmFreeAccountSheet({@required this.requestId}) : super();

  _ConfirmFreeAccountSheetState createState() =>
      _ConfirmFreeAccountSheetState();
}

class _ConfirmFreeAccountSheetState extends State<ConfirmFreeAccountSheet> {
  final Logger log = sl.get<Logger>();
  OverlayEntry _overlay;
  TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    this.codeController = TextEditingController();
    log.d("confirming with request ID '${widget.requestId}'");
  }

  void showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    _overlay = OverlayEntry(
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
    overlayState.insert(_overlay);
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
                            AppLocalization.of(context).freeAccountSheetHeader.toUpperCase(),
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
                                // Container for SMS confirmation code
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 30),
                                  child: AppTextField(
                                    label: AppLocalization.of(context).confirmationCodeTextFieldHeader,
                                    style: AppStyles.paragraphMedium(context),
                                    inputType: TextInputType.number,
                                    maxLines: 1,
                                    controller: codeController,
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
                          showOverlay(context);
                          bool success = await verifyFreepasaAccount();
                          _overlay?.remove();
                          if (success) {
                            walletState.loadWallet();
                            Navigator.popUntil(context, RouteUtils.withNameLike('/overview'));
                            UIUtil.showSnackbar(AppLocalization.of(context).freepasaComplete, context);
                          }
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

  /// Verify a freepasa request, return true if valid, false if not
  Future<bool> verifyFreepasaAccount() async {
    try {
      log.d("Sending request to verify freePASA rid: '${widget.requestId}', code ${codeController.text}");
      int response = await HttpAPI.verifyFreePASA(
        widget.requestId,
        codeController.text
      );
      if (response == null) {
        log.w("Null response from HttpAPI.verifyFreePASA");
        UIUtil.showSnackbar(AppLocalization.of(context).somethingWentWrongError, context);
        return false;
      } else if (response < 0) {
        log.d("Invalid confirmation code entered at freepasa verify");
        UIUtil.showSnackbar(AppLocalization.of(context).confirmationCodeError, context);
        return false;
      }
      AccountNumber account = AccountNumber.fromInt(response);
      await sl.get<SharedPrefsUtil>().setFreepasaAccount(account);
      return true;
    } catch (e) {
      log.e("Caught exception at freepasa verify ${e.toString()}", e);
      return false;
    } 
  }
}
