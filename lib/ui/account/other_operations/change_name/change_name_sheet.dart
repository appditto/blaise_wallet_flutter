import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/change_name/changing_name_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/fee_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';

class ChangeNameSheet extends StatefulWidget {
  final PascalAccount account;

  ChangeNameSheet({@required this.account});

  _ChangeNameSheetState createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<ChangeNameSheet> {
  FocusNode _nameFocus;
  TextEditingController _nameController;
  String _nameError;

  // Fee
  bool _hasFee;

  @override
  void initState() {
    super.initState();
    this._nameFocus = FocusNode();
    this._nameController = TextEditingController();
    this._hasFee = walletState.shouldHaveFee();
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
                              .changeNameSheetHeader
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
                        margin: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 20),
                        child: AutoSizeText(
                          AppLocalization.of(context).changeNameParagraph,
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
                              // Container for the name text field
                              Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 0),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .newAccountNameTextFieldHeader,
                                  style: AppStyles.paragraphMedium(context),
                                  maxLines: 1,
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter(RegExp(
                                        r'[0123456789abcdefghijklmnopqrstuvwxyz!@#$%^&*()\-+{}[\]_:"|<>,\.\?\/~]')),
                                    PascalNameFormatter()
                                  ],
                                  onChanged: (nt) {
                                    if (_nameError != null) {
                                      setState(() {
                                        _nameError = null;
                                      });
                                    }
                                  },
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
                                errorText: _nameError == null ? "" : _nameError,
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
                // "Change Name" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: AppLocalization.of(context).changeNameButton,
                      onPressed: () {
                        validateAndChangeName();
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

  void validateAndChangeName() {
    try {
      if (_nameController.text.isNotEmpty && _nameController.text.length < 3) {
        setState(() {
          _nameError = AppLocalization.of(context).threeCharacterNameError;
        });
        return;
      }
      AccountName accountName = AccountName(_nameController.text);
      AppSheets.showBottomSheet(
          context: context,
          widget: ChangingNameSheet(
              account: widget.account,
              newName: accountName,
              fee: _hasFee ? walletState.MIN_FEE : walletState.NO_FEE),
          noBlur: true);
    } catch (e) {
      setState(() {
        _nameError = AppLocalization.of(context).invalidAccountNameError;
      });
    }
  }
}
