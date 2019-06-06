import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

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
                  child: Column(
                    children: <Widget>[
                      // Container for the name text field
                      Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 60, 30, 0),
                          child: AppTextField(
                            label: 'Contact Name',
                            style: AppStyles.contactsItemName(context),
                            prefix: Text("@",
                                style: AppStyles.settingsHeader(context)),
                            maxLines: 1,
                          )),
                      // Container for the address text field
                      Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 60, 30, 0),
                          child: AppTextField(
                            label: 'Address',
                            style: AppStyles.contactsItemAddress(context),
                            firstButton: TextFieldButton(icon: AppIcons.scan),
                            secondButton: TextFieldButton(icon: AppIcons.paste),
                            maxLines: 1,
                          )),
                    ],
                  ),
                ),
                //"Add Contact" and "Close" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Add Contact",
                      buttonTop: true,
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
    );
  }
}
