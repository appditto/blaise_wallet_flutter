import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class TransferredAccountSheet extends StatefulWidget {
  final String newAccountPubkey;
  final Currency fee;

  TransferredAccountSheet(
      {@required this.newAccountPubkey, @required this.fee});

  _TransferredAccountSheetState createState() =>
      _TransferredAccountSheetState();
}

class _TransferredAccountSheetState extends State<TransferredAccountSheet> {
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
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.7,
                          0.7,
                          1.0
                        ],
                        colors: [
                          StateContainer.of(context).curTheme.success,
                          StateContainer.of(context).curTheme.success,
                          StateContainer.of(context).curTheme.backgroundPrimary,
                          StateContainer.of(context).curTheme.backgroundPrimary,
                        ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 8),
                    child: Column(
                      children: <Widget>[
                        Row(
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
                                toUppercase(AppLocalization.of(context)
                                    .transferredSheetHeader
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
                        // Tick
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 8),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: StateContainer.of(context).curTheme.success,
                            boxShadow: [
                              StateContainer.of(context)
                                  .curTheme
                                  .shadowTextDarkTwo
                            ],
                          ),
                          child: Icon(
                            AppIcons.tick,
                            size: 40,
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Paragraph
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context).transferredParagraph,
                            style: AppStyles.paragraph(context),
                            stepGranularity: 0.1,
                            maxLines: 3,
                            minFontSize: 8,
                          ),
                        ),
                        // "Address" header
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context)
                                .publicKeyTextFieldHeader,
                            style: AppStyles.textFieldLabelSuccess(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // Container for the public key
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 1,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textDark15),
                            color:
                                StateContainer.of(context).curTheme.textDark10,
                          ),
                          child: AutoSizeText(
                            widget.newAccountPubkey,
                            maxLines: 4,
                            stepGranularity: 0.1,
                            minFontSize: 8,
                            textAlign: TextAlign.center,
                            style: AppStyles.privateKeyTextDark(context),
                          ),
                        ),
                        // "Fee" header
                        widget.fee != Currency('0')
                            ? Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 30, 0),
                                child: AutoSizeText(
                                  AppLocalization.of(context)
                                      .feeTextFieldHeader,
                                  style:
                                      AppStyles.textFieldLabelSuccess(context),
                                  maxLines: 1,
                                  stepGranularity: 0.1,
                                  textAlign: TextAlign.start,
                                ),
                              )
                            : SizedBox(),
                        // Container for the fee
                        widget.fee != Currency("0")
                            ? Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 12, 30, 0),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 8, 12, 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .success15),
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .success10,
                                ),
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "",
                                        style: AppStyles
                                            .iconFontSuccessBalanceSmallPascal(
                                                context),
                                      ),
                                      TextSpan(
                                          text: " ",
                                          style: TextStyle(fontSize: 8)),
                                      TextSpan(
                                          text: widget.fee.toStringOpt(),
                                          style: AppStyles.balanceSmallSuccess(
                                              context)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  stepGranularity: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        // Bottom Margin
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                // "CANCEL" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.SuccessOutline,
                      text: AppLocalization.of(context).closeButton,
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
