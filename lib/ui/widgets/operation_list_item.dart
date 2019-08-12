import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

enum OperationType {
  Received,
  Sent,
  NameChanged,
  ListedForSale,
  DelistedForSale,
  Welcome
}

/// A widget for displaying a mnemonic phrase
class OperationListItem extends StatefulWidget {
  final OperationType type;
  final String amount;
  final String address;
  final String date;
  final String payload;
  final Function onPressed;
  final String name;
  final String price;
  final bool isContact;

  OperationListItem({
    this.type,
    this.amount,
    this.address,
    this.date,
    this.payload,
    this.onPressed,
    this.name,
    this.price,
    this.isContact = false
  });

  _OperationListItemState createState() => _OperationListItemState();
}

class _OperationListItemState extends State<OperationListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: double.maxFinite,
        height: widget.type == OperationType.Welcome ? null : 74,
        child: FlatButton(
          padding: EdgeInsetsDirectional.only(start: 24, end: 24),
          onPressed: () {
            if (widget.onPressed != null) {
              widget.onPressed();
            }
            return;
          },
          splashColor: StateContainer.of(context).curTheme.primary30,
          highlightColor: StateContainer.of(context).curTheme.primary15,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: widget.type == OperationType.Welcome
              ? Container(
                  margin: EdgeInsetsDirectional.fromSTEB(30, 16, 30, 16),
                  child: AutoSizeText.rich(
                    TextSpan(
                        children: formatLocalizedColors(context,
                            AppLocalization.of(context).newAccountParagraph)),
                    stepGranularity: 0.5,
                    maxLines: 3,
                    minFontSize: 8,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Operation Type
                        Container(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: widget.type == OperationType.Received
                                  ? StateContainer.of(context).curTheme.primary
                                  : widget.type == OperationType.Sent
                                      ? StateContainer.of(context)
                                          .curTheme
                                          .textDark
                                      : StateContainer.of(context)
                                          .curTheme
                                          .secondary),
                          child: AutoSizeText(
                            widget.type == OperationType.Received
                                ? AppLocalization.of(context).receivedHeader
                                : widget.type == OperationType.Sent
                                    ? AppLocalization.of(context).sentHeader
                                    : widget.type == OperationType.NameChanged
                                        ? AppLocalization.of(context)
                                            .nameChangedHeader
                                        : widget.type ==
                                                OperationType.ListedForSale
                                            ? AppLocalization.of(context)
                                                .listedForSaleHeader
                                            : widget.type ==
                                                    OperationType
                                                        .DelistedForSale
                                                ? AppLocalization.of(context)
                                                    .delistedHeader
                                                : AppLocalization.of(context)
                                                    .undefinedHeader,
                            style: AppStyles.operationType(context),
                          ),
                        ),
                        // Amount & Payload indicator or New Account Name
                        widget.type == OperationType.DelistedForSale
                            ? SizedBox()
                            : Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 72,
                                margin: EdgeInsetsDirectional.only(top: 4),
                                child: widget.type == OperationType.Received ||
                                        widget.type == OperationType.Sent ||
                                        widget.type ==
                                            OperationType.ListedForSale
                                    ? AutoSizeText.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "",
                                              style: widget.type ==
                                                      OperationType.Received
                                                  ? AppStyles
                                                      .iconFontPrimaryBalanceSmallPascal(
                                                          context)
                                                  : widget.type ==
                                                          OperationType.Sent
                                                      ? AppStyles
                                                          .iconFontTextDarkBalanceSmallPascal(
                                                              context)
                                                      : AppStyles
                                                          .iconFontSecondarySmallPascal(
                                                              context),
                                            ),
                                            TextSpan(
                                                text: " ",
                                                style: TextStyle(fontSize: 7)),
                                            TextSpan(
                                                text: widget.type ==
                                                            OperationType
                                                                .Received ||
                                                        widget.type ==
                                                            OperationType.Sent
                                                    ? widget.amount
                                                    : widget.price,
                                                style: widget.type ==
                                                        OperationType.Received
                                                    ? AppStyles.balanceSmall(
                                                        context)
                                                    : widget.type ==
                                                            OperationType.Sent
                                                        ? AppStyles
                                                            .balanceSmallTextDark(
                                                                context)
                                                        : AppStyles
                                                            .balanceSmallSecondary(
                                                                context)),
                                            isNotEmpty(widget.payload)
                                                ? TextSpan(
                                                    text: " ",
                                                    style:
                                                        TextStyle(fontSize: 14))
                                                : TextSpan(),
                                            isNotEmpty(widget.payload)
                                                ? TextSpan(
                                                    text: "",
                                                    style: widget.type ==
                                                            OperationType
                                                                .Received
                                                        ? AppStyles
                                                            .iconFontPrimaryBalanceSmallest(
                                                                context)
                                                        : AppStyles
                                                            .iconFontTextDarkBalanceSmallest(
                                                                context),
                                                  )
                                                : TextSpan(),
                                          ],
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        minFontSize: 4,
                                        stepGranularity: 1,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    : widget.type == OperationType.NameChanged
                                        ? AutoSizeText(
                                            widget.name,
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            minFontSize: 4,
                                            stepGranularity: 1,
                                            style:
                                                AppStyles.balanceSmallSecondary(
                                                    context),
                                          )
                                        : SizedBox(),
                              ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.type == OperationType.Received ||
                                widget.type == OperationType.Sent
                            ?
                            // Address
                            widget.isContact
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            72,
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 4),
                                    alignment: Alignment(1, 0),
                                    child: AutoSizeText.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                          text: " ",
                                          style: AppStyles.iconFontPrimarySmall(
                                              context),
                                        ),
                                        TextSpan(
                                          text: widget.address,
                                          style: AppStyles.contactsItemName(
                                              context),
                                        ),
                                      ]),
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            72,
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 4),
                                    alignment: Alignment(1, 0),
                                    child: AutoSizeText(
                                      widget.address,
                                      style: AppStyles.monoTextDarkSmall400(
                                          context),
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                            : SizedBox(),
                        // Date
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 72,
                          alignment: Alignment(1, 0),
                          child: AutoSizeText(
                            widget.date,
                            style: AppStyles.operationDate(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      Container(
        width: double.maxFinite,
        height: 1,
        color: StateContainer.of(context).curTheme.textDark10,
      )
    ]);
  }
}
