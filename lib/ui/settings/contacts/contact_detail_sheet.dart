import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/account/send/send_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';

class ContactDetailSheet extends StatefulWidget {
  final Contact contact;
  final Account account;

  ContactDetailSheet({this.contact, this.account});
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
                            onPressed: () async {
                              bool deleted = await sl.get<DBHelper>().deleteContact(widget.contact);
                              if (deleted) {
                                EventTaxiImpl.singleton().fire(ContactRemovedEvent(contact: widget.contact));
                                EventTaxiImpl.singleton().fire(ContactModifiedEvent(contact: widget.contact));
                                UIUtil.showSnackbar("Removed ${widget.contact.name} from contacts", context);
                                Navigator.of(context).pop();
                              } else {
                                UIUtil.showSnackbar("Failed to remove ${widget.contact.name} from contacts", context);
                              }
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
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
                        child: AutoSizeText(
                          "Contact Name",
                          style: AppStyles.textFieldLabel(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Container for the Contact Name
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark15),
                          color: StateContainer.of(context).curTheme.textDark10,
                        ),
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: widget.contact.name[0],
                              style: AppStyles.contactsItemNamePrimary(context),
                            ),
                            TextSpan(
                              text: widget.contact.name.substring(1),
                              style: AppStyles.contactsItemName(context),
                            ),
                          ]),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // "Address" header
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText(
                          "Address",
                          style: AppStyles.textFieldLabel(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // Container for the address
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark15),
                          color: StateContainer.of(context).curTheme.textDark10,
                        ),
                        child: AutoSizeText(
                          widget.contact.account.toString(),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          minFontSize: 8,
                          textAlign: TextAlign.center,
                          style: AppStyles.privateKeyTextDark(context),
                        ),
                      ),
                      // "Payload" header
                      isNotEmpty(widget.contact.payload)
                          ? Container(
                              width: double.maxFinite,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                              child: AutoSizeText(
                                "Payload",
                                style: AppStyles.textFieldLabel(context),
                                maxLines: 1,
                                stepGranularity: 0.1,
                                textAlign: TextAlign.start,
                              ),
                            )
                          : SizedBox(),
                      // Container for the payload text
                      isNotEmpty(widget.contact.payload)
                          ? Container(
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 1,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .textDark15),
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textDark10,
                              ),
                              child: AutoSizeText(
                                widget.contact.payload,
                                maxLines: 1,
                                stepGranularity: 0.1,
                                minFontSize: 8,
                                textAlign: TextAlign.center,
                                style: AppStyles.paragraph(context),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                //"Add Contact" and "Close" buttons
                _showSendButton() ? Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Send",
                      buttonTop: true,
                      onPressed: () {
                        if (widget.account != null) {
                          AppSheets.showBottomSheet(
                            context: context,
                            widget: SendSheet(
                              account: widget.account.account,
                              contact: widget.contact
                            ),
                          );
                        } else {
                          showAppDialog(
                              context: context,
                              builder: (_) => DialogOverlay(
                                  title: 'Choose Account to Send From',
                                  optionsList: _getAccountsList()));
                        }
                      },
                    ),
                  ],
                ) : SizedBox(),
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

  bool _showSendButton() {
    return (
      (widget.account != null && widget.account.accountBalance > Currency('0')) ||
      (widget.account == null && !walletState.walletLoading && walletState.totalWalletBalance > Currency('0') && walletState.getNonzeroBalanceAccounts().length > 0)
    );
  }

  List<DialogListItem> _getAccountsList() {
    /// Get a list of accounts we can send from
    List<DialogListItem> ret = [];
    walletState.getNonzeroBalanceAccounts().forEach((acct) {
      ret.add(DialogListItem(
        option: "${acct.account.toString()} (${acct.balance.toStringOpt()} PASC)",
        action: () {
          Navigator.of(context).pop();
          AppSheets.showBottomSheet(
            context: context,
            widget: SendSheet(
              account: acct,
              contact: widget.contact,
              fromOverview: true,
            ),
          );
        }
      ));
    });
    return ret;
  }
}
