import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  Primary,
  PrimaryOutline,
  Success,
  SuccessOutline,
}

/// A widget for displaying a mnemonic phrase
class AppButton extends StatefulWidget {
  final AppButtonType type;
  final String text;
  final Function onPressed;
  final bool disabled;
  final bool buttonTop;

  AppButton(
      {this.type,
      this.text,
      this.onPressed,
      this.disabled = false,
      this.buttonTop = false});

  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: (widget.type == AppButtonType.Primary ||
                widget.type == AppButtonType.PrimaryOutline)
            ? StateContainer.of(context).curTheme.gradientPrimary
            : StateContainer.of(context)
                .curTheme
                .gradientPrimary, // Success color placeholder
        boxShadow: [
          widget.type == AppButtonType.Primary
              ? StateContainer.of(context).curTheme.shadowPrimaryOne
              : StateContainer.of(context).curTheme.shadowPrimaryTwo,
        ],
      ),
      margin: widget.buttonTop
          ? EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0)
          : EdgeInsetsDirectional.fromSTEB(
              20,
              16,
              20,
              (MediaQuery.of(context).padding.bottom) +
                  (24 - (MediaQuery.of(context).padding.bottom) / 2),
            ),
      height: 50,
      child: widget.type == AppButtonType.Primary
          // Primary Button
          ? FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: AutoSizeText(
                widget.text,
                textAlign: TextAlign.center,
                maxLines: 1,
                stepGranularity: 0.1,
                style: AppStyles.buttonPrimary(context),
              ),
              splashColor:
                  StateContainer.of(context).curTheme.backgroundPrimary30,
              highlightColor: StateContainer.of(context).curTheme.primary15,
              onPressed: () {
                if (widget.onPressed != null && !widget.disabled) {
                  widget.onPressed();
                }
                return;
              },
            )
          // Outlined Button
          : Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(2),
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        StateContainer.of(context).curTheme.backgroundPrimary,
                  ),
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
                      widget.text,
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
                      if (widget.onPressed != null && !widget.disabled) {
                        widget.onPressed();
                      }
                      return;
                    },
                  ),
                ),
              ],
            ),
    ));
  }
}
