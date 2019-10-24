import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/authenticated_event.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/account/send/sent_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/routes.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/pin_screen.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/authentication.dart';
import 'package:blaise_wallet_flutter/util/haptic_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendingSheet extends StatefulWidget {
  final String destination;
  final String amount;
  final String localCurrencyAmount;
  final AvailableCurrency localCurrency;
  final String payload;
  final PascalAccount source;
  final Currency fee;
  final bool fromOverview;
  final Contact contact;
  final bool encryptPayload;
  final AccountName accountName;

  SendingSheet(
      {@required this.destination,
      @required this.amount,
      @required this.source,
      @required this.fee,
      this.localCurrencyAmount,
      this.localCurrency,
      this.contact,
      this.payload = "",
      this.fromOverview = false,
      this.encryptPayload = false,
      this.accountName});

  _SendingSheetState createState() => _SendingSheetState();
}

class _SendingSheetState extends State<SendingSheet> {
  final Logger log = sl.get<Logger>();

  OverlayEntry _overlay;

  StreamSubscription<AuthenticatedEvent> _authSub;

  Uint8List encryptedPayload;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((event) {
      if (event.authType == AUTH_EVENT_TYPE.SEND) {
        doSend();
      }
    });
  }

  void _destroyBus() {
    if (_authSub != null) {
      _authSub.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

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
                      SizedBox(width: 65, height: 50),
                      // Header
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          toUppercase(AppLocalization.of(context)
                              .sendingSheetHeader
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Paragraph
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context).sendingConfirmParagraph,
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
                            color:
                                StateContainer.of(context).curTheme.textDark10,
                          ),
                          child: widget.contact == null && widget.accountName == null
                              ? AutoSizeText(
                                  widget.destination,
                                  maxLines: 1,
                                  stepGranularity: 0.1,
                                  minFontSize: 8,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.privateKeyTextDark(context),
                                )
                              : widget.contact != null ? AutoSizeText.rich(
                                  TextSpan(children: [
                                    TextSpan(
                                      text: " ",
                                      style: AppStyles.iconFontPrimarySmall(
                                          context),
                                    ),
                                    TextSpan(
                                        text: widget.contact.name,
                                        style: AppStyles.contactsItemName(
                                            context)),
                                    TextSpan(
                                      text: " (" +
                                          widget.contact.account.toString() +
                                          ")",
                                      style: AppStyles.privateKeyTextDarkFaded(
                                          context),
                                    ),
                                  ]),
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  minFontSize: 8,
                                  stepGranularity: 0.1,
                                ) :
                                   AutoSizeText.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                          text: widget.accountName.toString(),
                                          style: AppStyles.contactsItemName(
                                              context)),
                                      TextSpan(
                                        text: " (" +
                                            widget.destination.toString() +
                                            ")",
                                        style: AppStyles.privateKeyTextDarkFaded(
                                            context),
                                      ),
                                    ]),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    minFontSize: 8,
                                    stepGranularity: 0.1,
                                  ) 
                                ,
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
                                      style: AppStyles.textFieldLabel(context),
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
                                              .primary15),
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary10,
                                    ),
                                    child: AutoSizeText.rich(
                                      TextSpan(
                                        children: widget.localCurrencyAmount == null ? [
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
                                        ] :
                                        [
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
                                          TextSpan(
                                              text: " (",
                                              style: AppStyles.balanceSmall(
                                                  context)),
                                          TextSpan(
                                            text: widget.localCurrency.getCurrencySymbol(),
                                            style: AppStyles.balanceSmall(context)
                                          ),
                                          TextSpan(
                                              text: widget.localCurrencyAmount,
                                              style: AppStyles.balanceSmall(
                                                  context)),
                                          TextSpan(
                                              text: ")",
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
                                            style: AppStyles.textFieldLabel(
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
                                                    text: widget.fee
                                                        .toStringOpt(),
                                                    style:
                                                        AppStyles.balanceSmall(
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
                                  style: AppStyles.textFieldLabel(context),
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
                                                (widget.encryptPayload
                                                    ? 101
                                                    : 86)),
                                        child: AutoSizeText(
                                          widget.payload,
                                          maxLines: 3,
                                          stepGranularity: 0.1,
                                          minFontSize: 8,
                                          textAlign: TextAlign.left,
                                          style: AppStyles.paragraph(context),
                                        ),
                                      ),
                                      widget.encryptPayload
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
                // "CONFIRM" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: toUppercase(AppLocalization.of(context)
                          .confirmButton
                          ,context),
                      buttonTop: true,
                      onPressed: () async {
                        if (await authenticate()) {
                          EventTaxiImpl.singleton()
                              .fire(AuthenticatedEvent(AUTH_EVENT_TYPE.SEND));
                        }
                      },
                    ),
                  ],
                ),
                // "CANCEL" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: toUppercase(AppLocalization.of(context)
                          .cancelButton
                          ,context),
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

  Future<void> doSend({Currency fee}) async {
    fee = fee == null ? widget.fee : fee;
    try {
      showOverlay(context);
      if (widget.encryptPayload && encryptedPayload == null) {
        // Try to encrypt the payload with the receivers public key
        encryptedPayload = await walletState
            .getAccountState(widget.source)
            .encryptPayloadEcies(
                widget.payload,
                widget.contact == null
                    ? AccountNumber(widget.destination)
                    : widget.contact.account);
        if (encryptedPayload == null) {
          _overlay?.remove();
          UIUtil.showSnackbar(
              AppLocalization.of(context).failedToEncryptPayloadError, context);
          return;
        }
      }
      // Do send
      RPCResponse result = await walletState
          .getAccountState(widget.source)
          .doSend(
              amount: widget.amount,
              destination: widget.contact == null
                  ? widget.destination
                  : widget.contact.account.toString(),
              payload: widget.payload,
              encryptedPayload: encryptedPayload,
              fee: fee);
      if (result.isError) {
        ErrorResponse errResp = result;
        UIUtil.showSnackbar(errResp.errorMessage.replaceAll("founds", "funds"), context);
        _overlay?.remove();
        Navigator.of(context).pop();
      } else {
        _overlay?.remove();
        OperationsResponse resp = result;
        PascalOperation op = resp.operations[0];
        if (op.valid == null || op.valid) {
          Navigator.of(context).popUntil(RouteUtils.withNameLike(
              widget.fromOverview ? "/overview" : "/account"));
          AppSheets.showBottomSheet(
              context: context,
              closeOnTap: true,
              widget: SentSheet(
                  destination: widget.contact == null
                      ? widget.destination
                      : widget.contact.account.toString(),
                  amount: widget.amount,
                  localCurrencyAmount: widget.localCurrencyAmount,
                  localCurrency: widget.localCurrency,
                  fee: fee,
                  payload: widget.payload,
                  contact: widget.contact,
                  encryptedPayload: widget.encryptPayload,
                  accountName: widget.accountName));
        } else {
          if (op.errors.contains("zero fee") &&
              widget.fee == walletState.NO_FEE) {
            UIUtil.showFeeDialog(
                context: context,
                onConfirm: () async {
                  Navigator.of(context).pop();
                  doSend(fee: walletState.MIN_FEE);
                });
          } else {
            UIUtil.showSnackbar("${op.errors}", context);
          }
        }
      }
    } catch (e) {
      log.e(e.toString());
      _overlay?.remove();
      UIUtil.showSnackbar(
          AppLocalization.of(context).somethingWentWrongError, context);
    }
  }

  Future<bool> _authenticateBiometrics(AuthUtil authUtil, String message) async {
    // Biometric auth
    bool authenticated = await authUtil.authenticateWithBiometrics(message);
    if (authenticated) {
      HapticUtil.fingerprintSucess();
    }
    return authenticated;
  }

  Future<bool> _authenticatePin(String message) async {
      String expectedPin = await sl.get<Vault>().getPin();
      bool result = await Navigator.of(context)
          .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
        return PinScreen(
          type: PinOverlayType.ENTER_PIN,
          onSuccess: (pin) {
            Navigator.of(context).pop(true);
          },
          expectedPin: expectedPin,
          description: message,
        );
      }));
      await Future.delayed(Duration(milliseconds: 200));
      return result != null && result;    
  }

  Future<bool> authenticate() async {
    String message = AppLocalization.of(context)
        .authenticateToSendParagraph
        .replaceAll("%1", widget.amount);
    // Authenticate
    AuthUtil authUtil = AuthUtil();
    if (await authUtil.useBiometrics()) {
      // Biometric auth
      try {
        return await _authenticateBiometrics(authUtil, message);
      } catch (e) {
        return await _authenticatePin(message);
      }
    } else {
      return await _authenticatePin(message);
    }
  }
}
