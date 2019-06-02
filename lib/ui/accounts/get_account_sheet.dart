import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:flutter/material.dart';

class GetAccountSheet extends StatefulWidget {
  _GetAccountSheetState createState() => _GetAccountSheetState();
}

class _GetAccountSheetState extends State<GetAccountSheet> {
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
                // Header
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
                  child: Container(
                    alignment: Alignment(0, 0),
                    child: AutoSizeText(
                      "GET ACCOUNT",
                      style: AppStyles.header(context),
                      maxLines: 1,
                      stepGranularity: 0.1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child:
                    // Container for the illustration
                    Container(
                      margin: EdgeInsetsDirectional.only(top: 24, bottom: 16),
                    child: SvgRepaintAsset(
                        asset: 'assets/illustration_two_options.svg',
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width*(142/180) * 0.6,
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
                              "There are 2 options for getting your first account:\n\n",
                          style: AppStyles.paragraph(context),
                        ),
                        TextSpan(
                          text:
                              "1- You can get a free account using your phone number. ",
                          style: AppStyles.paragraph(context),
                        ),
                        TextSpan(
                          text: "Only 1 account per phone number is allowed.\n\n",
                          style: AppStyles.paragraphPrimary(context),
                        ),
                        TextSpan(
                          text:
                              "2- You can buy as many accounts as you want for ",
                          style: AppStyles.paragraph(context),
                        ),
                        TextSpan(
                          text: "0.25 PASCAL (~\$0.07)",
                          style: AppStyles.paragraphPrimary(context),
                        ),
                        TextSpan(
                          text:
                              ".",
                          style: AppStyles.paragraph(context),
                        ),
                      ],
                    ),
                    stepGranularity: 0.1,
                    maxLines: 9,
                    minFontSize: 8,
                  ),
                ),
                Container(),
                //"Get a Free Account" and "Buy An Account" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Get a Free Account",
                      buttonTop: true,
                    ),
                  ],
                ),
                // "Buy An Account" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: "Buy An Account",
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
