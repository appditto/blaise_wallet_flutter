import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/account/send/sent_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/routes.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/authentication.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class SendingSheet extends StatefulWidget {
  final String destination;
  final String amount;
  final String payload;
  final PascalAccount source;
  final Currency fee;

  SendingSheet(
      {@required this.destination,
      @required this.amount,
      @required this.source,
      @required this.fee,
      this.payload = ""});

  _SendingSheetState createState() => _SendingSheetState();
}

class _SendingSheetState extends State<SendingSheet> {
  OverlayEntry _overlay;

  void showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    _overlay = OverlayEntry(
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: StateContainer.of(context).curTheme.overlay20,
          child: Center(
            child: //Container for the animation
                Container(
              margin: EdgeInsetsDirectional.only(
                  top: MediaQuery.of(context).padding.top),
              //Width/Height ratio for the animation is needed because BoxFit is not working as expected
              width: double.maxFinite,
              height: MediaQuery.of(context).size.width,
              child: Center(
                child: FlareActor(
                  StateContainer.of(context).curTheme.animationSend,
                  animation: "main",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(_overlay);
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
                              Navigator.pop(context);
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
                          "SENDING",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Paragraph
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText(
                          "Confirm the transaction details to send.",
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
                          "Address",
                          style: AppStyles.textFieldLabel(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Container for the account number
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark15),
                          color: StateContainer.of(context).curTheme.textDark10,
                        ),
                        child: AutoSizeText(
                          widget.destination,
                          maxLines: 1,
                          stepGranularity: 0.1,
                          minFontSize: 8,
                          textAlign: TextAlign.center,
                          style: AppStyles.privateKeyTextDark(context),
                        ),
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
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-76/2),
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: AutoSizeText(
                                    "Amount",
                                    style: AppStyles.textFieldLabel(context),
                                    maxLines: 1,
                                    stepGranularity: 0.1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                // Container for the Amount
                                Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-76/2),
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
                                            .primary15),
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary10,
                                  ),
                                  child: AutoSizeText.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "",
                                          style: AppStyles
                                              .iconFontPrimaryBalanceSmallPascal(
                                                  context),
                                        ),
                                        TextSpan(
                                            text: " ",
                                            style: TextStyle(fontSize: 8)),
                                        TextSpan(
                                            text: widget.amount,
                                            style: AppStyles.balanceSmall(
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
                            widget.fee.toStringOpt() != "0"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // "Fee" header
                                      Container(
                                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-76/2),
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16, 30, 0, 0),
                                        child: AutoSizeText(
                                          "Fee",
                                          style:
                                              AppStyles.textFieldLabel(context),
                                          maxLines: 1,
                                          stepGranularity: 0.1,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      // Container for the fee
                                      Container(
                                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-76/2),
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16, 12, 0, 0),
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 12, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              width: 1,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .primary15),
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary10,
                                        ),
                                        child: AutoSizeText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "",
                                                style: AppStyles
                                                    .iconFontPrimaryBalanceSmallPascal(
                                                        context),
                                              ),
                                              TextSpan(
                                                  text: " ",
                                                  style:
                                                      TextStyle(fontSize: 8)),
                                              TextSpan(
                                                  text:
                                                      widget.fee.toStringOpt(),
                                                  style: AppStyles.balanceSmall(
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
                      )
                    ],
                  ),
                ),
                // "CONFIRM" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "CONFIRM",
                      buttonTop: true,
                      onPressed: () async {
                        await doSend();
                      },
                    ),
                  ],
                ),
                // "CANCEL" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: "CANCEL",
                      onPressed: () {
                        Navigator.pop(context);
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

  Future<void> doSend({Currency fee, bool noAuth = false}) async {
    fee = fee == null ? widget.fee : fee;
    if (noAuth || (await AuthUtil()
        .authenticate("Authenticate to send ${widget.amount} Pascal."))) {
      try {
        showOverlay(context);
        // Do send
        RPCResponse result = await walletState
            .getAccountState(widget.source)
            .doSend(
                amount: widget.amount,
                destination: widget.destination,
                payload: widget.payload,
                fee: fee);
        if (result.isError) {
          ErrorResponse errResp = result;
          UIUtil.showSnackbar(errResp.errorMessage, context);
          _overlay?.remove();
          Navigator.of(context).pop();
        } else {
          _overlay?.remove();
          OperationsResponse resp = result;
          PascalOperation op = resp.operations[0];
          if (op.valid == null || op.valid) {
            Navigator.of(context).popUntil(RouteUtils.withNameLike("/account"));
            AppSheets.showBottomSheet(
                context: context,
                closeOnTap: true,
                widget: SentSheet(
                    destination: widget.destination, amount: widget.amount));
          } else {
            if (op.errors.contains("zero fee") && widget.fee == walletState.NO_FEE) {
              UIUtil.showFeeDialog(
                context: context,
                onConfirm: () async {
                  Navigator.of(context).pop();
                  doSend(fee: walletState.MIN_FEE, noAuth: true);
                }
              );
            } else {
              UIUtil.showSnackbar("${op.errors}", context);
            }
          }
        }
      } catch (e) {
        _overlay?.remove();
        UIUtil.showSnackbar("Something went wrong, try again later.", context);
      }
    }
  }
}
