import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/account/receive/receive_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/send/send_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';

/// A widget for buttons
class AccountCard extends StatefulWidget {
  final PascalAccount account;

  AccountCard({@required this.account});

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
      actions: _getButtons(),
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
              onPressed: () {
                if (!widget.account.isFreepasa) {
                  Navigator.pushNamed(context, '/account',
                      arguments: widget.account);
                } else {
                  showAppDialog(
                      context: context,
                      builder: (_) => DialogOverlay(
                            title: toUppercase(
                                AppLocalization.of(context).unconfirmedAccountHeader, context),
                            confirmButtonText: AppLocalization.of(context).okayButton,
                            singleButton: true,
                            onConfirm: ()=>Navigator.pop(context),
                            body: TextSpan(
                              children: formatLocalizedColors(context,
                                  AppLocalization.of(context).unconfirmedAccountParagraph),
                            ),
                      )
                  );
                }
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
                        isNotEmpty(widget.account.name.accountName)
                            ? Container(
                                margin: EdgeInsetsDirectional.only(bottom: 2),
                                child: AutoSizeText(
                                  widget.account.name.accountName,
                                  style: AppStyles.accountCardName(context),
                                  textAlign: TextAlign.left,
                                  stepGranularity: 0.5,
                                  maxLines: 1,
                                  minFontSize: 8,
                                ),
                              )
                            : SizedBox(),
                        AutoSizeText(
                          widget.account.account.toString(),
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
                    child: Observer(
                      builder: (context) {
                        String status = "";
                        if (widget.account.isFreepasa) {
                          status = AppLocalization.of(context).pendingHeader;
                        } else if (walletState.borrowedAccount != null && walletState.borrowedAccount.account == widget.account.account) {
                          if (walletState.borrowedAccount.paid) {
                            status = AppLocalization.of(context).borrowedTransferredHeader;
                          } else {
                            status = AppLocalization.of(context).borrowedHeader;
                          }
                        } else if (widget.account.state == AccountState.LISTED) {
                          status = AppLocalization.of(context).forSaleHeader;
                        }
                        if (!widget.account.isBorrowed && !widget.account.isFreepasa && !(widget.account.state == AccountState.LISTED)) {
                          return AutoSizeText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "",
                                  style: AppStyles
                                      .iconFontPrimaryBalanceMediumPascal(
                                          context),
                                ),
                                TextSpan(
                                    text: " ", style: TextStyle(fontSize: 7)),
                                TextSpan(
                                    text: widget.account.balance.toStringOpt(),
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
                          );                          
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                                gradient: StateContainer.of(context)
                                    .curTheme
                                    .gradientPrimary,
                                borderRadius: BorderRadius.circular(100)),
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                            child: AutoSizeText(
                              status,
                              style: AppStyles.textLightSmall600(context),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              minFontSize: 8,
                              stepGranularity: 1,
                            ),
                          );
                        }
                      },
                    ) 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // The function that does nothing
  void _doNothing() {
    return null;
  }

  // Widget that returns the hidden buttons
  List<Widget> _getButtons() {
    List<Widget> ret = [];
    if (widget.account.isFreepasa) {
      return ret;
    }
    ret.add(
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
                gradient: StateContainer.of(context).curTheme.gradientPrimary,
                boxShadow: [
                  StateContainer.of(context).curTheme.shadowPrimaryOne
                ]),
            child: FlatButton(
                highlightColor: StateContainer.of(context).curTheme.textLight15,
                splashColor: StateContainer.of(context).curTheme.textLight30,
                onPressed: () {
                  Navigator.pushNamed(context, '/account',
                      arguments: widget.account);
                  AppSheets.showBottomSheet(
                      context: context,
                      widget: ReceiveSheet(
                        accountName: widget.account.name.accountName,
                        accountNumber: widget.account.account,
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
    );
    widget.account.balance == Currency('0')
        ? _doNothing()
        : ret.add(
            // Send icon
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
                    gradient:
                        StateContainer.of(context).curTheme.gradientPrimary,
                    boxShadow: [
                      StateContainer.of(context).curTheme.shadowPrimaryOne
                    ]),
                child: FlatButton(
                    highlightColor:
                        StateContainer.of(context).curTheme.textLight15,
                    splashColor:
                        StateContainer.of(context).curTheme.textLight30,
                    onPressed: () {
                      if (widget.account.balance > Currency('0')) {
                        Navigator.pushNamed(context, '/account',
                            arguments: widget.account);
                        AppSheets.showBottomSheet(
                            context: context,
                            widget: SendSheet(account: widget.account, localCurrency: StateContainer.of(context).curCurrency));
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Icon(AppIcons.uparrow,
                        color: StateContainer.of(context).curTheme.textLight,
                        size: 24)),
              ),
            ),
          ));
    return ret;
  }
}
