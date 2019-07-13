import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/strings.dart';

class Payload extends StatefulWidget {
  final Function onPayloadChanged;
  final String initialPayload;

  Payload({@required this.onPayloadChanged, this.initialPayload = ""}) : super();

  @override
  _PayloadState createState() => _PayloadState();
}

class _PayloadState extends State<Payload> {
  bool _hasPayload;
  String _payload;

  @override
  void initState() {
    super.initState();
    this._hasPayload = isNotEmpty(widget.initialPayload);
    this._payload = widget.initialPayload;
  }

  void handlePayloadChange(String newPayload) {
    if (isNotEmpty(newPayload) && mounted) {
      widget.onPayloadChanged(newPayload);
      setState(() {
        _payload = newPayload;
        _hasPayload = true;
      });                              
    } else if (mounted) {
      widget.onPayloadChanged(newPayload);
      setState(() {
        _payload = "";
        _hasPayload = false;
      });
    }    
  }

  @override
  Widget build(BuildContext context) {
    // Payload text and edit button
    return this._hasPayload
        ? Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: <Widget>[
              // Container for the payload
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context)
                            .size
                            .width -
                        110),
                margin:
                    EdgeInsetsDirectional.fromSTEB(
                        30, 20, 12, 0),
                padding:
                    EdgeInsetsDirectional.fromSTEB(
                        12, 8, 12, 8),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                      width: 1,
                      color:
                          StateContainer.of(context)
                              .curTheme
                              .textDark15),
                  color: StateContainer.of(context)
                      .curTheme
                      .textDark10,
                ),
                child: AutoSizeText(
                  this._payload,
                  maxLines: 3,
                  stepGranularity: 0.1,
                  minFontSize: 6,
                  textAlign: TextAlign.left,
                  style: AppStyles.paragraphMedium(
                      context),
                ),
              ),
              // Container for the edit button
              Container(
                  margin: EdgeInsetsDirectional
                      .fromSTEB(0, 20, 30, 0),
                  child: TextFieldButton(
                    icon: Icons.edit,
                    onPressed: () async {
                      await showAppDialog(
                        context: context,
                        builder: (_) =>
                          PayloadDialog(
                            initialPayload: _payload,
                            onPayloadChanged: (newPayload) {
                              handlePayloadChange(newPayload);
                            },
                          )
                      );
                    },
                  ))
            ],
          )
        :
        // "Add Payload" button
        Row(
          children: <Widget>[
            Container(
              height: 40.0,
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
              margin:
                  EdgeInsetsDirectional.fromSTEB(
                      30, 20, 30, 40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            100.0)),
                child: AutoSizeText(
                  "+ Add a Payload",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  stepGranularity: 0.1,
                  style: AppStyles.buttonMiniBg(
                      context),
                ),
                onPressed: () async {
                  await showAppDialog(
                      context: context,
                      builder: (_) =>
                        PayloadDialog(
                          onPayloadChanged: (newPayload) {
                            handlePayloadChange(newPayload);
                          },
                        )
                  );
                },
              ),
            ),
          ],
        );    
  }
}

/// An overlay that supports a list of options as well as text/confirm actions
class PayloadDialog extends StatefulWidget {
  final Function onPayloadChanged;
  final String initialPayload;

  PayloadDialog({@required this.onPayloadChanged, this.initialPayload = ""}) : super();

  @override
  _PayloadDialogState createState() => _PayloadDialogState();
}

class _PayloadDialogState extends State<PayloadDialog>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _opacityAnimation;

  TextEditingController payloadController;

  @override
  void initState() {
    super.initState();

    // Set initial value
    this.payloadController = TextEditingController();
    this.payloadController.text = widget.initialPayload;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleAnimation = Tween(begin: 0.75, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _opacityAnimation = Tween(begin: 0.25, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
      child: Align(
        alignment: Alignment(0, 1),
        child: Material(
          color: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeOutQuad,
                  margin: EdgeInsetsDirectional.only(start: 20, end: 20, bottom: MediaQuery.of(context).viewInsets.bottom+30),
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                      maxWidth: MediaQuery.of(context).size.width - 40),
                  decoration: BoxDecoration(
                    color: StateContainer.of(context)
                        .curTheme
                        .backgroundPrimary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: StateContainer.of(context).curTheme.shadow50,
                        offset: Offset(0, 30),
                        blurRadius: 60,
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height *
                                            0.6 -
                                        60,
                                minHeight: 0),
                            // Options list
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Container for the amount text field
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      20, 24, 20, 0),
                                  child: AppTextField(
                                    label: 'Payload',
                                    controller: payloadController,
                                    style: AppStyles.paragraph(context),
                                    maxLines: 1,
                                    firstButton: TextFieldButton(
                                        icon: AppIcons.paste,
                                        onPressed: () {
                                          Clipboard.getData("text/plain").then((clipboardData) {
                                            if (clipboardData.text.length <= 20) {
                                              widget.onPayloadChanged(clipboardData.text);
                                              payloadController.text = clipboardData.text;
                                            }
                                          });
                                        }),
                                    secondButton: TextFieldButton(
                                        icon: AppIcons.scan),
                                    onChanged: (payload) {
                                      widget.onPayloadChanged(payload);
                                    },
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                  ),
                                ),
                                // Container for the "Add Payload" button
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 40.0,
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
                                      margin:
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 30, 20, 24),
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    100.0)),
                                        child: AutoSizeText(
                                          "Encrypt the Payload",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          stepGranularity: 0.1,
                                          style: AppStyles.buttonMiniBg(
                                              context),
                                        ),
                                        onPressed: () async {
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      )
    );
  }  
}