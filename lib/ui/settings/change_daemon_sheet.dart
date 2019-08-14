import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/error_container.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:validators/validators.dart';

class ChangeDaemonSheet extends StatefulWidget {
  final Function onChanged;

  ChangeDaemonSheet({this.onChanged}) : super();

  _ChangeDaemonSheetState createState() => _ChangeDaemonSheetState();
}

class _ChangeDaemonSheetState extends State<ChangeDaemonSheet> {
  FocusNode daemonFocusNode;
  TextEditingController daemonController;

  String daemonError;

  @override
  void initState() {
    super.initState();
    this.daemonFocusNode = FocusNode();
    this.daemonController = TextEditingController();
    sl.get<SharedPrefsUtil>().getRpcUrl().then((val) {
      if (mounted) {
        daemonController.text = val;
      }
    });
    this.daemonFocusNode.addListener(() {
      if (!this.daemonFocusNode.hasFocus) {
        if (isIP(daemonController.text)) {
          if (!daemonController.text.contains(":")) {
            daemonController.text = daemonController.text + ":4003";
          }
        }
      }
    });
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
                              Navigator.of(context).pop();
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
                          toUppercase(AppLocalization.of(context)
                              .changeDaemonSheetHeader
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Paragraph
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 20),
                        child: AutoSizeText(
                          AppLocalization.of(context).changeDaemonParagraph,
                          style: AppStyles.paragraph(context),
                          stepGranularity: 0.1,
                          maxLines: 3,
                          minFontSize: 8,
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
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 0),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .addressTextFieldHeader,
                                  style: AppStyles.paragraphMedium(context),
                                  maxLines: 1,
                                  firstButton: TextFieldButton(
                                    icon: AppIcons.paste,
                                    onPressed: () async {
                                      String text =
                                          await UserDataUtil.getClipboardText(
                                              DataType.URL);
                                      if (text != null) {
                                        daemonController.text = text;
                                      }
                                    },
                                  ),
                                  controller: daemonController,
                                  focusNode: daemonFocusNode,
                                  onChanged: () {
                                    if (daemonError != null) {
                                      setState(() {
                                        daemonError = null;
                                      });
                                    }
                                  },
                                ),
                              ),
                              // Error Container
                              ErrorContainer(
                                errorText: daemonError ?? "",
                              ),
                              // Container for the "Set to Default" button
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .backgroundPrimary,
                                      boxShadow: [
                                        StateContainer.of(context)
                                            .curTheme
                                            .shadowTextDark,
                                      ],
                                    ),
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        30, 30, 30, 40),
                                    height: 40,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0)),
                                      child: AutoSizeText(
                                        AppLocalization.of(context)
                                            .setToDefaultButton,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        stepGranularity: 0.1,
                                        style: AppStyles.buttonMiniBg(context),
                                      ),
                                      onPressed: () {
                                        daemonFocusNode.unfocus();
                                        daemonController.text =
                                            AppConstants.DEFAULT_RPC_HTTP_URL;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // "CHANGE DAEMON" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: toUppercase(AppLocalization.of(context)
                          .changeDaemonButton
                          ,context),
                      onPressed: () async {
                        if (validateFormData()) {
                          String daemon = daemonController.text;
                          if (daemon == AppConstants.DEFAULT_RPC_HTTP_URL) {
                            await sl.get<SharedPrefsUtil>().resetRpcUrl();
                          } else {
                            await sl.get<SharedPrefsUtil>().setRpcUrl(daemon);
                          }
                          walletState.changeRpcUrl(daemon);
                          if (widget.onChanged != null) {
                            widget.onChanged(daemon);
                          }
                          UIUtil.showSnackbar(
                              AppLocalization.of(context)
                                  .urlChangedToParagraph
                                  .replaceAll("%1", daemon),
                              context);
                          Navigator.of(context).pop();
                        }
                      },
                      buttonTop: true,
                    ),
                  ],
                ),
                // "CANCEL" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: toUppercase(AppLocalization.of(context)
                          .cancelButton
                          ,context),
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

  bool validateFormData() {
    if (!isIP(daemonController.text) && !isURL(daemonController.text)) {
      setState(() {
        daemonError = AppLocalization.of(context).invalidAddressError;
      });
      return false;
    }
    return true;
  }
}
