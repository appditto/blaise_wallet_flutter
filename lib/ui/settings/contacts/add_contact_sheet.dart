import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/payload.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/common.dart';
import 'package:quiver/strings.dart';

class AddContactSheet extends StatefulWidget {
  final AccountNumber account;

  AddContactSheet({this.account});

  _AddContactSheetState createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  FocusNode nameFocusNode;
  FocusNode addressFocusNode;
  TextEditingController nameController;
  TextEditingController addressController;

  String payload;
  String nameError;
  String accountError;

  @override
  void initState() {
    super.initState();
    this.nameFocusNode = FocusNode();
    this.addressFocusNode = FocusNode();
    this.nameController = TextEditingController();
    this.addressController = TextEditingController();
    this.payload = "";
    if (widget.account == null) {
      this.addressFocusNode.addListener(() {
        if (!this.addressFocusNode.hasFocus) {
          try {
            AccountNumber numberFormatted =
                AccountNumber(this.addressController.text);
            this.addressController.text = numberFormatted.toString();
          } catch (e) {}
        }
      });
    } else {
      this.addressController.text = widget.account.toString();
    }
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
                      // Container for the address text field
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          toUppercase(AppLocalization.of(context)
                              .addContactSheetHeader
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
                              label: AppLocalization.of(context)
                                  .contactNameTextFieldHeader,
                              style: AppStyles.contactsItemName(context),
                              prefix: Text(
                                " ",
                                style: AppStyles.iconFontPrimarySmall(context),
                              ),
                              maxLines: 1,
                              focusNode: nameFocusNode,
                              controller: nameController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20)
                              ],
                              onChanged: (newText) {
                                if (isNotEmpty(nameError)) {
                                  setState(() {
                                    nameError = null;
                                  });
                                }
                              },
                              textInputAction: TextInputAction.newline,
                              onSubmitted: (text) {
                                addressFocusNode.requestFocus();
                              },
                            )),
                        ErrorContainer(
                          errorText: nameError ?? "",
                        ),
                        // Container for the address text field
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                          child: AppTextField(
                            label: AppLocalization.of(context)
                                .addressTextFieldHeader,
                            style: AppStyles.contactsItemAddress(context),
                            firstButton: widget.account == null
                                ? TextFieldButton(
                                    icon: AppIcons.paste,
                                    onPressed: () {
                                      UserDataUtil.getClipboardText(
                                              DataType.ACCOUNT)
                                          .then((account) {
                                        if (account != null) {
                                          addressController.text = account;
                                        }
                                      });
                                    },
                                  )
                                : null,
                            secondButton: widget.account == null
                                ? TextFieldButton(
                                    icon: AppIcons.scan,
                                    onPressed: () async {
                                      String text =
                                          await UserDataUtil.getQRData(
                                              DataType.ACCOUNT,
                                              StateContainer.of(context).curTheme.scannerTheme);
                                      if (text != null) {
                                        addressController.text = text;
                                      }
                                    })
                                : null,
                            maxLines: 1,
                            textCapitalization: TextCapitalization.characters,
                            controller: addressController,
                            focusNode: addressFocusNode,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp("[0-9-]")),
                              PascalAccountFormatter()
                            ],
                            onChanged: (newText) {
                              if (isNotEmpty(accountError)) {
                                setState(() {
                                  accountError = null;
                                });
                              }
                            },
                            readOnly: widget.account != null,
                          ),
                        ),
                        ErrorContainer(
                          errorText: accountError ?? "",
                        ),
                        // Container for the "Add Payload" button
                        Payload(
                          onPayloadChanged: (newPayload, encrypted) {
                            setState(() {
                              payload = newPayload;
                            });
                          },
                          allowEncryption: false,
                        )
                      ],
                    ),
                  ),
                ),
                //"Add Contact" and "Close" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: AppLocalization.of(context).addContactButton,
                      buttonTop: true,
                      onPressed: () async {
                        if (await validateForm()) {
                          Contact newContact = Contact(
                              account: widget.account == null
                                  ? AccountNumber(addressController.text)
                                  : widget.account,
                              name: nameController.text,
                              payload: payload);
                          await sl.get<DBHelper>().saveContact(newContact);
                          EventTaxiImpl.singleton()
                              .fire(ContactAddedEvent(contact: newContact));
                          UIUtil.showSnackbar(
                              AppLocalization.of(context)
                                  .addedToContactsParagraph
                                  .replaceAll("%1", newContact.name),
                              context);
                          EventTaxiImpl.singleton()
                              .fire(ContactModifiedEvent(contact: newContact));
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
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
    ));
  }

  Future<bool> validateForm() async {
    bool isValid = true;
    // Address Validations
    // Don't validate address if it came pre-filled in
    if (widget.account == null) {
      if (addressController.text.isEmpty) {
        isValid = false;
        setState(() {
          accountError = AppLocalization.of(context).invalidAccountError;
        });
      } else {
        try {
          AccountNumber acctNum = AccountNumber(addressController.text);
          addressFocusNode.unfocus();
          bool exists =
              await sl.get<DBHelper>().contactExistsWithAccount(acctNum);
          if (exists) {
            isValid = false;
            setState(() {
              accountError =
                  AppLocalization.of(context).contactAlreadyExistsError;
            });
          }
        } catch (e) {
          isValid = false;
          setState(() {
            accountError = AppLocalization.of(context).invalidAccountError;
          });
        }
      }
    }
    // Name Validations
    if (nameController.text.isEmpty) {
      isValid = false;
      setState(() {
        nameError = AppLocalization.of(context).nameRequiredError;
      });
    } else {
      bool nameExists =
          await sl.get<DBHelper>().contactExistsWithName(nameController.text);
      if (nameExists) {
        isValid = false;
        setState(() {
          nameError = AppLocalization.of(context).contactAlreadyExistsError;
        });
      }
    }
    return isValid;
  }
}
