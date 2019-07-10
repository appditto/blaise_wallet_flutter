import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TextField button
class TextFieldButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  TextFieldButton({@required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: StateContainer.of(context).curTheme.gradientPrimary,
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: CircleBorder(),
        onPressed: () {
          return onPressed != null ? onPressed() : null;
        },
        splashColor: StateContainer.of(context).curTheme.backgroundPrimary30,
        highlightColor: StateContainer.of(context).curTheme.backgroundPrimary15,
        child: Icon(
          icon,
          size: 22,
          color: StateContainer.of(context).curTheme.backgroundPrimary,
        ),
      ),
    );
  }
}

/// A widget for our custom textfields
class AppTextField extends StatefulWidget {
  final String label;
  final TextFieldButton firstButton;
  final TextFieldButton secondButton;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final TextStyle style;
  final bool passwordField;
  final Widget prefix;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  final Function onChanged;
  final Function onTap;
  final bool isAddress;

  AppTextField(
      {@required this.label,
      @required this.style,
      this.firstButton,
      this.secondButton,
      this.controller,
      this.focusNode,
      this.textCapitalization,
      this.inputType = TextInputType.text,
      this.prefix,
      this.maxLines,
      this.inputFormatters,
      this.onChanged,
      this.onTap,
      this.isAddress = false,
      this.passwordField = false});

  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  OverlayEntry _overlayEntry;
  @override
  void initState() {
    super.initState();
    if (widget.isAddress) {
      widget.focusNode.addListener(() {
        if (widget.focusNode.hasFocus) {
          this._overlayEntry = this._createOverlayEntry();
          Overlay.of(context).insert(this._overlayEntry);
        } else {
          this._overlayEntry.remove();
        }
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 2,
        width: size.width,
        child: Material(
          color: StateContainer.of(context).curTheme.backgroundPrimary,
          child: Container(
            constraints: BoxConstraints(maxHeight: 138),
            decoration: BoxDecoration(
                color: StateContainer.of(context).curTheme.backgroundPrimary,
                boxShadow: [
                  StateContainer.of(context).curTheme.shadowAccountCard
                ]),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    height: 46,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        return null;
                      },
                      child: Container(
                        alignment: Alignment(-1, 0),
                        margin: EdgeInsetsDirectional.only(start: 16, end: 16),
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "@",
                              style: AppStyles.settingsHeader(context),
                            ),
                            TextSpan(
                              text: "bbedward",
                              style: AppStyles.contactsItemName(context),
                            ),
                          ]),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 46,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        return null;
                      },
                      child: Container(
                        alignment: Alignment(-1, 0),
                        margin: EdgeInsetsDirectional.only(start: 16, end: 16),
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "@",
                              style: AppStyles.settingsHeader(context),
                            ),
                            TextSpan(
                              text: "bbedward2",
                              style: AppStyles.contactsItemName(context),
                            ),
                          ]),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 46,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        return null;
                      },
                      child: Container(
                        alignment: Alignment(-1, 0),
                        margin: EdgeInsetsDirectional.only(start: 16, end: 16),
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "@",
                              style: AppStyles.settingsHeader(context),
                            ),
                            TextSpan(
                              text: "bbedward3",
                              style: AppStyles.contactsItemName(context),
                            ),
                          ]),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-1, 0),
          child: AutoSizeText(
            widget.label,
            style: AppStyles.textFieldLabel(context),
          ),
        ),
        Container(
          child: Theme(
            data: ThemeData(
              primaryColor: StateContainer.of(context).curTheme.primary,
              hintColor: StateContainer.of(context).curTheme.primary,
              splashColor: StateContainer.of(context).curTheme.primary30,
              highlightColor: StateContainer.of(context).curTheme.primary15,
              textSelectionColor: StateContainer.of(context).curTheme.primary30,
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: widget.passwordField,
              style: widget.style,
              cursorColor: StateContainer.of(context).curTheme.primary,
              keyboardType: widget.inputType,
              autocorrect: false,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              textInputAction: TextInputAction.done,
              maxLines: widget.maxLines,
              minLines: 1,
              inputFormatters: widget.inputFormatters,
              onTap: widget.onTap,
              onChanged: (String newValue) {
                if (widget.onChanged != null) {
                  widget.onChanged(newValue);
                }
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: StateContainer.of(context).curTheme.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: StateContainer.of(context).curTheme.primary,
                      width: 2),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: StateContainer.of(context).curTheme.danger,
                      width: 2),
                ),
                prefix: widget.prefix,
                suffixIcon: widget.firstButton == null &&
                        widget.secondButton == null
                    ? null
                    : Container(
                        width: widget.firstButton == null ||
                                widget.secondButton == null
                            ? 50
                            : 100,
                        height: 38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            widget.secondButton != null
                                ? Container(
                                    margin:
                                        EdgeInsetsDirectional.only(start: 12),
                                    width: 38,
                                    height: 38,
                                    child: widget.secondButton)
                                : SizedBox(),
                            widget.firstButton != null
                                ? Container(
                                    margin:
                                        EdgeInsetsDirectional.only(start: 12),
                                    width: 38,
                                    height: 38,
                                    child: widget.firstButton)
                                : SizedBox()
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
