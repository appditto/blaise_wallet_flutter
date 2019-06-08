import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/private_sale/creating_private_sale_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/ensure_visible.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:flutter/material.dart';

class CreatePrivateSaleSheet extends StatefulWidget {
  _CreatePrivateSaleSheetState createState() => _CreatePrivateSaleSheetState();
}

class _CreatePrivateSaleSheetState extends State<CreatePrivateSaleSheet> {
  FocusNode _focusNodePrice = FocusNode();
  FocusNode _focusNodeReceivingAccount = FocusNode();
  FocusNode _focusNodePublicKey = FocusNode();
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
                          "PRIVATE SALE",
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
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                        child: AutoSizeText(
                          "Enter a price, a receiving account, and a public key below to create a private sale for this account.",
                          style: AppStyles.paragraph(context),
                          stepGranularity: 0.1,
                          maxLines: 3,
                          minFontSize: 8,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Container for price field
                              EnsureVisibleWhenFocused(
                                focusNode: _focusNodePrice,
                                child: Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 0, 30, 0),
                                  child: AppTextField(
                                    label: 'Price',
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
                                    focusNode: _focusNodePrice,
                                  ),
                                ),
                              ),
                              // Container for receving account field
                              EnsureVisibleWhenFocused(
                                focusNode: _focusNodeReceivingAccount,
                                child: Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 0),
                                  child: AppTextField(
                                    label: 'Receiving Account',
                                    style:
                                        AppStyles.privateKeyTextDark(context),
                                    maxLines: 1,
                                    firstButton:
                                        TextFieldButton(icon: AppIcons.paste),
                                    secondButton:
                                        TextFieldButton(icon: AppIcons.scan),
                                    focusNode: _focusNodeReceivingAccount,
                                  ),
                                ),
                              ),
                              // Container for public key field
                              EnsureVisibleWhenFocused(
                                focusNode: _focusNodePublicKey,
                                child: Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      30, 30, 30, 0),
                                  child: AppTextField(
                                    label: 'Public Key',
                                    style:
                                        AppStyles.privateKeyTextDark(context),
                                    maxLines: 1,
                                    firstButton:
                                        TextFieldButton(icon: AppIcons.paste),
                                    secondButton:
                                        TextFieldButton(icon: AppIcons.scan),
                                    focusNode: _focusNodePublicKey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // "Create Private Sale" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Create Private Sale",
                      onPressed: () {
                        AppSheets.showBottomSheet(
                            context: context,
                            widget: CreatingPrivateSaleSheet());
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
}
