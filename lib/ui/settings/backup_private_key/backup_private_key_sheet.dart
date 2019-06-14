import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/settings/backup_private_key/encrypt_private_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/backup_private_key/unencrypted_private_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/authentication.dart';
import 'package:flutter/material.dart';

class BackupPrivateKeySheet extends StatefulWidget {
  _BackupPrivateKeySheetState createState() => _BackupPrivateKeySheetState();
}

class _BackupPrivateKeySheetState extends State<BackupPrivateKeySheet> {
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
                          "PRIVATE KEY",
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
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "You have 2 options for backing up your private key:\n\n",
                                style: AppStyles.paragraph(context),
                              ),
                              TextSpan(
                                text:
                                    "1- Encrypted, which means it is protected by a password.\n\n",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text:
                                    "2- Unencrypted, which means it is raw and not protected by a password.\n\n",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text:
                                    "We recommend storing the unencrypted version offline, by writing it on a piece of paper. And storing the encrypted version on a password manager for convenience.",
                                style: AppStyles.paragraph(context),
                              ),
                            ],
                          ),
                          stepGranularity: 0.5,
                          maxLines: 14,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                //"Encrypted Key" and "Unencrypted Key" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: "Encrypted Key",
                      buttonTop: true,
                      onPressed: () {
                        AuthUtil().authenticate("Authenticate to backup private key").then((authenticated) {
                          if (authenticated) {
                            Navigator.pop(context);
                            AppSheets.showBottomSheet(
                                context: context,
                                widget: EncryptPrivateKeySheet());
                          }
                        });
                      },
                    ),
                  ],
                ),
                // "Close" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: "Unencrypted Key",
                      onPressed: () {
                        AuthUtil().authenticate("Authenticate to backup private key").then((authenticated) {
                          if (authenticated) {
                            Navigator.pop(context);
                            AppSheets.showBottomSheet(
                                context: context,
                                widget: UnencryptedPrivateKeySheet());
                          }
                        });
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
