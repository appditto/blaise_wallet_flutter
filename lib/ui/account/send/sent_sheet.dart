import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentSheet extends StatefulWidget {
  final String destination;
  final String amount;
  final String localCurrencyAmount;
  final AvailableCurrency localCurrency;
  final String payload;
  final Currency fee;
  final Contact contact;
  final bool encryptedPayload;
  final AccountName accountName;

  SentSheet(
      {@required this.destination,
      @required this.amount,
      @required this.fee,
      this.localCurrencyAmount,
      this.localCurrency,
      this.contact,
      this.payload = "",
      this.encryptedPayload = false,
      this.accountName});

  _SentSheetState createState() => _SentSheetState();
}

class _SentSheetState extends State<SentSheet> {
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
                                    .sentSheetHeader
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
                            AppLocalization.of(context).sentParagraph,
                            style: AppStyles.paragraph(context),
                            stepGranularity: 0.1,
                            maxLines: 3,
                            minFontSize: 8,
                          ),
                        ),
                        // "Address" header
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context).addressTextFieldHeader,
                            style: AppStyles.textFieldLabelSuccess(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // Container for the account number
                        Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark15),
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark10,
                            ),
                            child: widget.contact == null && widget.accountName == null
                                ? AutoSizeText(
                                    widget.destination,
                                    maxLines: 1,
                                    stepGranularity: 0.1,
                                    minFontSize: 8,
                                    textAlign: TextAlign.center,
                                    style:
                                        AppStyles.privateKeyTextDark(context),
                                  )
                                : widget.contact != null ? AutoSizeText.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: " ",
                                        style: AppStyles.iconFontSuccessSmall(
                                            context),
                                      ),
                                      TextSpan(
                                          text:
                                              widget.contact.name,
                                          style: AppStyles.contactsItemName(
                                              context)),
                                      TextSpan(
                                          text: " (" +
                                              widget.contact.account
                                                  .toString() +
                                              ")",
                                          style:
                                              AppStyles.privateKeyTextDarkFaded(
                                                  context)),
                                    ]),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    minFontSize: 8,
                                    stepGranularity: 0.1)
                                  : 
                                  AutoSizeText.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text:
                                              widget.accountName.toString(),
                                          style: AppStyles.contactsItemName(
                                              context)),
                                      TextSpan(
                                          text: " (" +
                                              widget.destination
                                                  .toString() +
                                              ")",
                                          style:
                                              AppStyles.privateKeyTextDarkFaded(
                                                  context)),
                                    ]),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    minFontSize: 8,
                                    stepGranularity: 0.1
                                  )
                        ),
                        // Amount and Fee
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                          child: Row(
                            children: <Widget>[
                              // Amount
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // "Amount" header
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                76 / 2),
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        0, 30, 0, 0),
                                    child: AutoSizeText(
                                      AppLocalization.of(context)
                                          .amountTextFieldHeader,
                                      style: AppStyles.textFieldLabelSuccess(
                                          context),
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  // Container for the Amount
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width -
                                                76 / 2),
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
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
                                        children: widget.localCurrencyAmount == null ? [
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
                                              text: widget.amount,
                                              style:
                                                  AppStyles.balanceSmallSuccess(
                                                      context)),
                                        ] :
                                        [
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
                                              text: widget.amount,
                                              style: AppStyles.balanceSmallSuccess(
                                                  context)),
                                          TextSpan(
                                              text: " (",
                                              style: AppStyles.balanceSmallSuccess(
                                                  context)),
                                          TextSpan(
                                            text: widget.localCurrency.getCurrencySymbol(),
                                            style: AppStyles.balanceSmallSuccess(context)
                                          ),
                                          TextSpan(
                                              text: widget.localCurrencyAmount,
                                              style: AppStyles.balanceSmallSuccess(
                                                  context)),
                                          TextSpan(
                                              text: ")",
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
                                  ),
                                ],
                              ),
                              widget.fee != Currency("0")
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // "Fee" header
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  76 / 2),
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 30, 0, 0),
                                          child: AutoSizeText(
                                            AppLocalization.of(context)
                                                .feeTextFieldHeader,
                                            style:
                                                AppStyles.textFieldLabelSuccess(
                                                    context),
                                            maxLines: 1,
                                            stepGranularity: 0.1,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        // Container for the fee
                                        Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  76 / 2),
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16, 12, 0, 0),
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 8, 12, 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 1,
                                                color:
                                                    StateContainer.of(context)
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
                                                    style:
                                                        TextStyle(fontSize: 8)),
                                                TextSpan(
                                                    text: widget.fee
                                                        .toStringOpt(),
                                                    style: AppStyles
                                                        .balanceSmallSuccess(
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
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        // "Payload" header
                        isNotEmpty(widget.payload)
                            ? Container(
                                width: double.maxFinite,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 30, 0),
                                child: AutoSizeText(
                                  AppLocalization.of(context)
                                      .payloadTextFieldHeader,
                                  style:
                                      AppStyles.textFieldLabelSuccess(context),
                                  maxLines: 1,
                                  stepGranularity: 0.1,
                                  textAlign: TextAlign.start,
                                ),
                              )
                            : SizedBox(),
                        // Container for the payload text
                        isNotEmpty(widget.payload)
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
                                          .textDark15),
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                ),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                (widget.encryptedPayload
                                                    ? 101
                                                    : 86)),
                                        child: AutoSizeText(
                                          widget.payload,
                                          maxLines: 3,
                                          stepGranularity: 0.1,
                                          minFontSize: 8,
                                          textAlign: TextAlign.start,
                                          style: AppStyles.paragraph(context),
                                        ),
                                      ),
                                      widget.encryptedPayload
                                          ? Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      start: 3.0),
                                              child: Icon(FontAwesomeIcons.lock,
                                                  size: 12,
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .textDark))
                                          : SizedBox()
                                    ]))
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
