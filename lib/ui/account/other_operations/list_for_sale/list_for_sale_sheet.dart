import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/list_for_sale/listing_for_sale_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/fee_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/number_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';

class ListForSaleSheet extends StatefulWidget {
  final PascalAccount account;

  ListForSaleSheet({@required this.account}) : super();

  _ListForSaleSheetState createState() => _ListForSaleSheetState();
}

class _ListForSaleSheetState extends State<ListForSaleSheet> {
  FocusNode priceFocusNode;
  FocusNode receiverFocusNode;
  TextEditingController priceController;
  TextEditingController receiverController;

  String _priceErr;
  String _receiverErr;

  // Fee
  bool _hasFee;

  @override
  void initState() {
    super.initState();
    this.priceFocusNode = FocusNode();
    this.receiverFocusNode = FocusNode();
    this.priceController = TextEditingController();
    this.receiverController = TextEditingController();
    this._hasFee = walletState.shouldHaveFee();
    this.receiverFocusNode.addListener(() {
      if (!this.receiverFocusNode.hasFocus) {
        try {
          AccountNumber numberFormatted =
              AccountNumber(this.receiverController.text);
          this.receiverController.text = numberFormatted.toString();
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
                            highlightColor:
                                StateContainer.of(context).curTheme.textLight15,
                            splashColor:
                                StateContainer.of(context).curTheme.textLight30,
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
                          toUppercase(AppLocalization.of(context)
                              .listForSaleSheetHeader
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
                      // Paragraph
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 20),
                        child: AutoSizeText(
                          AppLocalization.of(context).listForSaleParagraph,
                          style: AppStyles.paragraph(context),
                          stepGranularity: 0.1,
                          maxLines: 3,
                          minFontSize: 8,
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
                              // Container for price field
                              Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 0),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .priceTextFieldHeader,
                                  style: AppStyles.paragraphPrimary(context),
                                  maxLines: 1,
                                  inputType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  prefix: Icon(
                                    AppIcons.pascalsymbol,
                                    size: 15,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                  ),
                                  focusNode: priceFocusNode,
                                  controller: priceController,
                                  onChanged: (text) {
                                    if (_priceErr != null) {
                                      setState(() {
                                        _priceErr = null;
                                      });
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(13),
                                    CurrencyFormatter(
                                        maxDecimalDigits:
                                            NumberUtil.maxDecimalDigits)
                                  ],
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (text) {
                                    receiverFocusNode.requestFocus();
                                  },
                                ),
                              ),
                              _hasFee
                                  ? FeeContainer(
                                      feeText:
                                          walletState.MIN_FEE.toStringOpt())
                                  : SizedBox(),
                              ErrorContainer(errorText: _priceErr ?? ""),
                              // Container for receving account field
                              Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 30, 0),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .receivingAccountTextFieldHeader,
                                  style: AppStyles.privateKeyTextDark(context),
                                  maxLines: 1,
                                  firstButton: TextFieldButton(
                                    icon: AppIcons.paste,
                                    onPressed: () async {
                                      String text =
                                          await UserDataUtil.getClipboardText(
                                              DataType.ACCOUNT);
                                      if (text != null) {
                                        receiverFocusNode.unfocus();
                                        receiverController.text = text;
                                      }
                                    },
                                  ),
                                  secondButton: TextFieldButton(
                                    icon: AppIcons.scan,
                                    onPressed: () async {
                                      String text =
                                          await UserDataUtil.getQRData(
                                              DataType.ACCOUNT,
                                              StateContainer.of(context).curTheme.scannerTheme);
                                      if (text != null) {
                                        receiverFocusNode.unfocus();
                                        receiverController.text = text;
                                      }
                                    },
                                  ),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter(
                                        RegExp("[0-9-]")),
                                    PascalAccountFormatter()
                                  ],
                                  onChanged: (text) {
                                    if (_receiverErr != null) {
                                      setState(() {
                                        _receiverErr = null;
                                      });
                                    }
                                  },
                                  focusNode: receiverFocusNode,
                                  controller: receiverController,
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(bottom: 40),
                                child: ErrorContainer(
                                    errorText: _receiverErr ?? ""),
                              ),
                              // Bottom Margin
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // "List for Sale" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: AppLocalization.of(context).listForSaleButton,
                      onPressed: () {
                        if (validateFormData()) {
                          AppSheets.showBottomSheet(
                              context: context,
                              widget: ListingForSaleSheet(
                                  account: widget.account,
                                  price: Currency(priceController.text),
                                  receiver:
                                      AccountNumber(receiverController.text),
                                  fee: _hasFee
                                      ? walletState.MIN_FEE
                                      : walletState.NO_FEE),
                              noBlur: true);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  bool validateFormData() {
    bool isValid = true;
    // Validate receiver
    if (receiverController.text.trim().length == 0) {
      isValid = false;
      setState(() {
        _receiverErr = AppLocalization.of(context).invalidReceivingAccountError;
      });
    } else {
      try {
        AccountNumber(receiverController.text);
      } catch (e) {
        isValid = false;
        setState(() {
          _receiverErr =
              AppLocalization.of(context).invalidReceivingAccountError;
        });
      }
    }
    // Validate price
    if (priceController.text.trim().length == 0) {
      isValid = false;
      setState(() {
        _priceErr = AppLocalization.of(context).priceRequiredError;
      });
    } else {
      Currency price = Currency(priceController.text);
      if (price == Currency('0')) {
        isValid = false;
        setState(() {
          _priceErr = AppLocalization.of(context).zeroPriceError;
        });
      }
    }
    return isValid;
  }
}
