import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/model/available_themes.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:share/share.dart';
import 'package:blaise_wallet_flutter/themes.dart';
import 'package:blaise_wallet_flutter/ui/settings/backup_private_key/backup_private_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/change_daemon_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/public_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/settings_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DialogListItem> currencyList = [
    DialogListItem(option: "\$ US Dollar"),
    DialogListItem(option: "\$ Argentine Peso"),
    DialogListItem(option: "\$ Australian Dollar"),
    DialogListItem(option: "R\$ Brazilian Real"),
    DialogListItem(option: "\$ Canadian Dollar"),
    DialogListItem(option: "CHF Swiss Franc"),
    DialogListItem(option: "\$ Chilean Peso"),
    DialogListItem(option: "¥ Chinese Yuan"),
    DialogListItem(option: "Kč Czech Koruna"),
    DialogListItem(option: "kr. Danish Krone"),
    DialogListItem(option: "€ Euro"),
    DialogListItem(option: "£ Great Britain Pound"),
    DialogListItem(option: "HK\$ Hong Kong Dollar"),
    DialogListItem(option: "Ft Hungarian Forint"),
    DialogListItem(option: "Rp Indonesian Rupiah"),
    DialogListItem(option: "₪ Israeli Shekel"),
    DialogListItem(option: "₹ Indian Rupee"),
    DialogListItem(option: "¥ Japanese Yen")
  ];
  List<DialogListItem> languageList = [
    DialogListItem(option: "System Default"),
    DialogListItem(option: "English (en)"),
    DialogListItem(option: "简体字 (zh-Hans)"),
    DialogListItem(option: "繁體字 (zh-Hant)"),
    DialogListItem(option: "Français (fr)"),
    DialogListItem(option: "Deutsch (de)"),
    DialogListItem(option: "Español (es)")
  ];

  List<DialogListItem> getThemeList() {
    List<DialogListItem> ret = [];
    ThemeOptions.values.forEach((ThemeOptions value) {
      ThemeSetting theme = ThemeSetting(value);
      ret.add(DialogListItem(
          option: theme.getDisplayName(context),
          action: () {
            StateContainer.of(context).updateTheme(ThemeSetting(value));
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: <Widget>[
            // Container for the gradient background
            Container(
              height: 104 +
                  (MediaQuery.of(context).padding.top) +
                  (36 - (MediaQuery.of(context).padding.top) / 2),
              decoration: BoxDecoration(
                gradient: StateContainer.of(context).curTheme.gradientPrimary,
              ),
            ),
            // Column for the rest
            Column(
              children: <Widget>[
                // Container for the header and button
                Container(
                  margin: EdgeInsetsDirectional.only(
                    top: (MediaQuery.of(context).padding.top) +
                        (36 - (MediaQuery.of(context).padding.top) / 2),
                    bottom: 8,
                  ),
                  // Row for back button and the header
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Back Button
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 2),
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
                            child: Icon(AppIcons.back,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textLight,
                                size: 24)),
                      ),
                      // The header
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        margin: EdgeInsetsDirectional.fromSTEB(4, 0, 24, 0),
                        child: AutoSizeText(
                          "Settings",
                          style: AppStyles.header(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded list
                Expanded(
                  // Container for the list
                  child: Container(
                    margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color:
                          StateContainer.of(context).curTheme.backgroundPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      boxShadow: [
                        StateContainer.of(context).curTheme.shadowSettingsList,
                      ],
                    ),
                    // Settings List
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: ListView(
                        padding: EdgeInsetsDirectional.only(
                            bottom: MediaQuery.of(context).padding.bottom + 24),
                        children: <Widget>[
                          // Preferences text
                          Container(
                            alignment: Alignment(-1, 0),
                            margin: EdgeInsetsDirectional.only(
                                start: 24, end: 24, top: 18, bottom: 8),
                            child: AutoSizeText(
                              "Preferences",
                              style: AppStyles.settingsHeader(context),
                              maxLines: 1,
                              stepGranularity: 0.1,
                            ),
                          ),
                          // Divider
                          Container(
                            width: double.maxFinite,
                            height: 1,
                            color:
                                StateContainer.of(context).curTheme.textDark10,
                          ),
                          // List Items
                          SettingsListItem(
                            header: "Currency",
                            subheader: "\$ US Dollar",
                            icon: AppIcons.currency,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: 'Currency',
                                      optionsList: currencyList));
                            },
                          ),
                          SettingsListItem(
                            header: "Language",
                            subheader: "System Default",
                            icon: AppIcons.language,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: 'Language',
                                      optionsList: languageList));
                            },
                          ),
                          SettingsListItem(
                            header: "Theme",
                            subheader: StateContainer.of(context)
                                        .curTheme
                                        .toString() ==
                                    BlaiseLightTheme().toString()
                                ? "Light"
                                : "Dark",
                            icon: AppIcons.theme,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: 'Theme',
                                      optionsList: getThemeList()));
                            },
                          ),
                          SettingsListItem(
                            header: "Security",
                            icon: AppIcons.security,
                            onPressed: () {
                              Navigator.pushNamed(context, '/security');
                            },
                          ),
                          SettingsListItem(
                            header: "Daemon",
                            subheader: "Default",
                            icon: AppIcons.changedaemon,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context,
                                  widget: ChangeDaemonSheet());
                            },
                          ),
                          // Manage text
                          Container(
                            alignment: Alignment(-1, 0),
                            margin: EdgeInsetsDirectional.only(
                                start: 24, end: 24, top: 18, bottom: 8),
                            child: AutoSizeText(
                              "Manage",
                              style: AppStyles.settingsHeader(context),
                              maxLines: 1,
                              stepGranularity: 0.1,
                            ),
                          ),
                          // Divider
                          Container(
                            width: double.maxFinite,
                            height: 1,
                            color:
                                StateContainer.of(context).curTheme.textDark10,
                          ),
                          SettingsListItem(
                            header: "Contacts",
                            icon: AppIcons.contacts,
                            onPressed: () {
                              Navigator.pushNamed(context, '/contacts');
                            },
                          ),
                          SettingsListItem(
                            header: "Backup Private Key",
                            icon: AppIcons.backupprivatekey,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context,
                                  widget: BackupPrivateKeySheet());
                            },
                          ),
                          SettingsListItem(
                            header: "View Public Key",
                            icon: Icons.public,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context, widget: PublicKeySheet());
                            },
                          ),
                          SettingsListItem(
                              header: "Share Blaise",
                              icon: AppIcons.share,
                              onPressed: () {
                                Share.share(
                                    "Check out Blaise - Pascal Wallet for iOS and Android");
                              }),
                          SettingsListItem(
                            header: "Logout",
                            icon: AppIcons.logout,
                            onPressed: () {
                              logoutPressed();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void logoutPressed() {
    showAppDialog(
        context: context,
        builder: (_) => DialogOverlay(
              title: 'WARNING',
              warningStyle: true,
              confirmButtonText: "DELETE PRIVATE KEY\nAND LOGOUT",
              body: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Are you sure that you’ve backed up your private key? ",
                    style: AppStyles.paragraph(context),
                  ),
                  TextSpan(
                    text:
                        "As long as you’ve backed up your private key, you have nothing to worry about.",
                    style: AppStyles.paragraphDanger(context),
                  ),
                ],
              ),
              onConfirm: () {
                Navigator.of(context).pop();
                showAppDialog(
                    context: context,
                    builder: (_) => DialogOverlay(
                        title: 'ARE YOU SURE?',
                        warningStyle: true,
                        confirmButtonText: "YES, I'M SURE",
                        body: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Logging out will remove your private key and all Blaise related data from this device. ",
                              style: AppStyles.paragraphDanger(context),
                            ),
                            TextSpan(
                              text:
                                  "If your private key is not backed up, you will never be able to access your funds again. If your private key is backed up, you have nothing to worry about.",
                              style: AppStyles.paragraph(context),
                            ),
                          ],
                        ),
                        onConfirm: () {
                          // Handle logging out
                          walletState.reset();
                          sl.get<Vault>().deleteAll().then((_) {
                            sl.get<SharedPrefsUtil>().deleteAll().then((_) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            });
                          });
                        }));
              },
            ));
  }
}
