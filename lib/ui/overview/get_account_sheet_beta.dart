import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/ui/widgets/webview.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class GetAccountSheetBeta extends StatefulWidget {
  _GetAccountSheetBetaState createState() => _GetAccountSheetBetaState();
}

class _GetAccountSheetBetaState extends State<GetAccountSheetBeta> {
  @override
  void initState() {
    super.initState();
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
                      // Close Button
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 5, end: 10),
                        height: 50,
                        width: 50,
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.textLight15,
                            splashColor:
                                StateContainer.of(context).curTheme.textLight30,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(AppIcons.close,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textLight,
                                size: 20)),
                      ),
                      // Header
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          "GET ACCOUNT",
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
                  child:
                      // Container for the illustration
                      Container(
                    margin: EdgeInsetsDirectional.only(top: 24, bottom: 16),
                    child: SvgRepaintAsset(
                      asset: StateContainer.of(context).curTheme.illustrationTwoOptions,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height:
                          MediaQuery.of(context).size.width * (142 / 180) * 0.6,
                    ),
                  ),
                ),
                // Paragraph
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 24),
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Thank you for trying the Blaise Wallet Beta!\n\n",
                          style: AppStyles.paragraph(context),
                        ),
                        TextSpan(
                          text:
                              "More ways to obtain an account will be added in a later release, but in the meantime you may get a free account using freepasa.org using your phone number and public key\n\n",
                          style: AppStyles.paragraph(context),
                        ),
                        TextSpan(
                          text:
                              "Only 1 account per phone number is allowed.",
                          style: AppStyles.paragraphPrimary(context),
                        ),
                      ],
                    ),
                    stepGranularity: 0.1,
                    maxLines: 12,
                    minFontSize: 8,
                  ),
                ),
                // "Buy An Account" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Visit Freepasa.org",
                      onPressed: () {
                        AppWebView.showWebView(context, 'https://freepasa.org?public_key=${PublicKeyCoder().encodeToBase58(walletState.publicKey)}');
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
