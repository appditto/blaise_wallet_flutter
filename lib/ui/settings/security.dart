import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/settings_list_item.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  List<DialogListItem> methodList = [ DialogListItem(option:"Biometrics"), DialogListItem(option:"PIN")];
  List<DialogListItem> launchList = [DialogListItem(option:"Yes"), DialogListItem(option:"No")];
  List<DialogListItem> lockList = [DialogListItem(option:"Instantly"), DialogListItem(option:"After 1 minute"), DialogListItem(option:"After 5 minutes"), DialogListItem(option:"After 15 minutes"), DialogListItem(option:"After 30 minutes"), DialogListItem(option:"After 60 minutes")];
  var _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    gradient:
                        StateContainer.of(context).curTheme.gradientPrimary,
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
                                highlightColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight15,
                                splashColor: StateContainer.of(context)
                                    .curTheme
                                    .textLight30,
                                onPressed: () {
                                  Navigator.pop(context);
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
                            margin:
                                EdgeInsetsDirectional.fromSTEB(4, 0, 24, 0),
                            child: AutoSizeText(
                              "Security",
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
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            StateContainer.of(context)
                                .curTheme
                                .shadowSettingsList,
                          ],
                        ),
                        // Settings List
                        child: ListView(
                          padding: EdgeInsetsDirectional.only(bottom: MediaQuery.of(context).padding.bottom+12),
                          children: <Widget>[
                            // Preferences text
                            Container(
                              alignment: Alignment(-1, 0),
                              margin: EdgeInsetsDirectional.only(
                                  start: 24, end: 24, top: 16, bottom: 8),
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
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark10,
                            ),
                            // List Items
                            SettingsListItem(
                              header: "Authentication Method",
                              subheader: "Biometrics",
                              icon: AppIcons.fingerprint,
                              onPressed: () {
                               showDialog(
                                 context: context,
                                 builder: (_) => DialogOverlay(title: 'Authentication Method', optionsList: methodList)                               
                               ); 
                              },
                              
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark10,
                            ),
                            SettingsListItem(
                              header: "Authenticate on Launch",
                              subheader: "Yes",
                              icon: AppIcons.lock,
                              onPressed: () {
                               showDialog(
                                 context: context,
                                 builder: (_) => DialogOverlay(title: 'Authenticate on Launch', optionsList: launchList)                               
                               ); 
                              },
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark10,
                            ),
                            SettingsListItem(
                              header: "Automatically Lock",
                              subheader: "Instantly",
                              icon: AppIcons.timer,
                              onPressed: () {
                               showDialog(
                                 context: context,
                                 builder: (_) => DialogOverlay(title: 'Automatically Lock', optionsList: lockList)                               
                               ); 
                              },
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textDark10,
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
