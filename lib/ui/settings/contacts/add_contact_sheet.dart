import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
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
                          label: 'Name',
                          style: AppStyles.contactsItemName(context),
                          prefix: Text("@", style: AppStyles.settingsHeader(context)),
                          maxLines: 1,
                        )
                      ),
                      // Container for the address text field
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(-1, 0),
                              child: AutoSizeText(
                                'Address',
                                style: AppStyles.textFieldLabel(context),
                              ),
                            ),
                            Container(
                              child: Theme(
                                data: ThemeData(
                                  primaryColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  hintColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .primary15,
                                  textSelectionColor: StateContainer.of(context)
                                      .curTheme
                                      .primary30,
                                ),
                                child: TextField(
                                  style: AppStyles.contactsItemAddress(context),
                                  cursorColor: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  textInputAction: TextInputAction.done,
                                  maxLines: null,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                      width: 88,
                                      height: 38,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            width: 38,
                                            height: 38,
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .gradientPrimary,
                                              ),
                                              child: FlatButton(
                                                padding: EdgeInsets.all(0),
                                                shape: CircleBorder(),
                                                onPressed: () {
                                                  return null;
                                                },
                                                splashColor:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .backgroundPrimary30,
                                                highlightColor:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .backgroundPrimary15,
                                                child: Icon(
                                                  AppIcons.scan,
                                                  size: 22,
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .backgroundPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsetsDirectional.only(
                                                start: 12),
                                            width: 38,
                                            height: 38,
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .gradientPrimary,
                                              ),
                                              child: FlatButton(
                                                padding: EdgeInsets.all(0),
                                                shape: CircleBorder(),
                                                onPressed: () {
                                                  return null;
                                                },
                                                splashColor:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .backgroundPrimary30,
                                                highlightColor:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .backgroundPrimary15,
                                                child: Icon(
                                                  AppIcons.paste,
                                                  size: 22,
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .backgroundPrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
