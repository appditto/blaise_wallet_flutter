import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/account/send/sending_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/fee_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/number_util.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';

class SendSheet extends StatefulWidget {
  final PascalAccount account;

  SendSheet({@required this.account});

  _SendSheetState createState() => _SendSheetState();
}

class _SendSheetState extends State<SendSheet> {
  TextEditingController addressController;
  TextEditingController amountController;
  FocusNode addressFocusNode;
  FocusNode amountFocusNode;

  // Local currency mode/fiat conversion
  bool _localCurrencyMode = false;
  String _lastLocalCurrencyAmount = "";
  String _lastCryptoAmount = "";
  NumberFormat _localCurrencyFormat;

  // Errors
  String destinationError;
  String amountError;

  // Payload
  bool _hasPayload;
  String _payload;

  // Fee
  bool _hasFee;

  Future<void> checkIfFee() async {
    if (!(await sl.get<SharedPrefsUtil>().canDoFreeTransaction())) {
      if (mounted) {
        setState(() {
          _hasFee = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    this.addressController = TextEditingController();
    this.amountController = TextEditingController();
    this.addressFocusNode = FocusNode();
    this.amountFocusNode = FocusNode();
    this._hasPayload = false;
    this._payload = "Testing the new payload.";
    this._hasFee = false;
    checkIfFee();
    // TODO this is a placeholder
    _localCurrencyFormat =
        NumberFormat.simpleCurrency(locale: Locale("en", "US").toString());
    this.addressController.addListener(() {
      if (!this.addressFocusNode.hasFocus) {
        try {
          AccountNumber numberFormatted =
              AccountNumber(this.addressController.text);
          this.addressController.text = numberFormatted.toString();
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
      child: Column(
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
                              highlightColor: StateContainer.of(context)
                                  .curTheme
                                  .textLight15,
                              splashColor: StateContainer.of(context)
                                  .curTheme
                                  .textLight30,
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
                            "SEND",
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
                        Container(
                          margin:
                              EdgeInsetsDirectional.fromSTEB(30, 16, 30, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Account name
                                  isEmpty(widget.account.name.toString())
                                      ? SizedBox()
                                      : Container(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  45),
                                          child: AutoSizeText(
                                            widget.account.name.toString(),
                                            style: AppStyles.settingsItemHeader(
                                                context),
                                            maxLines: 1,
                                            minFontSize: 8,
                                            stepGranularity: 0.1,
                                          ),
                                        ),
                                  // Acccount address
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                45),
                                    margin: EdgeInsetsDirectional.only(top: 2),
                                    child: AutoSizeText(
                                      widget.account.account.toString(),
                                      style: AppStyles.monoTextDarkSmall400(
                                          context),
                                      maxLines: 1,
                                      minFontSize: 8,
                                      stepGranularity: 0.1,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Account balance
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                45),
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
                                              style: TextStyle(fontSize: 7)),
                                          TextSpan(
                                              text: widget.account.balance
                                                  .toStringOpt(),
                                              style: AppStyles.balanceSmall(
                                                  context)),
                                        ],
                                      ),
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      minFontSize: 8,
                                      stepGranularity: 0.1,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  // Balance in fiat
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                45),
                                    margin: EdgeInsetsDirectional.only(top: 2),
                                    child: AutoSizeText(
                                      "(\$2448.91)",
                                      style:
                                          AppStyles.primarySmallest400(context),
                                      maxLines: 1,
                                      minFontSize: 8,
                                      stepGranularity: 0.1,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: KeyboardAvoider(
                            duration: Duration(milliseconds: 0),
                            autoScroll: true,
                            focusPadding: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Container for the address text field
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 10, 30, 0),
                                  child: AppTextField(
                                    label: 'Address',
                                    style: AppStyles.paragraphMedium(context),
                                    maxLines: 1,
                                    isAddress: true,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(
                                          RegExp("[0-9-]")),
                                      PascalAccountFormatter()
                                    ],
                                    onChanged: (text) {
                                      if (destinationError != null) {
                                        setState(() {
                                          destinationError = null;
                                        });
                                      }
                                    },
                                    focusNode: addressFocusNode,
                                    controller: addressController,
                                    firstButton: TextFieldButton(
                                      icon: AppIcons.paste,
                                      onPressed: () {
                                        Clipboard.getData("text/plain")
                                            .then((data) {
                                          try {
                                            AccountNumber num =
                                                AccountNumber(data.text);
                                            addressController.text =
                                                num.toString();
                                          } catch (e) {}
                                        });
                                      },
                                    ),
                                    secondButton: TextFieldButton(
                                      icon: AppIcons.scan,
                                      onPressed: () {
                                        setState(() {
                                          this._hasPayload = !this._hasPayload;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                // Error Text
                                ErrorContainer(
                                  errorText: destinationError == null
                                      ? ""
                                      : destinationError,
                                ),
                                // Container for the amount text field
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 0),
                                  child: AppTextField(
                                    label: 'Amount',
                                    style: AppStyles.paragraphPrimary(context),
                                    maxLines: 1,
                                    inputType: TextInputType.numberWithOptions(
                                        decimal: true),
                                    prefix: _localCurrencyMode
                                        ? Text("")
                                        : Icon(
                                            AppIcons.pascalsymbol,
                                            size: 15,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                          ),
                                    onChanged: (text) {
                                      if (amountError != null) {
                                        setState(() {
                                          amountError = null;
                                        });
                                      }
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(13),
                                      _localCurrencyMode
                                          ? CurrencyFormatter(
                                              decimalSeparator:
                                                  _localCurrencyFormat
                                                      .symbols.DECIMAL_SEP,
                                              commaSeparator:
                                                  _localCurrencyFormat
                                                      .symbols.GROUP_SEP,
                                              maxDecimalDigits: 2)
                                          : CurrencyFormatter(
                                              maxDecimalDigits:
                                                  NumberUtil.maxDecimalDigits),
                                      LocalCurrencyFormatter(
                                          active: _localCurrencyMode,
                                          currencyFormat: _localCurrencyFormat),
                                    ],
                                    focusNode: amountFocusNode,
                                    controller: amountController,
                                    firstButton: TextFieldButton(
                                      icon: AppIcons.max,
                                      onPressed: () {
                                        amountController.text = widget
                                            .account.balance
                                            .toStringOpt();
                                        amountFocusNode.unfocus();
                                      },
                                    ),
                                    secondButton: TextFieldButton(
                                        icon: AppIcons.currencyswitch,
                                        onPressed: () {
                                          toggleLocalCurrency();
                                        }),
                                  ),
                                ),
                                // Fee container
                                _hasFee
                                    ? FeeContainer(
                                        feeText:
                                            walletState.MIN_FEE.toStringOpt())
                                    : SizedBox(),
                                // Error Text
                                ErrorContainer(
                                  errorText:
                                      amountError == null ? "" : amountError,
                                ),
                                // Payload text and edit button
                                this._hasPayload
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          // Container for the payload
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110),
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 20, 12, 0),
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
                                                          .textDark15),
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .textDark10,
                                            ),
                                            child: AutoSizeText(
                                              this._payload,
                                              maxLines: 3,
                                              stepGranularity: 0.1,
                                              minFontSize: 6,
                                              textAlign: TextAlign.left,
                                              style: AppStyles.paragraphMedium(
                                                  context),
                                            ),
                                          ),
                                          // Container for the edit button
                                          Container(
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(0, 20, 30, 0),
                                              child: TextFieldButton(
                                                icon: Icons.edit,
                                              ))
                                        ],
                                      )
                                    :
                                    // "Add Payload" button
                                    Row(
                                        children: <Widget>[
                                          Container(
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .backgroundPrimary,
                                              boxShadow: [
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .shadowTextDark,
                                              ],
                                            ),
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 20, 30, 40),
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0)),
                                              child: AutoSizeText(
                                                "+ Add a Payload",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                stepGranularity: 0.1,
                                                style: AppStyles.buttonMiniBg(
                                                    context),
                                              ),
                                              onPressed: () async {
                                                showAppDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        DialogOverlay(
                                                          payload: true,
                                                        ));
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // "Send" button
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.Primary,
                        text: "Send",
                        buttonTop: true,
                        onPressed: () {
                          validateAndSend();
                        },
                      ),
                    ],
                  ),
                  // "Close" button
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.PrimaryOutline,
                        text: "Close",
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
      ),
    );
  }

  void validateAndSend() {
    bool hasError = false;
    Account accountState = walletState.getAccountState(widget.account);
    if (accountState.accountBalance < Currency(amountController.text)) {
      hasError = true;
      setState(() {
        amountError = "Insufficent Balance";
      });
    }
    try {
      AccountNumber(addressController.text);
    } catch (e) {
      hasError = true;
      setState(() {
        destinationError = "Invalid Destination";
      });
    }
    if (!hasError) {
      AppSheets.showBottomSheet(
          context: context,
          widget: SendingSheet(
              destination: addressController.text,
              amount: amountController.text,
              source: widget.account,
              fee: _hasFee ? walletState.MIN_FEE : walletState.NO_FEE),
          noBlur: true);
    }
  }

  void toggleLocalCurrency() {
    // Keep a cache of previous amounts because, it's kinda nice to see approx what nano is worth
    // this way you can tap button and tap back and not end up with X.9993451 NANO
    if (_localCurrencyMode) {
      // Switching to crypto-mode
      String cryptoAmountStr;
      // Check out previous state
      if (amountController.text == _lastLocalCurrencyAmount) {
        cryptoAmountStr = _lastCryptoAmount;
      } else {
        _lastLocalCurrencyAmount = amountController.text;
        _lastCryptoAmount = _convertLocalCurrencyToCrypto();
        cryptoAmountStr = _lastCryptoAmount;
      }
      setState(() {
        _localCurrencyMode = false;
      });
      Future.delayed(Duration(milliseconds: 50), () {
        amountController.text = cryptoAmountStr;
        amountController.selection = TextSelection.fromPosition(
            TextPosition(offset: cryptoAmountStr.length));
      });
    } else {
      // Switching to local-currency mode
      String localAmountStr;
      // Check our previous state
      if (amountController.text == _lastCryptoAmount) {
        localAmountStr = _lastLocalCurrencyAmount;
      } else {
        _lastCryptoAmount = amountController.text;
        _lastLocalCurrencyAmount = _convertCryptoToLocalCurrency();
        localAmountStr = _lastLocalCurrencyAmount;
      }
      setState(() {
        _localCurrencyMode = true;
      });
      Future.delayed(Duration(milliseconds: 50), () {
        amountController.text = localAmountStr;
        amountController.selection = TextSelection.fromPosition(
            TextPosition(offset: localAmountStr.length));
      });
    }
  }

  String _convertLocalCurrencyToCrypto() {
    String convertedAmt = amountController.text.replaceAll(",", ".");
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty) {
      return "";
    }
    Decimal valueLocal = Decimal.parse(convertedAmt);
    Decimal conversion = Decimal.parse("1.0"); // TODO this is a fake conversion
    return NumberUtil.truncateDecimal(valueLocal / conversion).toString();
  }

  String _convertCryptoToLocalCurrency() {
    String convertedAmt =
        NumberUtil.sanitizeNumber(amountController.text, maxDecimalDigits: 2);
    if (convertedAmt.isEmpty) {
      return "";
    }
    Decimal valueCrypto = Decimal.parse(convertedAmt);
    Decimal conversion = Decimal.parse("1.0");
    convertedAmt =
        NumberUtil.truncateDecimal(valueCrypto * conversion, digits: 2)
            .toString();
    convertedAmt =
        convertedAmt.replaceAll(".", _localCurrencyFormat.symbols.DECIMAL_SEP);
    convertedAmt = _localCurrencyFormat.currencySymbol + convertedAmt;
    return convertedAmt;
  }
}
