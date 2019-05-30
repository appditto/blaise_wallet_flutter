import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/exceptions.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  Primary,
  PrimaryOutline,
  Success,
  SuccessOutline,
}

class AppButton {
  // Primary button builder
  static Widget buildAppButton(
      BuildContext context, AppButtonType type, String buttonText,
      {Function onPressed, bool disabled = false, bool buttonTop = false}) {
    switch (type) {
      case AppButtonType.Primary:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: StateContainer.of(context).curTheme.gradientPrimary,
              boxShadow: [
                StateContainer.of(context).curTheme.shadowPrimary,
              ],
            ),
            margin: buttonTop
                ? EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0)
                : EdgeInsetsDirectional.fromSTEB(
                    20,
                    16,
                    20,
                    (MediaQuery.of(context).padding.bottom) +
                        (24 - (MediaQuery.of(context).padding.bottom) / 2),
                  ),
            height: 50,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                maxLines: 1,
                stepGranularity: 0.1,
                style: AppStyles.buttonPrimary(context),
              ),
              splashColor:
                  StateContainer.of(context).curTheme.backgroundPrimary30,
              highlightColor:
                  StateContainer.of(context).curTheme.backgroundPrimary15,
              onPressed: () {
                if (onPressed != null && !disabled) {
                  onPressed();
                }
                return;
              },
            ),
          ),
        );
      case AppButtonType.PrimaryOutline:
        return Expanded(
          child: Container(
            margin: buttonTop
                ? EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0)
                : EdgeInsetsDirectional.fromSTEB(
                    20,
                    16,
                    20,
                    (MediaQuery.of(context).padding.bottom) +
                        (24 - (MediaQuery.of(context).padding.bottom) / 2),
                  ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                StateContainer.of(context).curTheme.shadowSecondary,
              ],
            ),
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient:
                            StateContainer.of(context).curTheme.gradientPrimary,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                  ),
                  height: 50,
                  width: double.maxFinite,
                  child: FlatButton(
                    child: AutoSizeText(
                      buttonText,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      stepGranularity: 0.1,
                      style: AppStyles.buttonPrimaryOutline(context),
                    ),
                    color: Colors.transparent,
                    splashColor: StateContainer.of(context).curTheme.primary30,
                    highlightColor:
                        StateContainer.of(context).curTheme.primary15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    onPressed: () {
                      if (onPressed != null && !disabled) {
                        onPressed();
                      }
                      return;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        throw new UIException("Invalid Button Type $type");
    }
  } //
}
