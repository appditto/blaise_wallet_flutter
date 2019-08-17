import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  Primary,
  PrimaryLeft,
  PrimaryRight,
  PrimaryOutline,
  Success,
  SuccessOutline,
  Danger,
  DangerOutline,
}

/// A widget for buttons
class AppButton extends StatefulWidget {
  final AppButtonType type;
  final String text;
  final Function onPressed;
  final bool disabled;
  final bool buttonTop;
  final bool buttonMiddle;
  final bool placeholder;

  AppButton(
      {this.type,
      this.text,
      this.onPressed,
      this.disabled = false,
      this.buttonTop = false,
      this.placeholder = false,
      this.buttonMiddle = false});

  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Opacity(
      opacity: widget.disabled ? 0.4 : 1.0,
      child: Container(
        margin: widget.buttonTop
            ? EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0)
            : widget.buttonMiddle
                ? EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0)
                : EdgeInsetsDirectional.fromSTEB(
                    widget.type == AppButtonType.PrimaryRight ? 10 : 20,
                    16,
                    widget.type == AppButtonType.PrimaryLeft ? 10 : 20,
                    (MediaQuery.of(context).padding.bottom) +
                        (24 - (MediaQuery.of(context).padding.bottom) / 2),
                  ),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: (widget.type == AppButtonType.Primary ||
                  widget.type == AppButtonType.PrimaryOutline ||
                  widget.type == AppButtonType.PrimaryLeft ||
                  widget.type == AppButtonType.PrimaryRight)
              ? StateContainer.of(context).curTheme.gradientPrimary
              : (widget.type == AppButtonType.Danger ||
                      widget.type == AppButtonType.DangerOutline ||
                      widget.type == AppButtonType.Success ||
                      widget.type == AppButtonType.SuccessOutline)
                  ? null
                  : StateContainer.of(context)
                      .curTheme
                      .gradientPrimary, // Success color placeholder
          color: (widget.type == AppButtonType.Danger ||
                  widget.type == AppButtonType.DangerOutline)
              ? StateContainer.of(context).curTheme.danger
              : widget.type == AppButtonType.Success ||
                      widget.type == AppButtonType.SuccessOutline
                  ? StateContainer.of(context).curTheme.success
                  : null,
          boxShadow: [
            widget.type == AppButtonType.Primary ||
                    widget.type == AppButtonType.PrimaryLeft ||
                    widget.type == AppButtonType.PrimaryRight
                ? StateContainer.of(context).curTheme.shadowPrimaryOne
                : widget.type == AppButtonType.PrimaryOutline
                    ? StateContainer.of(context).curTheme.shadowPrimaryTwo
                    : widget.type == AppButtonType.Success
                        ? StateContainer.of(context).curTheme.shadowSuccessOne
                        : widget.type == AppButtonType.SuccessOutline
                            ? StateContainer.of(context)
                                .curTheme
                                .shadowSuccessTwo
                            : widget.type == AppButtonType.Danger
                                ? StateContainer.of(context)
                                    .curTheme
                                    .shadowDangerOne
                                : StateContainer.of(context)
                                    .curTheme
                                    .shadowDangerTwo,
          ],
        ),
        child: widget.type == AppButtonType.Primary ||
                widget.type == AppButtonType.PrimaryLeft ||
                widget.type == AppButtonType.PrimaryRight ||
                widget.type == AppButtonType.Success ||
                widget.type == AppButtonType.Danger
            // Primary Button
            ? FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: !widget.placeholder
                    ? AutoSizeText(
                        widget.text,
                        textAlign: TextAlign.center,
                        maxLines: widget.type == AppButtonType.Danger ? 2 : 1,
                        stepGranularity: 0.1,
                        style: widget.type == AppButtonType.Danger
                            ? AppStyles.buttonDanger(context)
                            : AppStyles.buttonPrimary(context),
                      )
                    // Placeholder button rectangle
                    : Container(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.textLight.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: AutoSizeText(
                          widget.text,
                          textAlign: TextAlign.center,
                          maxLines: widget.type == AppButtonType.Danger ? 2 : 1,
                          stepGranularity: 0.1,
                          style: widget.type == AppButtonType.Danger
                              ? AppStyles.buttonDanger(context)
                              : AppStyles.buttonPrimary(context),
                        ),
                      ),
                splashColor:
                    StateContainer.of(context).curTheme.backgroundPrimary30,
                highlightColor:
                    StateContainer.of(context).curTheme.backgroundPrimary15,
                onPressed: () {
                  if (widget.onPressed != null && !widget.disabled) {
                    widget.onPressed();
                  }
                  return;
                },
              )
            // Primary Outlined Button
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
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                    ),
                    child: FlatButton(
                      child: AutoSizeText(
                        widget.text,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                        style: widget.type == AppButtonType.DangerOutline
                            ? AppStyles.buttonDangerOutline(context)
                            : widget.type == AppButtonType.SuccessOutline
                                ? AppStyles.buttonSuccessOutline(context)
                                : AppStyles.buttonPrimaryOutline(context),
                      ),
                      color: Colors.transparent,
                      splashColor: widget.type == AppButtonType.SuccessOutline
                          ? StateContainer.of(context).curTheme.success30
                          : widget.type == AppButtonType.DangerOutline
                              ? StateContainer.of(context).curTheme.danger30
                              : StateContainer.of(context).curTheme.primary30,
                      highlightColor: widget.type ==
                              AppButtonType.SuccessOutline
                          ? StateContainer.of(context).curTheme.success15
                          : widget.type == AppButtonType.DangerOutline
                              ? StateContainer.of(context).curTheme.danger15
                              : StateContainer.of(context).curTheme.primary15,
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
      ),
    ));
  }
}
