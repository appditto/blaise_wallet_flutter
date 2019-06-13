import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

enum OperationType { Received, Sent }

/// A widget for displaying a mnemonic phrase
class OperationListItem extends StatefulWidget {
  final OperationType type;
  final String amount;
  final String address;
  final String date;
  final String payload;
  final Function onPressed;

  OperationListItem({
    this.type,
    this.amount,
    this.address,
    this.date,
    this.payload,
    this.onPressed,
  });

  _OperationListItemState createState() => _OperationListItemState();
}

class _OperationListItemState extends State<OperationListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 74,
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
        child: Row(
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
                          : StateContainer.of(context).curTheme.textDark),
                  child: AutoSizeText(
                    widget.type == OperationType.Received ? "Received" : "Sent",
                    style: AppStyles.operationType(context),
                  ),
                ),
                // Amount & Payload indicator
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 72,
                  margin: EdgeInsetsDirectional.only(top: 4),
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "",
                          style: widget.type == OperationType.Received
                              ? AppStyles.iconFontPrimaryBalanceSmallPascal(
                                  context)
                              : AppStyles.iconFontTextDarkBalanceSmallPascal(
                                  context),
                        ),
                        TextSpan(text: " ", style: TextStyle(fontSize: 7)),
                        TextSpan(
                            text: widget.amount,
                            style: widget.type == OperationType.Received
                                ? AppStyles.balanceSmall(context)
                                : AppStyles.balanceSmallTextDark(context)),
                        TextSpan(text: " ", style: TextStyle(fontSize: 14)),
                        widget.payload != null
                            ? TextSpan(
                                text: "",
                                style: widget.type == OperationType.Received
                                    ? AppStyles.iconFontPrimaryBalanceSmallest(
                                        context)
                                    : AppStyles.iconFontTextDarkBalanceSmallest(
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
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Address
                widget.address[0]=="@"?
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 72,
                  alignment: Alignment(1, 0),
                  child: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:"@",
                          style: AppStyles.contactsItemAddressPrimary(context),
                        ),
                        TextSpan(
                          text: widget.address.substring(1),
                          style: AppStyles.contactsItemAddress(context),
                        ),
                      ]
                    ),
                    maxLines: 1,
                    stepGranularity: 0.1,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'SourceCodePro',
                      fontSize: 16,
                    ),
                  ),
                ):
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 72,
                  alignment: Alignment(1, 0),
                  child: AutoSizeText(
                    widget.address,
                    style: AppStyles.contactsItemAddress(context),
                    maxLines: 1,
                    stepGranularity: 0.1,
                    textAlign: TextAlign.end,
                  ),
                ),
                // Date
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 72,
                  margin: EdgeInsetsDirectional.only(top: 2),
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
    );
  }
}
