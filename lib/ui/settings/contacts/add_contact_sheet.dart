import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class AddContactSheet extends StatefulWidget {
  _AddContactSheetState createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
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
                          "ADD CONTACT",
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
                  child: KeyboardAvoider(
                    duration: Duration(milliseconds: 0),
                    autoScroll: true,
                    focusPadding: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Container for the name text field
                        Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                            child: AppTextField(
                              label: 'Contact Name',
                              style: AppStyles.contactsItemName(context),
                              prefix: Text("@",
                                  style: AppStyles.settingsHeader(context)),
                              maxLines: 1,
                            )),
                        // Container for the address text field
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AppTextField(
                            label: 'Address',
                            style: AppStyles.contactsItemAddress(context),
                            firstButton: TextFieldButton(icon: AppIcons.paste),
                            secondButton: TextFieldButton(icon: AppIcons.scan),
                            maxLines: 1,
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ),
                        // Container for the "Add Payload" button
                        Row(
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
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
                                    borderRadius: BorderRadius.circular(100.0)),
                                child: AutoSizeText(
                                  "+ Add a Payload",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  stepGranularity: 0.1,
                                  style: AppStyles.buttonMiniBg(context),
                                ),
                                onPressed: () async {
                                  
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //"Add Contact" and "Close" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Add Contact",
                      buttonTop: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                        UIUtil.showSnackbar(
                          "@yekta added to contacts",
                          context,
                        );
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
    );
  }
}
