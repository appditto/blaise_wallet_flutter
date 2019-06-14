import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/account/receive/receive_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/send/send_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// A widget for buttons
class AccountCard extends StatefulWidget {
  final String name;
  final String number;
  final String balance;
  final Function onPressed;

  AccountCard({this.name, this.number, this.balance, this.onPressed});

  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  @override
  Widget build(BuildContext context) {
    // Account Card
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.175,
      movementDuration: Duration(milliseconds: 150),
      actions: <Widget>[
        // Receive Icon
        Container(
          color: Colors.transparent,
          margin: EdgeInsetsDirectional.only(
            start: MediaQuery.of(context).size.width * 0.05,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 48,
              width: 50,
              decoration: BoxDecoration(
                  gradient:
                      StateContainer.of(context).curTheme.gradientPrimary),
              child: FlatButton(
                  highlightColor:
                      StateContainer.of(context).curTheme.textLight15,
                  splashColor: StateContainer.of(context).curTheme.textLight30,
                  onPressed: widget.onPressed != null
                      ? widget.onPressed
                      : () {
                          Navigator.pushNamed(context, '/account');
                          AppSheets.showBottomSheet(
                              context: context,
                              widget: ReceiveSheet(
                                accountName: "yekta",
                                address: "578706-79",
                              ));
                        },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Icon(AppIcons.downarrow,
                      color: StateContainer.of(context).curTheme.textLight,
                      size: 24)),
            ),
          ),
        ),
        // Send Icon
        Container(
          color: Colors.transparent,
          padding: EdgeInsetsDirectional.only(
            start: (MediaQuery.of(context).size.width * 0.05) * 2 / 3,
            end: (MediaQuery.of(context).size.width * 0.05) * 1 / 3,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: EdgeInsetsDirectional.only(top: 0, end: 0),
              height: 48,
              width: 50,
              decoration: BoxDecoration(
                  gradient: StateContainer.of(context).curTheme.gradientPrimary,
                  boxShadow: [
                    StateContainer.of(context).curTheme.shadowPrimaryOne
                  ]),
              child: FlatButton(
                  highlightColor:
                      StateContainer.of(context).curTheme.textLight15,
                  splashColor: StateContainer.of(context).curTheme.textLight30,
                  onPressed: widget.onPressed != null
                      ? widget.onPressed
                      : () {
                          Navigator.pushNamed(context, '/account');
                          AppSheets.showBottomSheet(
                              context: context, widget: SendSheet());
                        },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Icon(AppIcons.uparrow,
                      color: StateContainer.of(context).curTheme.textLight,
                      size: 24)),
            ),
          ),
        ),
      ],
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
        height: 70,
        decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [StateContainer.of(context).curTheme.shadowAccountCard]),
        child: Stack(
          children: <Widget>[
            // Left gradient background
            Container(
              height: double.maxFinite,
              width: MediaQuery.of(context).size.width * 0.47 - 24,
              decoration: BoxDecoration(
                  gradient: StateContainer.of(context).curTheme.gradientPrimary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
            ),
            FlatButton(
              onPressed: widget.onPressed != null
                  ? widget.onPressed
                  : () {
                      Navigator.pushNamed(context, '/account');
                    },
              padding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Left part of the card with account name and number
                  Container(
                    height: double.maxFinite,
                    width: MediaQuery.of(context).size.width * 0.47 - 24,
                    padding: EdgeInsetsDirectional.only(start: 16, end: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.name != null
                            ? Container(
                                margin: EdgeInsetsDirectional.only(bottom: 2),
                                child: AutoSizeText(
                                  widget.name,
                                  style: AppStyles.accountCardName(context),
                                  textAlign: TextAlign.left,
                                  stepGranularity: 0.5,
                                  maxLines: 1,
                                  minFontSize: 8,
                                ),
                              )
                            : SizedBox(),
                        AutoSizeText(
                          widget.number,
                          style: AppStyles.accountCardAddress(context),
                          textAlign: TextAlign.left,
                          stepGranularity: 0.5,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  // Right part of the card with balance
                  Container(
                    height: double.maxFinite,
                    width: MediaQuery.of(context).size.width * 0.53 - 24,
                    padding: EdgeInsetsDirectional.only(end: 16),
                    alignment: Alignment(1, 0),
                    child: AutoSizeText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "",
                            style: AppStyles.iconFontPrimaryBalanceMediumPascal(
                                context),
                          ),
                          TextSpan(text: " ", style: TextStyle(fontSize: 7)),
                          TextSpan(
                              text: widget.balance,
                              style: AppStyles.balanceMedium(context)),
                        ],
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      minFontSize: 4,
                      stepGranularity: 1,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
