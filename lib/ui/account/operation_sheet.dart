import 'dart:async';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/account/operation_details_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/contacts/add_contact_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';

class OperationSheet extends StatefulWidget {
  final String payload;
  final String ophash;
  final AccountNumber account;
  final bool isContact;
  final PascalOperation operation;
  OperationSheet(
      {@required this.ophash,
      @required this.account,
      @required this.operation,
      this.payload,
      this.isContact = false});

  _OperationSheetState createState() => _OperationSheetState();
}

class _OperationSheetState extends State<OperationSheet> {
  bool _addressCopied;
  Timer _addressCopiedTimer;
  String payload;
  bool payloadCopied;
  Timer payloadCopiedTimer;
  @override
  void initState() {
    super.initState();
    _addressCopied = false;
    payloadCopied = false;
    if (isNotEmpty(widget.payload)) {
      try {
        payload = PDUtil.bytesToUtf8String(PDUtil.hexToBytes(widget.payload));
      } catch (e) {
        // Try to decrypt this payload with private key
        sl.get<Vault>().getPrivateKey().then((pkey) {
          PrivateKey pk =
              PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(pkey));
          try {
            Uint8List result =
                EciesCrypt.decrypt(PDUtil.hexToBytes(widget.payload), pk);
            String asUtf8 = PDUtil.bytesToUtf8String(result);
            setState(() {
              payload = asUtf8;
            });
          } catch (e) {}
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: <Widget>[
              isNotEmpty(payload)
                  ? GestureDetector(
                      onTapDown: (details) {
                        _copyPayloadToClipboard();
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(top: 20),
                            child: AutoSizeText(
                              payloadCopied
                                  ? AppLocalization.of(context).copiedButton
                                  : AppLocalization.of(context)
                                      .payloadTextFieldHeader,
                              maxLines: 1,
                              stepGranularity: 1,
                              minFontSize: 8,
                              textAlign: TextAlign.start,
                              style: payloadCopied
                                  ? AppStyles.headerSmallBoldSuccess(context)
                                  : AppStyles.headerSmallBold(context),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 24, end: 24, top: 10, bottom: 4),
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1,
                                  color: payloadCopied
                                      ? StateContainer.of(context)
                                          .curTheme
                                          .success15
                                      : StateContainer.of(context)
                                          .curTheme
                                          .textDark15),
                              color: payloadCopied
                                  ? StateContainer.of(context)
                                      .curTheme
                                      .success10
                                  : StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                            ),
                            child: AutoSizeText(
                              payload,
                              maxLines: 6,
                              stepGranularity: 0.1,
                              minFontSize: 8,
                              textAlign: TextAlign.center,
                              style: payloadCopied
                                  ? AppStyles.paragraphMediumSuccess(context)
                                  : AppStyles.paragraphMedium(context),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              //"Copy Address", "Add to Contacts" and "Operation Details" buttons
              Row(
                children: <Widget>[
                  widget.operation.optype == OpType.TRANSACTION
                      ? AppButton(
                          type: _addressCopied
                              ? AppButtonType.Success
                              : AppButtonType.Primary,
                          text: _addressCopied
                              ? AppLocalization.of(context).copiedAddressButton
                              : AppLocalization.of(context).copyAddressButton,
                          buttonTop: true,
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.account.toString()));
                            setState(() {
                              _addressCopied = true;
                            });
                            if (_addressCopiedTimer != null) {
                              _addressCopiedTimer.cancel();
                            }
                            _addressCopiedTimer =
                                Timer(const Duration(milliseconds: 1500), () {
                              if (mounted) {
                                setState(() {
                                  _addressCopied = false;
                                });
                              }
                            });
                          },
                        )
                      : SizedBox(),
                ],
              ),
              widget.isContact || widget.operation.optype != OpType.TRANSACTION
                  ? SizedBox()
                  : Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.PrimaryOutline,
                          text: AppLocalization.of(context).addToContactsButton,
                          buttonMiddle: true,
                          onPressed: () {
                            Navigator.pop(context);
                            AppSheets.showBottomSheet(
                                context: context,
                                widget: AddContactSheet(
                                  account: widget.account,
                                ));
                          },
                        ),
                      ],
                    ),
              widget.operation.optype != OpType.TRANSACTION
                  ? SizedBox(height: 4)
                  : SizedBox(),
              // "Operation Details" button
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: AppLocalization.of(context).operationDetailsButton,
                    onPressed: () {
                      Navigator.of(context).pop();
                      AppSheets.showBottomSheet(
                          context: context,
                          widget: OperationDetailsSheet(
                              operation: widget.operation));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyPayloadToClipboard() {
    Clipboard.setData(ClipboardData(text: this.payload));
    setState(() {
      payloadCopied = true;
    });
    if (payloadCopiedTimer != null) {
      payloadCopiedTimer.cancel();
    }
    payloadCopiedTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          payloadCopied = false;
        });
      }
    });
  }
}
