import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/authentication_method.dart';
import 'package:blaise_wallet_flutter/model/lock_timeout.dart';
import 'package:blaise_wallet_flutter/model/unlock_setting.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/settings_list_item.dart';
import 'package:blaise_wallet_flutter/util/authentication.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _hasBiometricsEnrolled;
  AuthenticationMethod curAuthMethod =
      AuthenticationMethod(AuthMethod.BIOMETRICS);
  LockTimeoutSetting curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.ONE);
  UnlockSetting curAuthOnLaunch = UnlockSetting(UnlockOption.NO);

  List<DialogListItem> _getAuthMethods() {
    List<DialogListItem> ret = [];
    AuthMethod.values.forEach((AuthMethod value) {
      AuthenticationMethod method = AuthenticationMethod(value);
      ret.add(DialogListItem(
          option: method.getDisplayName(context),
          action: () async {
            await sl.get<SharedPrefsUtil>().setAuthMethod(method);
            if (mounted) {
              setState(() {
                curAuthMethod = method;
              });
            }
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  List<DialogListItem> _authOnLaunchOptions() {
    List<DialogListItem> ret = [];
    UnlockOption.values.forEach((UnlockOption value) {
      UnlockSetting setting = UnlockSetting(value);
      ret.add(DialogListItem(
          option: setting.getDisplayName(context),
          action: () async {
            await sl
                .get<SharedPrefsUtil>()
                .setLock(setting.setting == UnlockOption.YES);
            if (mounted) {
              setState(() {
                curAuthOnLaunch = setting;
              });
            }
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  List<DialogListItem> _getLockTimeoutList() {
    List<DialogListItem> ret = [];
    LockTimeoutOption.values.forEach((LockTimeoutOption value) {
      LockTimeoutSetting setting = LockTimeoutSetting(value);
      ret.add(DialogListItem(
          option: setting.getDisplayName(context),
          action: () async {
            await sl.get<SharedPrefsUtil>().setLockTimeout(setting);
            if (mounted) {
              setState(() {
                curTimeoutSetting = setting;
              });
            }
            Navigator.of(context).pop();
          }));
    });
    return ret;
  }

  @override
  void initState() {
    super.initState();
    _hasBiometricsEnrolled = false;
    AuthUtil().hasBiometrics().then((hasBiometrics) {
      if (mounted) {
        setState(() {
          _hasBiometricsEnrolled = hasBiometrics;
        });
      }
    });
    sl.get<SharedPrefsUtil>().getAuthMethod().then((authMethod) {
      if (mounted) {
        setState(() {
          curAuthMethod = authMethod;
        });
      }
    });
    sl.get<SharedPrefsUtil>().getLockTimeout().then((result) {
      if (mounted) {
        setState(() {
          curTimeoutSetting = result;
        });
      }
    });
    sl.get<SharedPrefsUtil>().getLock().then((result) {
      if (result) {
        if (mounted) {
          setState(() {
            curAuthOnLaunch = UnlockSetting(UnlockOption.YES);
          });
        }
      } else {
        if (mounted) {
          setState(() {
            curAuthOnLaunch = UnlockSetting(UnlockOption.NO);
          });
        }
      }
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
                          AppLocalization.of(context).securityHeader,
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
                    child: ListView(
                      padding: EdgeInsetsDirectional.only(
                          bottom: MediaQuery.of(context).padding.bottom + 12),
                      children: <Widget>[
                        // Preferences text
                        Container(
                          alignment: Alignment(-1, 0),
                          margin: EdgeInsetsDirectional.only(
                              start: 24, end: 24, top: 16, bottom: 8),
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
                          color: StateContainer.of(context).curTheme.textDark10,
                        ),
                        // List Items
                        _hasBiometricsEnrolled
                            ? SettingsListItem(
                                header: AppLocalization.of(context)
                                    .authenticationMethodHeader,
                                subheader:
                                    curAuthMethod.getDisplayName(context),
                                icon: AppIcons.fingerprint,
                                onPressed: () {
                                  showAppDialog(
                                      context: context,
                                      builder: (_) => DialogOverlay(
                                          title: AppLocalization.of(context)
                                              .authenticationMethodHeader,
                                          optionsList: _getAuthMethods()));
                                },
                              )
                            : SizedBox(),
                        _hasBiometricsEnrolled
                            ? Container(
                                width: double.maxFinite,
                                height: 1,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textDark10,
                              )
                            : SizedBox(),
                        SettingsListItem(
                          header: AppLocalization.of(context)
                              .authenticateOnLaunchHeader,
                          subheader: curAuthOnLaunch.getDisplayName(context),
                          icon: AppIcons.lock,
                          onPressed: () {
                            showAppDialog(
                                context: context,
                                builder: (_) => DialogOverlay(
                                    title: AppLocalization.of(context)
                                        .authenticateOnLaunchHeader,
                                    optionsList: _authOnLaunchOptions()));
                          },
                        ),
                        SettingsListItem(
                          header: AppLocalization.of(context)
                              .automaticallyLockHeader,
                          subheader: curTimeoutSetting.getDisplayName(context),
                          icon: AppIcons.timer,
                          disabled: curAuthOnLaunch.setting == UnlockOption.NO,
                          onPressed: () {
                            if (curAuthOnLaunch.setting == UnlockOption.YES) {
                              showAppDialog(
                                  context: context,
                                  builder: (_) => DialogOverlay(
                                      title: AppLocalization.of(context)
                                          .automaticallyLockHeader,
                                      optionsList: _getLockTimeoutList()));
                            }
                          },
                        ),
                      ],
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
}
