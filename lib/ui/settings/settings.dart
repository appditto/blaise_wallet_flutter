import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/daemon_changed_event.dart';
import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/available_themes.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/model/available_languages.dart';
import 'package:blaise_wallet_flutter/model/notification_enabled.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/widgets/webview.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:package_info/package_info.dart';
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
  final Account account;

  SettingsPage({this.account}) : super();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

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

  List<DialogListItem> getCurrencyList() {
    List<DialogListItem> ret = [];
    AvailableCurrencyEnum.values.forEach((AvailableCurrencyEnum value) {
      AvailableCurrency currency = AvailableCurrency(value);
      ret.add(DialogListItem(
          option: currency.getDisplayName(context),
          action: () {
            sl.get<SharedPrefsUtil>().setCurrency(currency).then((result) {
              if (StateContainer.of(context).curCurrency.currency !=
                  currency.currency) {
                setState(() {
                  StateContainer.of(context).curCurrency = currency;
                });
                walletState.requestUpdate();
              }
            });
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  List<DialogListItem> getNotificationList() {
    List<DialogListItem> ret = [];
    NotificationOptions.values.forEach((NotificationOptions value) {
      NotificationSetting setting = NotificationSetting(value);
      ret.add(DialogListItem(
          option: setting.getDisplayName(context),
          action: () {
            if (setting != _curNotificiationSetting) {
              sl
                  .get<SharedPrefsUtil>()
                  .setNotificationsOn(setting.setting == NotificationOptions.ON)
                  .then((result) {
                setState(() {
                  _curNotificiationSetting = setting;
                });
                walletState.fcmUpdateBulk();
              });
            }
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  List<DialogListItem> getLanguageList() {
    List<DialogListItem> ret = [];
    AvailableLanguage.values.forEach((AvailableLanguage value) {
      LanguageSetting setting = LanguageSetting(value);
      ret.add(DialogListItem(
          option: setting.getDisplayName(context),
          action: () {
            if (setting != StateContainer.of(context).curLanguage) {
              sl.get<SharedPrefsUtil>().setLanguage(setting).then((result) {
                StateContainer.of(context).updateLanguage(setting);
              });
            }
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  String daemonURL;
  String versionString = "";
  NotificationSetting _curNotificiationSetting =
      NotificationSetting(NotificationOptions.ON);

  @override
  void initState() {
    super.initState();
    sl.get<SharedPrefsUtil>().getRpcUrl().then((result) {
      if (result != AppConstants.DEFAULT_RPC_HTTP_URL && mounted) {
        setState(() {
          daemonURL = result;
        });
      }
    });
    // Version string
    PackageInfo.fromPlatform().then((packageInfo) {
      setState(() {
        versionString = "v${packageInfo.version}";
      });
    });
    // Get default notification setting
    sl.get<SharedPrefsUtil>().getNotificationsOn().then((notificationsOn) {
      setState(() {
        _curNotificiationSetting = notificationsOn
            ? NotificationSetting(NotificationOptions.ON)
            : NotificationSetting(NotificationOptions.OFF);
      });
    });
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
                          AppLocalization.of(context).settingsHeader,
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
                              AppLocalization.of(context).preferencesHeader,
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
                            header: AppLocalization.of(context).currencyHeader,
                            subheader: StateContainer.of(context)
                                .curCurrency
                                .getDisplayName(context),
                            icon: AppIcons.currency,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: AppLocalization.of(context)
                                          .currencyHeader,
                                      optionsList: getCurrencyList()));
                            },
                          ),
                          SettingsListItem(
                            header: AppLocalization.of(context).languageHeader,
                            subheader: StateContainer.of(context)
                                .curLanguage
                                .getDisplayName(context),
                            icon: AppIcons.language,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: AppLocalization.of(context)
                                          .languageHeader,
                                      optionsList: getLanguageList()));
                            },
                          ),
                          SettingsListItem(
                            header: AppLocalization.of(context).themeHeader,
                            subheader: StateContainer.of(context)
                                        .curTheme
                                        .toString() ==
                                    BlaiseLightTheme().toString()
                                ? AppLocalization.of(context).themeLightHeader
                                : StateContainer.of(context)
                                            .curTheme
                                            .toString() ==
                                        BlaiseDarkTheme().toString()
                                    ? AppLocalization.of(context)
                                        .themeDarkHeader
                                    : AppLocalization.of(context)
                                        .themeCopperHeader,
                            icon: AppIcons.theme,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: AppLocalization.of(context)
                                          .themeHeader,
                                      optionsList: getThemeList()));
                            },
                          ),
                          SettingsListItem(
                            header:
                                AppLocalization.of(context).notificationsHeader,
                            subheader: _curNotificiationSetting
                                .getDisplayName(context),
                            icon: AppIcons.notifications,
                            onPressed: () {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: AppLocalization.of(context)
                                          .notificationsHeader,
                                      optionsList: getNotificationList()));
                            },
                          ),
                          SettingsListItem(
                            header: AppLocalization.of(context).securityHeader,
                            icon: AppIcons.security,
                            onPressed: () {
                              Navigator.pushNamed(context, '/security');
                            },
                          ),
                          SettingsListItem(
                            header: AppLocalization.of(context).daemonHeader,
                            subheader: daemonURL ??
                                AppLocalization.of(context).defaultHeader,
                            icon: AppIcons.changedaemon,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context,
                                  widget:
                                      ChangeDaemonSheet(onChanged: (newDaemon) {
                                    EventTaxiImpl.singleton().fire(
                                        DaemonChangedEvent(
                                            newDaemon: newDaemon));
                                    if (newDaemon !=
                                        AppConstants.DEFAULT_RPC_HTTP_URL) {
                                      setState(() {
                                        daemonURL = newDaemon;
                                      });
                                    } else {
                                      setState(() {
                                        daemonURL = null;
                                      });
                                    }
                                  }));
                            },
                          ),
                          // Manage text
                          Container(
                            alignment: Alignment(-1, 0),
                            margin: EdgeInsetsDirectional.only(
                                start: 24, end: 24, top: 18, bottom: 8),
                            child: AutoSizeText(
                              AppLocalization.of(context).manageHeader,
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
                            header: AppLocalization.of(context).contactsHeader,
                            icon: AppIcons.contacts,
                            onPressed: () {
                              Navigator.pushNamed(context, '/contacts',
                                  arguments: widget.account);
                            },
                          ),
                          SettingsListItem(
                            header: AppLocalization.of(context)
                                .backUpPrivateKeyHeader,
                            icon: AppIcons.backupprivatekey,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context,
                                  widget: BackupPrivateKeySheet());
                            },
                          ),
                          SettingsListItem(
                            header:
                                AppLocalization.of(context).viewPublicKeyHeader,
                            icon: Icons.public,
                            onPressed: () {
                              AppSheets.showBottomSheet(
                                  context: context, widget: PublicKeySheet());
                            },
                          ),
                          SettingsListItem(
                              header: AppLocalization.of(context).shareHeader,
                              icon: AppIcons.share,
                              onPressed: () {
                                UIUtil.cancelLockEvent();
                                Share.share(AppLocalization.of(context)
                                    .checkOutBlaiseParagraph);
                              }),
                          SettingsListItem(
                            header: AppLocalization.of(context).logoutHeader,
                            icon: AppIcons.logout,
                            onPressed: () {
                              logoutPressed();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(versionString,
                                    style: AppStyles.textStyleVersion(context)),
                                Text(" | ",
                                    style: AppStyles.textStyleVersion(context)),
                                GestureDetector(
                                    onTap: () {
                                      AppWebView.showWebView(context,
                                          AppConstants.PRIVACY_POLICY_URL);
                                    },
                                    child: Text(
                                        AppLocalization.of(context)
                                            .privacyPolicyHeader,
                                        style:
                                            AppStyles.textStyleVersionUnderline(
                                                context))),
                                Text(" | ",
                                    style: AppStyles.textStyleVersion(context)),
                                GestureDetector(
                                    onTap: () {
                                      AppWebView.showWebView(context,
                                          AppConstants.PRIVACY_POLICY_URL);
                                    },
                                    child: Text("EULA",
                                        style:
                                            AppStyles.textStyleVersionUnderline(
                                                context))),
                              ],
                            ),
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
              title: toUppercase(
                  AppLocalization.of(context).warningHeader, context),
              warningStyle: true,
              confirmButtonText: toUppercase(
                  AppLocalization.of(context).deletePrivateKeyAndLogoutButton,
                  context),
              body: TextSpan(
                children: formatLocalizedColorsDanger(context,
                    AppLocalization.of(context).logoutFirstDisclaimerParagraph),
              ),
              onConfirm: () {
                Navigator.of(context).pop();
                showAppDialog(
                    context: context,
                    builder: (_) => DialogOverlay(
                        title: toUppercase(
                            AppLocalization.of(context).areYouSureHeader,
                            context),
                        warningStyle: true,
                        confirmButtonText: toUppercase(
                            AppLocalization.of(context).yesImSureButton,
                            context),
                        body: TextSpan(
                          children: formatLocalizedColorsDanger(
                              context,
                              AppLocalization.of(context)
                                  .logoutSecondDisclaimerParagraph),
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
