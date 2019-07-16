import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/account/send/sending_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/fee_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/payload.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/number_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';
import 'package:event_taxi/event_taxi.dart';

class SendSheet extends StatefulWidget {
  final PascalAccount account;
  final Contact contact;
  final bool fromOverview;

  SendSheet({@required this.account, this.contact, this.fromOverview = false});

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
  String _payload;
  bool _encryptedPayload;

  // Fee
  bool _hasFee;

  // Contacts list
  List<Contact> _contacts;
  bool _isValidContactAndUnfocused;

  @override
  void initState() {
    super.initState();
    this.addressController = TextEditingController();
    this.amountController = TextEditingController();
    this.addressFocusNode = FocusNode();
    this.amountFocusNode = FocusNode();
    this._payload = "";
    this._hasFee = walletState.shouldHaveFee();
    this._isValidContactAndUnfocused = false;
    this._contacts = [];
    this._encryptedPayload = false;
    // TODO this is a placeholder
    _localCurrencyFormat =
        NumberFormat.simpleCurrency(locale: Locale("en", "US").toString());
    this.addressFocusNode.addListener(() {
      if (!this.addressFocusNode.hasFocus) {
        // When unfocused, add checksum to account if applicable
        if (!this.addressController.text.startsWith("@")) {
          try {
            AccountNumber numberFormatted =
                AccountNumber(this.addressController.text);
            this.addressController.text = numberFormatted.toString();
          } catch (e) {}
        }
        // Reset contacts list and check if contact is valid
        if (mounted) {
          setState(() {
            _contacts = [];
          });
        }
        sl.get<DBHelper>().getContactWithName(this.addressController.text).then((contact) {
          if (contact != null && mounted) {
            this.addressController.text = this.addressController.text.substring(1);
            setState(() {
              _isValidContactAndUnfocused = true;
              _payload = contact.payload;
              _encryptedPayload = false;
            });
            EventTaxiImpl.singleton().fire(PayloadChangedEvent(
              payload: contact.payload
            ));
          }
        });
      } else {
        // When focused
        if (this._isValidContactAndUnfocused) {
          setState(() {
            _isValidContactAndUnfocused = false;
          });
          this.addressController.text = "@${addressController.text}";
        }
        if (this.addressController.text.length == 0) {
          // Show contacts list
          sl.get<DBHelper>().getContacts().then((contacts) {
            if (mounted) {
              setState(() {
                _contacts = contacts;
              });
            }
          });
        } else if (this.addressController.text.startsWith("@")) {
          sl.get<DBHelper>().getContactsWithNameLike(this.addressController.text).then((contacts) {
            if (mounted) {
              setState(() {
                _contacts = contacts;
              });
            }
          });
        }
      }
    });
    // Initial contact information
    if (widget.contact != null) {
      this.addressController.text = widget.contact.name.toString().substring(1);
      this._payload = widget.contact.payload;
      this._isValidContactAndUnfocused = true;
    }
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
                                Navigator.of(context).pop();
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
                                    style: _isValidContactAndUnfocused ? AppStyles.contactsItemName(context) : AppStyles.paragraphMedium(context),
                                    prefix: _isValidContactAndUnfocused ? 
                                      Text("@",
                                      style: AppStyles.settingsHeader(context)) : null,
                                    maxLines: 1,
                                    onChanged: (text) async {
                                      if (destinationError != null && mounted) {
                                        setState(() {
                                          destinationError = null;
                                        });
                                      }
                                      // Handle contacts
                                     await _checkAndUpdateContacts();
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
                                          } catch (e) {
                                            checkAndValidateContact(name: data.text);
                                          }
                                        });
                                      },
                                    ),
                                    secondButton: TextFieldButton(
                                      icon: AppIcons.scan,
                                      onPressed: () async {
                                        String text = await UserDataUtil.getQRData(DataType.ACCOUNT);
                                        if (text != null) {
                                          addressController.text = text;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                // A stack to display contacts pop up
                                Stack(
                                  children: <Widget>[
                                    // Column for everything else except contacts pop up
                                    Column(
                                      children: <Widget>[
                                        // Error Text
                                        ErrorContainer(
                                          errorText: destinationError == null
                                              ? ""
                                              : destinationError,
                                        ),
                                        // Container for the amount text field
                                        Container(
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  30, 30, 30, 0),
                                          child: AppTextField(
                                            label: 'Amount',
                                            style: AppStyles.paragraphPrimary(
                                                context),
                                            maxLines: 1,
                                            inputType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            prefix: _localCurrencyMode
                                                ? Text("")
                                                : Icon(
                                                    AppIcons.pascalsymbol,
                                                    size: 15,
                                                    color: StateContainer.of(
                                                            context)
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
                                              LengthLimitingTextInputFormatter(
                                                  13),
                                              _localCurrencyMode
                                                  ? CurrencyFormatter(
                                                      decimalSeparator:
                                                          _localCurrencyFormat
                                                              .symbols
                                                              .DECIMAL_SEP,
                                                      commaSeparator:
                                                          _localCurrencyFormat
                                                              .symbols
                                                              .GROUP_SEP,
                                                      maxDecimalDigits: 2)
                                                  : CurrencyFormatter(
                                                      maxDecimalDigits:
                                                          NumberUtil
                                                              .maxDecimalDigits),
                                              LocalCurrencyFormatter(
                                                  active: _localCurrencyMode,
                                                  currencyFormat:
                                                      _localCurrencyFormat),
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
                                                feeText: walletState.MIN_FEE
                                                    .toStringOpt())
                                            : SizedBox(),
                                        // Error Text
                                        ErrorContainer(
                                          errorText: amountError == null
                                              ? ""
                                              : amountError,
                                        ),
                                      ],
                                    ),
                                    // Contacts pop up
                                    _getContactsPopup(),
                                  ],
                                ),
                                Payload(
                                  initialPayload: _payload,
                                  onPayloadChanged: (newPayload, encrypted) {
                                    setState(() {
                                      _payload = newPayload;
                                      _encryptedPayload = encrypted;
                                    });
                                  },
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
                        onPressed: () async {
                          await validateAndSend();
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
      ),
    );
  }

  Future<void> validateAndSend() async {
    bool hasError = false;
    Contact contact;
    Account accountState = walletState.getAccountState(widget.account);
    if (amountController.text.length == 0) {
      hasError = true;
      setState(() {
        amountError = "Amount is Required";
      });
    } else if (accountState.accountBalance < Currency(amountController.text)) {
      hasError = true;
      setState(() {
        amountError = "Insufficent Balance";
      });
    }
    String contactNameToCheck;
    if (addressController.text.startsWith("@")) {
      contactNameToCheck = addressController.text;
    } else if (_isValidContactAndUnfocused) {
      contactNameToCheck = "@${addressController.text}";
    }
    if (contactNameToCheck != null) {
      contact = await sl.get<DBHelper>().getContactWithName(contactNameToCheck);
      if (contact == null) {
        setState(() {
          destinationError = "Contact Does Not Exist";
        });
      }
    } else {
      try {
        AccountNumber(addressController.text);
      } catch (e) {
        hasError = true;
        setState(() {
          destinationError = "Invalid Destination";
        });
      }
    }
    if (!hasError) {
      AppSheets.showBottomSheet(
          context: context,
          widget: SendingSheet(
              destination: addressController.text,
              amount: amountController.text,
              source: widget.account,
              fee: _hasFee ? walletState.MIN_FEE : walletState.NO_FEE,
              payload: _payload,
              fromOverview: widget.fromOverview,
              contact: contact,
              encryptPayload: _encryptedPayload),
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

  Widget _getContactsPopup() {
    return _contacts.length > 0 ? Material(
      color: StateContainer.of(context).curTheme.backgroundPrimary,
      child: Container(
        constraints: BoxConstraints(maxHeight: 138),
        width: MediaQuery.of(context).size.width - 60,
        margin: EdgeInsetsDirectional.only(start: 30, end: 30, top: 3),
        decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            boxShadow: [
              StateContainer.of(context).curTheme.shadowAccountCard
            ]),
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            return _buildContactItem(_contacts[index]);
          },
        ),
      )
    ) : SizedBox();
  }

  Widget _buildContactItem(Contact contact) {
    return Container(
      width: double.maxFinite,
      height: 46,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          checkAndValidateContact(contact: contact);
        },
        child: Container(
          alignment: Alignment(-1, 0),
          margin:
              EdgeInsetsDirectional.only(start: 16, end: 16),
          child: AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(
                text: contact.name[0],
                style: AppStyles.settingsHeader(context),
              ),
              TextSpan(
                text: contact.name.substring(1),
                style: AppStyles.contactsItemName(context),
              ),
            ]),
            maxLines: 1,
            stepGranularity: 0.1,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );    
  }

  /// When address text field is changed
  Future<void> _checkAndUpdateContacts() async {
    bool isContact = addressController.text.startsWith("@");
    if (isContact) {
      List<Contact> matches = await sl.get<DBHelper>().getContactsWithNameLike(addressController.text);
      if (mounted) {
        setState(() {
          _contacts = matches;
        });      
      }
    } else if (addressController.text.isEmpty) {
      List<Contact> allContacts = await sl.get<DBHelper>().getContacts();
      if (mounted) {
        setState(() {
          _contacts = allContacts;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _contacts = [];
        });
      }
    }
  }

  /// When checking and validating a contact string (e.g. from paste button)
  Future<void> checkAndValidateContact({String name, Contact contact}) async {
    Contact c = name != null ? await sl.get<DBHelper>().getContactWithName(name) : contact;
    if (c != null && mounted) {
      addressFocusNode.unfocus();
      addressController.text = c.name.substring(1);
      setState(() {
        _isValidContactAndUnfocused = true;
        _payload = c.payload;
        _encryptedPayload = false;
      });
      EventTaxiImpl.singleton().fire(PayloadChangedEvent(
        payload: c.payload
      ));
    }
  }
}
