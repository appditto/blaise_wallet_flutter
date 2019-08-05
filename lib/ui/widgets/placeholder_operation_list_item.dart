import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

enum PlaceholderOperationType {
  Received,
  Sent,
  NameChanged,
  ListedForSale,
  Welcome
}

/// A widget for displaying a mnemonic phrase
class PlaceholderOperationListItem extends StatefulWidget {
  final PlaceholderOperationType type;

  PlaceholderOperationListItem({
    this.type,
  });

  _PlaceholderOperationListItemState createState() =>
      _PlaceholderOperationListItemState();
}

class _PlaceholderOperationListItemState
    extends State<PlaceholderOperationListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: double.maxFinite,
        height: widget.type == PlaceholderOperationType.Welcome ? null : 74,
        child: FlatButton(
          padding: EdgeInsetsDirectional.only(start: 24, end: 24),
          onPressed: () {
            return null;
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
                        color: widget.type == PlaceholderOperationType.Received
                            ? StateContainer.of(context)
                                .curTheme
                                .primary
                                .withOpacity(0.75)
                            : widget.type == PlaceholderOperationType.Sent
                                ? StateContainer.of(context)
                                    .curTheme
                                    .textDark
                                    .withOpacity(0.75)
                                : StateContainer.of(context)
                                    .curTheme
                                    .secondary
                                    .withOpacity(0.75)),
                    child: AutoSizeText(
                      widget.type == PlaceholderOperationType.Received
                          ? "              "
                          : widget.type == PlaceholderOperationType.Sent
                              ? "       "
                              : widget.type ==
                                      PlaceholderOperationType.NameChanged
                                  ? "                  "
                                  : widget.type ==
                                          PlaceholderOperationType.ListedForSale
                                      ? "                      "
                                      : "           ",
                      style: AppStyles.operationType(context),
                    ),
                  ),
                  // Amount & Payload indicator or New Account Name
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 72,
                    margin: EdgeInsetsDirectional.only(top: 4),
                    child: widget.type == PlaceholderOperationType.Received ||
                            widget.type == PlaceholderOperationType.Sent ||
                            widget.type ==
                                PlaceholderOperationType.NameChanged ||
                            widget.type ==
                                PlaceholderOperationType.ListedForSale
                        ? Align(
                            alignment: Alignment(-1, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: widget.type ==
                                          PlaceholderOperationType.Received
                                      ? StateContainer.of(context)
                                          .curTheme
                                          .primary
                                          .withOpacity(0.5)
                                      : widget.type ==
                                              PlaceholderOperationType.Sent
                                          ? StateContainer.of(context)
                                              .curTheme
                                              .textDark
                                              .withOpacity(0.5)
                                          : StateContainer.of(context)
                                              .curTheme
                                              .secondary
                                              .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100)),
                              child: AutoSizeText.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "  ",
                                        style: AppStyles
                                            .iconFontTextDarkBalanceSmallPascal(
                                                context)),
                                    TextSpan(
                                        text: " ",
                                        style: TextStyle(fontSize: 7)),
                                    TextSpan(
                                        text: "           ",
                                        style: widget.type ==
                                                PlaceholderOperationType
                                                    .Received
                                            ? AppStyles.balanceSmall(context)
                                            : widget.type ==
                                                    PlaceholderOperationType
                                                        .Sent
                                                ? AppStyles
                                                    .balanceSmallTextDark(
                                                        context)
                                                : AppStyles
                                                    .balanceSmallSecondary(
                                                        context)),
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
                          )
                        : SizedBox(),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.type == PlaceholderOperationType.Received ||
                          widget.type == PlaceholderOperationType.Sent
                      ?
                      // Address
                      Container(
                          width: MediaQuery.of(context).size.width / 2 - 72,
                          alignment: Alignment(1, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark
                                  .withOpacity(0.25),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: AutoSizeText(
                              "          ",
                              style: AppStyles.contactsItemAddress(context),
                              maxLines: 1,
                              stepGranularity: 0.1,
                              textAlign: TextAlign.end,
                            ),
                          ))
                      : SizedBox(),
                  // Date
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 72,
                    margin: EdgeInsetsDirectional.only(top: 4),
                    alignment: Alignment(1, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: StateContainer.of(context)
                            .curTheme
                            .textDark
                            .withOpacity(0.125),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: AutoSizeText(
                        "                 ",
                        style: AppStyles.operationDate(context),
                        maxLines: 1,
                        stepGranularity: 0.1,
                        textAlign: TextAlign.end,
                      ),
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
