import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RequestSheet extends StatefulWidget {
  final String address;
  RequestSheet({this.address});
  _RequestSheetState createState() => _RequestSheetState();
}

class _RequestSheetState extends State<RequestSheet> {
  FocusNode amountFocusNode;
  TextEditingController amountController;
  FocusNode payloadFocusNode;
  TextEditingController payloadController;
  String amount = '';
  String payload = '';

  @override
  void initState() {
    super.initState();
    this.amountFocusNode = FocusNode();
    this.payloadFocusNode = FocusNode();
    this.amountController = TextEditingController();
    this.payloadController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                        // SizedBox
                        SizedBox(width: 65, height: 50),
                        // Header
                        Container(
                          width: MediaQuery.of(context).size.width - 130,
                          alignment: Alignment(0, 0),
                          child: AutoSizeText(
                            toUppercase(AppLocalization.of(context)
                                .requestSheetHeader
                                ,context),
                            style: AppStyles.header(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // SizedBox
                        SizedBox(width: 65, height: 50),
                      ],
                    ),
                  ),
                  Expanded(
                    child: KeyboardAvoider(
                      duration: Duration(milliseconds: 0),
                      autoScroll: true,
                      focusPadding: 40,
                      child: Column(
                        children: <Widget>[
                          // QR Code
                          Container(
                            margin: EdgeInsetsDirectional.only(top: 30),
                            child: Stack(
                              alignment: Alignment(0, 0),
                              children: <Widget>[
                                // Gradient
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: StateContainer.of(context)
                                        .curTheme
                                        .gradientPrimary,
                                  ),
                                ),
                                // White overlay
                                Container(
                                  width: 172,
                                  height: 172,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                ),
                                // QR Code
                                QrImage(
                                  data: "Address=" +
                                      widget.address +
                                      " / Amount=" +
                                      amount.toString() +
                                      " / Payload=" +
                                      payload,
                                  size: 180.0,
                                  version: 6,
                                  errorCorrectionLevel: QrErrorCorrectLevel.Q,
                                  gapless: false,
                                ),
                                // Logo background
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                ),
                                // Logo
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: StateContainer.of(context)
                                        .curTheme
                                        .gradientPrimary,
                                  ),
                                  child: Icon(AppIcons.pascalsymbol,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .backgroundPrimary,
                                      size: 30),
                                ),
                              ],
                            ),
                          ),
                          // Container for the amount text field
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                            child: AppTextField(
                              onChanged: (String newText) {
                                setState(() {
                                  amount = newText;
                                });
                              },
                              focusNode: amountFocusNode,
                              controller: amountController,
                              label: AppLocalization.of(context)
                                  .amountTextFieldHeader,
                              style: AppStyles.paragraphPrimary(context),
                              maxLines: 1,
                              inputType: TextInputType.numberWithOptions(
                                  decimal: true),
                              prefix: Icon(
                                AppIcons.pascalsymbol,
                                size: 15,
                                color:
                                    StateContainer.of(context).curTheme.primary,
                              ),
                              firstButton: TextFieldButton(icon: AppIcons.max),
                              secondButton: TextFieldButton(
                                  icon: AppIcons.currencyswitch),
                              textInputAction: TextInputAction.next,
                              onSubmitted: (text) {
                                payloadFocusNode.requestFocus();
                              },
                            ),
                          ),
                          // Container for the payload text field
                          Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 30, 30, 40),
                            child: AppTextField(
                              onChanged: (String newText) {
                                setState(() {
                                  payload = newText;
                                });
                              },
                              focusNode: payloadFocusNode,
                              controller: payloadController,
                              label: AppLocalization.of(context)
                                  .payloadTextFieldHeader,
                              style: AppStyles.paragraphMedium(context),
                              maxLines: 1,
                              firstButton:
                                  TextFieldButton(icon: AppIcons.paste),
                              secondButton:
                                  TextFieldButton(icon: AppIcons.scan),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // "Close" button
                  Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.PrimaryOutline,
                        text: AppLocalization.of(context).closeButton,
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
}
