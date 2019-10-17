import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/ui/overview/buy_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/overview/get_free_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class GetAccountSheet extends StatefulWidget {
  _GetAccountSheetState createState() => _GetAccountSheetState();
}

class _GetAccountSheetState extends State<GetAccountSheet> {
  String accountPrice = "0.25";

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
                          toUppercase(AppLocalization.of(context)
                              .getAccountSheetHeader
                              ,context),
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
                      asset: StateContainer.of(context)
                          .curTheme
                          .illustrationTwoOptions,
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
                      children: getAccountSheetParagraphs(StateContainer.of(context).curCurrency),
                    ),
                    stepGranularity: 0.1,
                    maxLines: 9,
                    minFontSize: 8,
                  ),
                ),
                //"Get a Free Account" and "Buy An Account" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: AppLocalization.of(context).getAFreeAccountButton,
                      buttonTop: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                        AppSheets.showBottomSheet(
                          context: context,
                          widget: GetFreeAccountSheet()
                        );
                      },
                    ),
                  ],
                ),
                // "Buy An Account" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: AppLocalization.of(context).buyAnAccountButton,
                      onPressed: () {
                        Navigator.of(context).pop();
                        AppSheets.showBottomSheet(
                            context: context, widget: BuyAccountSheet());
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

  getAccountSheetParagraphs(AvailableCurrency curCurrency) {
    List<TextSpan> ret = [];
    ret.add(
      TextSpan(
        text: AppLocalization.of(context).getAccountFirstParagraph + "\n\n",
        style: AppStyles.paragraph(context),
      ),
    );
    ret = ret + []
      ..addAll(formatLocalizedColors(
          context, AppLocalization.of(context).getAccountSecondParagraph));
    ret.add(
      TextSpan(
        text: "\n\n",
        style: AppStyles.paragraph(context),
      ),
    );
    ret = ret + []
      ..addAll(formatLocalizedColors(
          context,
          AppLocalization.of(context)
              .getAccountThirdParagraphAlternative2
              .replaceAll("%1", accountPrice).replaceAll("%2",curCurrency == null || walletState.localCurrencyPrice == null ? "N/A" : "~" + walletState.getLocalCurrencyDisplay(
                currency: curCurrency,
                amount: Currency(accountPrice),
                decimalDigits: 2)).replaceAll("%3", "2")));
    return ret;
  }
}
