import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/change_name/changing_name_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/send/sending_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SendSheet extends StatefulWidget {
  _SendSheetState createState() => _SendSheetState();
}

class _SendSheetState extends State<SendSheet> {
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
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Account name
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                45),
                                    child: AutoSizeText(
                                      "yekta",
                                      style:
                                          AppStyles.settingsItemHeader(context),
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
                                      "578706-79",
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
                                              text: "9,104",
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
                                    firstButton:
                                        TextFieldButton(icon: AppIcons.paste),
                                    secondButton:
                                        TextFieldButton(icon: AppIcons.scan),
                                  ),
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
                                    prefix: Icon(
                                      AppIcons.pascalsymbol,
                                      size: 15,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                    ),
                                    firstButton:
                                        TextFieldButton(icon: AppIcons.max),
                                    secondButton: TextFieldButton(
                                        icon: AppIcons.currencyswitch),
                                  ),
                                ),
                                // Container for the "Add Payload" button
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
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          30, 30, 30, 40),
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100.0)),
                                        child: AutoSizeText(
                                          "+ Add a Payload",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          stepGranularity: 0.1,
                                          style:
                                              AppStyles.buttonMiniBg(context),
                                        ),
                                        onPressed: () async {
                                          return null;
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
                          AppSheets.showBottomSheet(
                              context: context,
                              widget: SendingSheet(),
                              noBlur: true);
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
}
