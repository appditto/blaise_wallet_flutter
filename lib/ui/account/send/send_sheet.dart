import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
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
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  final AvailableCurrency localCurrency;

  SendSheet({@required this.account, @required this.localCurrency, this.contact, this.fromOverview = false});

  _SendSheetState createState() => _SendSheetState();
}

class _SendSheetState extends State<SendSheet> {
  String addressControllerText = "";
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

  // Account name list
  PascalAccount _selectedAccountName;
  List<PascalAccount> _accountNames;
  List<PascalAccount> _accountNamesUnfocused;
  bool _accountNamesLoading;

  // Account State
  Account accountState;

  // Switch to Contacts field
  bool _isDestinationFieldTypeContact;
  String _lastContactFieldValue = "";
  String _lastNameFieldValue = "";

  bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;

  @override
  void initState() {
    super.initState();
    this.addressController = TextEditingController();
    this.addressController.addListener(() {
      if (mounted) {
        setState(() {
          addressControllerText = addressController.text;
        });
      }
    });
    this.amountController = TextEditingController();
    this.addressFocusNode = FocusNode();
    this.amountFocusNode = FocusNode();
    this._payload = "";
    this._hasFee = walletState.shouldHaveFee();
    this._isValidContactAndUnfocused = false;
    this._isDestinationFieldTypeContact = false;
    this._contacts = [];
    this._accountNames = [];
    this._accountNamesUnfocused = [];
    this._accountNamesLoading = false;
    this._encryptedPayload = false;
    this.accountState = walletState.getAccountState(widget.account);
    _localCurrencyFormat =
        NumberFormat.currency(locale: widget.localCurrency.getLocale().toString(), symbol: widget.localCurrency.getCurrencySymbol());
    this.addressFocusNode.addListener(() {
      if (!this.addressFocusNode.hasFocus) {
        // When unfocused, add checksum to account if applicable
        if (this.addressController.text.length > 0 && isDigit(this.addressController.text, 0)) {
          try {
            AccountNumber numberFormatted =
                AccountNumber(this.addressController.text);
            this.addressController.text = numberFormatted.toString();
          } catch (e) {}
        }
        // Reset contacts list and check if contact is valid
        if (_isDestinationFieldTypeContact) {
          if (mounted) {
            setState(() {
              _contacts = [];
            });
          }
          sl
              .get<DBHelper>()
              .getContactWithName(this.addressController.text)
              .then((contact) {
            if (contact != null && mounted) {
              this.addressController.text =
                  this.addressController.text;
              setState(() {
                _isValidContactAndUnfocused = true;
                _payload = contact.payload;
                _encryptedPayload = false;
              });
              EventTaxiImpl.singleton()
                  .fire(PayloadChangedEvent(payload: contact.payload));
            }
          });
        } else {
          // Hide the account name list
          if (_accountNames.isNotEmpty) {
            setState(() {
              _accountNames = [];
            });
          }
          // Change text for selected account name
          if (_selectedAccountName != null) {
            addressController.text = "${_selectedAccountName.name.toString()} (${_selectedAccountName.account.toString()})";
          }
        }
      } else {
        // When focused
        if (this._isValidContactAndUnfocused) {
          setState(() {
            _isValidContactAndUnfocused = false;
          });
        }
        if (this.addressController.text.length == 0 && _isDestinationFieldTypeContact) {
          // Show contacts list
          sl.get<DBHelper>().getContacts().then((contacts) {
            if (mounted) {
              setState(() {
                _contacts = contacts;
              });
            }
          });
        } else if (_isDestinationFieldTypeContact) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(this.addressController.text)
              .then((contacts) {
            if (mounted) {
              setState(() {
                _contacts = contacts;
              });
            }
          });
        } else {
          // Show account names list
          if (_accountNamesUnfocused.isNotEmpty) {
            setState(() {
              _accountNames = _accountNamesUnfocused;
            });
          }
          // Change text for selected account name
          if (_selectedAccountName != null) {
            addressController.text =_selectedAccountName.name.toString();
            addressController.selection = TextSelection.fromPosition(
                                            TextPosition(offset: addressController.text.length));
          }
        }
      }
    });
    // Initial contact information
    if (widget.contact != null) {
      this.addressController.text = widget.contact.name.toString();
      this._payload = widget.contact.payload;
      this._isValidContactAndUnfocused = true;
      this._isDestinationFieldTypeContact = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
      child: Column(
        children: <Widget>[
          Expanded(
            // Stack for everything else & account search button
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color:
                        StateContainer.of(context).curTheme.backgroundPrimary,
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
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
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
                              margin:
                                  EdgeInsetsDirectional.only(start: 5, end: 10),
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
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
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
                                toUppercase(AppLocalization.of(context)
                                    .sendSheetHeader
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  30, 16, 30, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Account name
                                      isEmpty(widget.account.name.toString())
                                          ? SizedBox()
                                          : Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2 -
                                                          45),
                                              child: AutoSizeText(
                                                widget.account.name.toString(),
                                                style: AppStyles
                                                    .settingsItemHeader(
                                                        context),
                                                maxLines: 1,
                                                minFontSize: 8,
                                                stepGranularity: 0.1,
                                              ),
                                            ),
                                      // Acccount address
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                45),
                                        margin:
                                            EdgeInsetsDirectional.only(top: 2),
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
                                            maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
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
                                                  style:
                                                      TextStyle(fontSize: 7)),
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
                                      Observer(
                                        builder: (BuildContext context) {
                                          if (walletState.localCurrencyPrice !=
                                              null) {
                                            return Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2 -
                                                          45),
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      top: 2),
                                              child: AutoSizeText(
                                                "(${walletState.getLocalCurrencyDisplay(currency: StateContainer.of(context).curCurrency, amount: accountState.accountBalance)})",
                                                style: AppStyles
                                                    .primarySmallest400(
                                                        context),
                                                maxLines: 1,
                                                minFontSize: 8,
                                                stepGranularity: 0.1,
                                                textAlign: TextAlign.end,
                                              ),
                                            );
                                          }
                                          return SizedBox();
                                        },
                                      )
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
                                      child: _isDestinationFieldTypeContact
                                          ? AppTextField(
                                              label: AppLocalization.of(context)
                                                  .contactNameTextFieldHeader,
                                              style: AppStyles.contactsItemName(
                                                  context),
                                              prefix:
                                                  _isValidContactAndUnfocused
                                                      ? Text(
                                                          " ",
                                                          style: AppStyles
                                                              .iconFontPrimarySmall(
                                                                  context),
                                                        )
                                                      : null,
                                              maxLines: 1,
                                              onChanged: (text) async {
                                                if (destinationError != null &&
                                                    mounted) {
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
                                                icon: Icons
                                                    .account_balance_wallet,
                                                onPressed: () {
                                                  setState(() {
                                                    destinationError = null;
                                                    _isDestinationFieldTypeContact = false;
                                                    _lastContactFieldValue = addressController.text;
                                                    addressController.text = _lastNameFieldValue;
                                                  });
                                                  if (_selectedAccountName == null) {
                                                    addressFocusNode
                                                        .requestFocus();
                                                    addressController.selection = TextSelection.fromPosition(
                                                        TextPosition(offset: addressController.text.length));
                                                  } else {
                                                    addressFocusNode.unfocus();
                                                  }
                                                },
                                              ),
                                              textInputAction: TextInputAction.next,
                                              onSubmitted: (text) {
                                                amountFocusNode.requestFocus();
                                              },
                                            )
                                          : AppTextField(
                                              label: AppLocalization.of(context)
                                                  .addressTextFieldHeader,
                                              style: _isValidContactAndUnfocused
                                                  ? AppStyles.contactsItemName(
                                                      context)
                                                  : AppStyles.paragraphMedium(
                                                      context),
                                              prefix:
                                                  _isValidContactAndUnfocused
                                                      ? Text(
                                                          " ",
                                                          style: AppStyles
                                                              .iconFontPrimarySmall(
                                                                  context),
                                                        )
                                                      : null,
                                              maxLines: 1,
                                              onChanged: (text) async {
                                                if (destinationError != null &&
                                                    mounted) {
                                                  setState(() {
                                                    destinationError = null;
                                                  });
                                                }
                                                // Reset selected name
                                                if (mounted && _selectedAccountName != null) {
                                                  setState(() {
                                                    _selectedAccountName = null;
                                                  });
                                                }
                                              },
                                              focusNode: addressFocusNode,
                                              controller: addressController,
                                              secondButton: TextFieldButton(
                                                icon: AppIcons.paste,
                                                onPressed: () {
                                                  Clipboard.getData(
                                                          "text/plain")
                                                      .then((data) {
                                                    try {
                                                      AccountNumber num =
                                                          AccountNumber(
                                                              data.text);
                                                      addressController.text =
                                                          num.toString();
                                                    } catch (e) {
                                                      checkAndValidateContact(
                                                          name: data.text);
                                                    }
                                                  });
                                                },
                                              ),
                                              firstButton: TextFieldButton(
                                                icon: AppIcons.contacts,
                                                onPressed: () {
                                                  setState(() {
                                                    destinationError = null;
                                                    _isDestinationFieldTypeContact = true;
                                                    _lastNameFieldValue = addressController.text;
                                                    addressController.text = _lastContactFieldValue;                                                    
                                                  });
                                                  addressFocusNode
                                                      .requestFocus();
                                                  addressController.selection = TextSelection.fromPosition(
                                                      TextPosition(offset: addressController.text.length));
                                                },
                                              ),
                                              textInputAction: TextInputAction.next,
                                              onSubmitted: (text) {
                                                amountFocusNode.requestFocus();
                                              },
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
                                              errorText:
                                                  destinationError == null
                                                      ? ""
                                                      : destinationError,
                                            ),
                                            // Container for the amount text field
                                            Container(
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(30, 30, 30, 0),
                                              child: Observer(
                                                builder: (context) {
                                                  bool showCurrencySwitch = walletState.localCurrencyPrice != null;
                                                  return AppTextField(
                                                    label: AppLocalization.of(
                                                            context)
                                                        .amountTextFieldHeader,
                                                    style: AppStyles
                                                        .paragraphPrimary(
                                                            context),
                                                    maxLines: 1,
                                                    inputType: TextInputType
                                                        .numberWithOptions(
                                                            decimal: true),
                                                    prefix: _localCurrencyMode
                                                        ? Text(
                                                          widget.localCurrency.getCurrencySymbol(),
                                                          style: AppStyles.iconFontPrimarySmall(
                                                                    context),
                                                        )
                                                        : Icon(
                                                            AppIcons.pascalsymbol,
                                                            size: 15,
                                                            color:
                                                                StateContainer.of(
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
                                                          active:
                                                              _localCurrencyMode,
                                                          currencyFormat:
                                                              _localCurrencyFormat),
                                                    ],
                                                    focusNode: amountFocusNode,
                                                    controller: amountController,
                                                    firstButton: TextFieldButton(
                                                      icon: AppIcons.max,
                                                      onPressed: () {
                                                        amountController.text =
                                                            widget.account.balance
                                                                .toStringOpt();
                                                        amountFocusNode.unfocus();
                                                      },
                                                    ),
                                                    secondButton: showCurrencySwitch ? TextFieldButton(
                                                        icon: AppIcons
                                                            .currencyswitch,
                                                        onPressed: () {
                                                          toggleLocalCurrency();
                                                        }
                                                      ) : null
                                                  );
                                                }
                                              )
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
                                            Payload(
                                              initialPayload: _payload,
                                              onPayloadChanged:
                                                  (newPayload, encrypted) {
                                                setState(() {
                                                  _payload = newPayload;
                                                  _encryptedPayload = encrypted;
                                                });
                                              },
                                            ),
                                            // Bottom Margin
                                            SizedBox(height: 24),
                                          ],
                                        ),
                                        // Contacts pop up
                                        _getContactsPopup(),
                                        // Account name pop up
                                        _getAccountNameList(),
                                      ],
                                    ),
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
                            text: AppLocalization.of(context).sendButton,
                            buttonTop: true,
                            onPressed: () async {
                              await validateAndSend();
                            },
                          ),
                        ],
                      ),
                      // "Scan QR Code" button
                      Row(
                        children: <Widget>[
                          AppButton(
                            type: AppButtonType.PrimaryOutline,
                            text: AppLocalization.of(context).scanQRCodeButton,
                            onPressed: () async {
                              String text = await UserDataUtil.getQRData(
                                  DataType.ACCOUNT,
                                  StateContainer.of(context).curTheme.scannerTheme);
                              if (text != null) {
                                addressController.text = text;
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Account search button
                this.addressFocusNode.hasFocus &&
                        !_isDestinationFieldTypeContact &&
                        (this.addressControllerText.length > 2 && !isDigit(this.addressControllerText, 0))
                        && !_accountNamesLoading && _selectedAccountName == null
                    ? Container(
                        width: double.maxFinite,
                        height: 50,
                        margin: EdgeInsetsDirectional.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                        ),
                        child: FlatButton(
                          onPressed: () async {
                            if (mounted) {
                              setState(() {
                                _accountNamesLoading = true;
                              });
                            }
                            List<PascalAccount> accounts = await walletState.findAccountsWithNameLike(this.addressController.text);
                            if (accounts == null) {
                              UIUtil.showSnackbar(AppLocalization.of(context).somethingWentWrongError, context);
                              setState(() {
                                _accountNamesLoading = false;
                              });
                            } else {
                              if (mounted) {
                                if (accounts.isEmpty) {
                                  UIUtil.showSnackbar(AppLocalization.of(context).noResultsFound, context);
                                }
                                setState(() {
                                  _accountNames = accounts;
                                  _accountNamesUnfocused = accounts;
                                  _accountNamesLoading = false;
                                });
                              }
                            }
                          },
                          highlightColor: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary15,
                          splashColor: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary30,
                          padding: EdgeInsets.all(0),
                          child: Text(AppLocalization.of(context).searchAccountNameButton,
                              style: AppStyles.buttonPrimary(context)),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> validateAndSend() async {
    bool hasError = false;
    Contact contact;
    Currency sendAmount = _localCurrencyMode ? Currency(_convertLocalCurrencyToCrypto()) :Currency(amountController.text);
    if (amountController.text.length == 0) {
      hasError = true;
      setState(() {
        amountError = AppLocalization.of(context).amountRequiredError;
      });
    } else if (accountState.accountBalance < sendAmount) {
      hasError = true;
      setState(() {
        amountError = AppLocalization.of(context).insufficientBalanceError;
      });
    } else if (sendAmount <= Currency("0")) {
      hasError = true;
      setState(() {
        amountError = AppLocalization.of(context).zeroAmountError;
      });
    }
    String contactNameToCheck = addressController.text;
    if (contactNameToCheck != null && _isDestinationFieldTypeContact) {
      contact = await sl.get<DBHelper>().getContactWithName(contactNameToCheck);
      if (contact == null) {
        hasError = true;
        setState(() {
          destinationError =
              AppLocalization.of(context).contactDoesntExistError;
        });
      }
    } else if (!_isDestinationFieldTypeContact && _selectedAccountName == null) {
      try {
        AccountNumber destination = AccountNumber(addressController.text);
        if (destination == accountState.account.account) {
          hasError = true;
          setState(() {
            destinationError =
                AppLocalization.of(context).cantSendToYourselfError;
          });
        }
      } catch (e) {
        hasError = true;
        setState(() {
          destinationError =
              AppLocalization.of(context).invalidDestinationError;
        });
      }
    }
    if (!hasError) {
      AppSheets.showBottomSheet(
          context: context,
          widget: SendingSheet(
              destination: _selectedAccountName != null && !_isDestinationFieldTypeContact ? _selectedAccountName.account.toString() : addressController.text,
              amount: sendAmount.toStringOpt(),
              localCurrencyAmount: _localCurrencyMode ? amountController.text : null,
              localCurrency: widget.localCurrency, 
              source: widget.account,
              fee: _hasFee ? walletState.MIN_FEE : walletState.NO_FEE,
              payload: _payload,
              fromOverview: widget.fromOverview,
              contact: contact,
              encryptPayload: _encryptedPayload,
              accountName: _selectedAccountName != null && !_isDestinationFieldTypeContact ? _selectedAccountName.name : null),
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
    Decimal conversion = Decimal.parse(walletState.localCurrencyPrice.toString());
    return NumberUtil.truncateDecimal(valueLocal / conversion).toString();
  }

  String _convertCryptoToLocalCurrency() {
    String convertedAmt =
        NumberUtil.sanitizeNumber(amountController.text, maxDecimalDigits: 2);
    if (convertedAmt.isEmpty) {
      return "";
    }
    Decimal valueCrypto = Decimal.parse(convertedAmt);
    Decimal conversion = Decimal.parse(walletState.localCurrencyPrice.toString());
    convertedAmt =
        NumberUtil.truncateDecimal(valueCrypto * conversion, digits: 2)
            .toString();
    convertedAmt =
        convertedAmt.replaceAll(".", _localCurrencyFormat.symbols.DECIMAL_SEP);
    convertedAmt = convertedAmt;
    return convertedAmt;
  }

  Widget _getContactsPopup() {
    return _contacts.length > 0 && _isDestinationFieldTypeContact
        ? Material(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            child: Container(
              constraints: BoxConstraints(maxHeight: 138),
              width: MediaQuery.of(context).size.width - 60,
              margin: EdgeInsetsDirectional.only(start: 30, end: 30, top: 4),
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
            ))
        : SizedBox();
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
          margin: EdgeInsetsDirectional.only(start: 16, end: 16),
          child: AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(
                text: " ",
                style: AppStyles.iconFontPrimarySmall(context),
              ),
              TextSpan(
                text: contact.name,
                style: AppStyles.contactsItemName(context),
              ),
            ]),
            maxLines: 1,
            stepGranularity: 0.1,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _getAccountNameList() {
    return !_isDestinationFieldTypeContact && !_accountNamesLoading && _accountNames.isNotEmpty
        ? Material(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            child: Container(
              constraints: BoxConstraints(maxHeight: 138),
              width: MediaQuery.of(context).size.width - 60,
              margin: EdgeInsetsDirectional.only(start: 30, end: 30, top: 4),
              decoration: BoxDecoration(
                  color: StateContainer.of(context).curTheme.backgroundPrimary,
                  boxShadow: [
                    StateContainer.of(context).curTheme.shadowAccountCard
                  ]),
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _accountNames.length,
                itemBuilder: (context, index) {
                  return _buildAccountNameItem(_accountNames[index]);
                },
              ),
            ))
        : _accountNamesLoading ?
        Material(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width - 60,
              margin: EdgeInsetsDirectional.only(start: 30, end: 30, top: 4),
              decoration: BoxDecoration(
                  color: StateContainer.of(context).curTheme.backgroundPrimary,
                  boxShadow: [
                    StateContainer.of(context).curTheme.shadowAccountCard
                  ]),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlareActor(
                    StateContainer.of(context).curTheme.animationSearch,
                    animation: "main",
                    fit: BoxFit.contain,
                    color: StateContainer.of(context).curTheme.primary,
                  ),
                ),
              )
            )          
        )
        : SizedBox();
  }

  Widget _buildAccountNameItem(PascalAccount account) {
    return Container(
      width: double.maxFinite,
      height: 46,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            _selectedAccountName = account;
            _accountNames = [];
            _accountNamesUnfocused = [];
          });
          addressFocusNode.unfocus();
        },
        child: Container(
          alignment: Alignment(-1, 0),
          margin: EdgeInsetsDirectional.only(start: 16, end: 16),
          child: AutoSizeText.rich(
            TextSpan(children: [
              TextSpan(
                text: account.name.toString(),
                style: AppStyles.contactsItemName(context),
              ),
              TextSpan(
                text: ' (${account.account.toString()})',
                style: AppStyles.privateKeyTextDarkFaded(context)
              )
            ]),
            maxLines: 1,
            stepGranularity: 0.1,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  /// When address text field is changed
  Future<void> _checkAndUpdateContacts() async {
    if (_isDestinationFieldTypeContact) {
      List<Contact> matches = await sl
          .get<DBHelper>()
          .getContactsWithNameLike(addressController.text);
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
    Contact c = name != null
        ? await sl.get<DBHelper>().getContactWithName(name)
        : contact;
    if (c != null && mounted) {
      addressFocusNode.unfocus();
      addressController.text = c.name;
      setState(() {
        _isDestinationFieldTypeContact = true;
        _isValidContactAndUnfocused = true;
        _payload = c.payload;
        _encryptedPayload = false;
      });
      EventTaxiImpl.singleton().fire(PayloadChangedEvent(payload: c.payload));
    }
  }
}
