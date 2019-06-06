import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ContactDetailSheet extends StatefulWidget {
  final String contactName;
  final String contactAddress;
  final Function onPressed;

  ContactDetailSheet({this.contactName, this.contactAddress, this.onPressed});
  _ContactDetailSheetState createState() => _ContactDetailSheetState();
}

class _ContactDetailSheetState extends State<ContactDetailSheet> {
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
                      // Trashcan Button
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
                              return null;
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(AppIcons.trashcan,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textLight,
                                size: 24)),
                      ),
                      // Header
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          "CONTACT",
                          style: AppStyles.header(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Search Button
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 10, end: 5),
                        height: 50,
                        width: 50,
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.textLight15,
                            splashColor:
                                StateContainer.of(context).curTheme.textLight30,
                            onPressed: () {
                              return null;
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(AppIcons.search,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textLight,
                                size: 24)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // "Contact Name" header
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 60, 30, 0),
                        child: AutoSizeText(
                          "Contact Name",
                          style: AppStyles.textFieldLabel(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Container for the contact name
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: widget.contactName[0],
                              style: AppStyles.settingsHeader(context),
                            ),
                            TextSpan(
                              text: widget.contactName.substring(1),
                              style: AppStyles.contactsItemName(context),
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
                        margin: EdgeInsetsDirectional.fromSTEB(30, 8, 30, 0),
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary,
                      ),
                      // "Address" header
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText(
                          "Address",
                          style: AppStyles.textFieldLabel(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Container for the contact address
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        child: AutoSizeText(
                          widget.contactAddress,
                          style: AppStyles.contactsItemAddress(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Container for the underline
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 8, 30, 0),
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary,
                      ),
                    ],
                  ),
                ),
                //"Add Contact" and "Close" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Send",
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
