import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/network/http_client.dart';
import 'package:blaise_wallet_flutter/ui/overview/confirm_free_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';

class CountryCode {
  String isoCode;
  String displayName;

  CountryCode({@required this.isoCode, @required this.displayName});

  static List<CountryCode> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => CountryCode.fromJson(e)).toList();
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      isoCode: json['iso'],
      displayName: json['text']
    );
  }
}

class GetFreeAccountSheet extends StatefulWidget {
  _GetFreeAccountSheetState createState() => _GetFreeAccountSheetState();
}

class _GetFreeAccountSheetState extends State<GetFreeAccountSheet> {
  List<CountryCode> _countryCodes;
  CountryCode _selectedCountry;
  FixedExtentScrollController _cupertinoPickerController;
  TextEditingController _phoneNumberController;
  bool _showPhoneError;
  OverlayEntry _overlay;

  String requestId;

  Future<List<CountryCode>> readCountryCodeFromAssets() async {
    return CountryCode.fromJsonList(
      json.decode(await DefaultAssetBundle.of(context).loadString("assets/country_phone_map.json"))
    );
  }

  CountryCode getDefaultCountryCode(List<CountryCode> list) {
    String locale = Localizations.localeOf(context).countryCode.toUpperCase();
    return list.firstWhere((cc) => cc.isoCode == locale, orElse: () => list.firstWhere((cc) => cc.isoCode == 'US'));
  }

  List<Widget> _getCountryCodeForPicker() {
    List<Widget> ret = [];
    _countryCodes.forEach((value) {
      ret.add(Center(child: Text(
        value?.displayName,
        style: AppStyles.paragraphMedium(context),
        )));
    });
    return ret;
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    this._showPhoneError = false;
    _cupertinoPickerController = FixedExtentScrollController();
    this.requestId = null;
    readCountryCodeFromAssets().then((values) {
      setState(() {
        _countryCodes = values;
        _selectedCountry = getDefaultCountryCode(values);
        _cupertinoPickerController = FixedExtentScrollController(initialItem: _countryCodes.indexWhere((cc) => cc.isoCode == _selectedCountry.isoCode));
      });
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
                        // Sized Box
                        SizedBox(
                          height: 50,
                          width: 65,
                        ),
                        // Header
                        Container(
                          width: MediaQuery.of(context).size.width - 130,
                          alignment: Alignment(0, 0),
                          child: AutoSizeText(
                            toUppercase(AppLocalization.of(context).freeAccountSheetHeader, context),
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
                      children: <Widget>[
                        //Container for the paragraph
                        Container(
                          alignment: Alignment(-1, 0),
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AutoSizeText(
                            AppLocalization.of(context).enterPhoneNumberParagraph,
                            maxLines: 3,
                            stepGranularity: 0.1,
                            style: AppStyles.paragraph(context),
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
                                // "Country Code" header
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 0),
                                  child: AutoSizeText(
                                    AppLocalization.of(context).countryCodeTextFieldHeader,
                                    style: AppStyles.textFieldLabel(context),
                                    maxLines: 1,
                                    stepGranularity: 0.1,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: 30, end: 30),
                                  child: FlatButton(
                                    onPressed: () {
                                      if (_countryCodes == null) {
                                        return;
                                      }
                                      showCountryCodePicker();
                                    },
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                      children: <Widget>[
                                        // Container for country code
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 14, 0, 0),
                                          child: AutoSizeText.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                text: _selectedCountry?.displayName,
                                                style: AppStyles.paragraphMedium(
                                                    context),
                                              ),
                                            ]),
                                            maxLines: 1,
                                            stepGranularity: 0.1,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        // Container for the underline
                                        Container(
                                          width: double.maxFinite,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                          height: 1,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary,
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                                // Container for phone number field
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 40),
                                  child: AppTextField(
                                    label: AppLocalization.of(context).phoneNumberTextFieldHeader,
                                    style: AppStyles.paragraphMedium(context),
                                    controller: _phoneNumberController,
                                    maxLines: 1,
                                    inputType: TextInputType.phone,
                                    inputFormatters: [
                                      PhoneNumberFormatter(),
                                      WhitelistingTextInputFormatter(RegExp("[0-9-]"))
                                    ],
                                    onChanged: (text) {
                                      if (mounted && this._showPhoneError) {
                                        setState(() {
                                          this._showPhoneError = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                // Error Text
                                ErrorContainer(
                                  errorText: this._showPhoneError ? AppLocalization.of(context).invalidPhoneNumberParagraph : "",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //"Send Confirmation" and "Cancel" buttons
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.Primary,
                        text: AppLocalization.of(context).sendConfirmationButton,
                        buttonTop: true,
                        onPressed: () async {
                          if (this.requestId == null) {
                            showOverlay(context);
                            String result = await onSubmitted();
                            _overlay?.remove();
                            if (result != null) {
                              this.requestId = result;
                              AppSheets.showBottomSheet(
                                context: context,
                                widget: ConfirmFreeAccountSheet(
                                  requestId: result,
                                ),
                                noBlur: true
                              );
                            }
                          } else {
                              AppSheets.showBottomSheet(
                                context: context,
                                widget: ConfirmFreeAccountSheet(
                                  requestId: this.requestId
                                ),
                                noBlur: true
                              );                            
                          }
                        },
                      ),
                    ],
                  ),
                  // "Close" button
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.PrimaryOutline,
                        text: AppLocalization.of(context).cancelButton,
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
                      StateContainer.of(context).curTheme.animationGetAccount,
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

  Future<void> showCountryCodePicker() async {
    CountryCode countrySelection;
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height*0.4,
          child: Material(
            child: CupertinoPicker(
              backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
              useMagnifier: true,
              magnification: 1.5,
              scrollController: _cupertinoPickerController,
              onSelectedItemChanged: (index) {
                countrySelection = _countryCodes[index];
              },
              itemExtent: 30,
              children: _getCountryCodeForPicker()
            ),
          ),
        );
      },
    );
    if (countrySelection != null) {
      setState(() {
        _selectedCountry = countrySelection;
        _cupertinoPickerController = FixedExtentScrollController(initialItem: _countryCodes.indexWhere((cc) => cc.isoCode == _selectedCountry.isoCode));
      });
    }
  }

  // Submit request, return request ID if successful
  Future<String> onSubmitted() async {
    // Validate phone number
    if (_phoneNumberController.text.replaceAll(RegExp(r"[^0-9]"), "").length < 5) {
      if (mounted) {
        setState(() {
          _showPhoneError = true;
        });
      }
      return null;
    }
    // Make free pasa request
    String response = await HttpAPI.getFreePASA(
      _selectedCountry.isoCode,
      _phoneNumberController.text,
      PublicKeyCoder().encodeToBase58(walletState.publicKey)
    );
    // Error occured if null, otherwise move on to verification screen
    if (response == null) {
      UIUtil.showSnackbar(AppLocalization.of(context).somethingWentWrongError, context);
      return null;
    }
    return response;
  }
}