import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class BuyAccountSheet extends StatefulWidget {
  _BuyAccountSheetState createState() => _BuyAccountSheetState();
}

class _BuyAccountSheetState extends State<BuyAccountSheet> {
  String accountPrice = "0.25";
  String fiatPrice = "";
  String returnInDays = "7";
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
    fiatPrice = walletState.getLocalCurrencyDisplay(
        currency: StateContainer.of(context).curCurrency,
        amount: Currency(accountPrice),
        decimalDigits: 2);
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
                          AppLocalization.of(context)
                              .buyAccountSheetHeader
                              .toUpperCase(),
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
                            asset: StateContainer.of(context)
                                .curTheme
                                .illustrationBorrowed,
                            width: MediaQuery.of(context).size.width *
                                (UIUtil.smallScreen(context) ? 0.6 : 0.8),
                            height: MediaQuery.of(context).size.width *
                                (UIUtil.smallScreen(context) ? 0.6 : 0.8) *
                                132 /
                                295),
                      ),
                      // Paragraph
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: formatLocalizedColors(
                                context,
                                AppLocalization.of(context)
                                    .borrowAccountParagraph.replaceAll("%1", accountPrice).replaceAll("%2", "~" + fiatPrice).replaceAll("%3", returnInDays)),
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
                      text: AppLocalization.of(context)
                          .borrowAnAccountButton
                          .toUpperCase(),
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
                      text: AppLocalization.of(context)
                          .cancelButton
                          .toUpperCase(),
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
