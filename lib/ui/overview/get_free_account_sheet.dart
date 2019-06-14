import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/overview/confirm_free_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

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
    readCountryCodeFromAssets().then((values) {
      setState(() {
        _countryCodes = values;
        _selectedCountry = getDefaultCountryCode(values);
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
                            "FREE ACCOUNT",
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
                            "Enter your phone number below.",
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
                                    "Country Code",
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
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: MediaQuery.of(context).size.height*0.4,
                                            child: Material(
                                              child: CupertinoPicker(
                                                backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
                                                useMagnifier: true,
                                                magnification: 1.5,
                                                onSelectedItemChanged: (index) {
                                                  setState(() {
                                                    _selectedCountry = _countryCodes[index];
                                                  });
                                                },
                                                itemExtent: 30,
                                                children: _getCountryCodeForPicker()
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
                                    label: 'Phone Number',
                                    style: AppStyles.paragraphMedium(context),
                                    maxLines: 1,
                                    inputType: TextInputType.phone,
                                  ),
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
                        text: "Send Confirmation",
                        buttonTop: true,
                        onPressed: () {
                          AppSheets.showBottomSheet(
                              context: context,
                              widget: ConfirmFreeAccountSheet());
                        },
                      ),
                    ],
                  ),
                  // "Close" button
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.PrimaryOutline,
                        text: "Cancel",
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
}