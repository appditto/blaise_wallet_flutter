import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:event_taxi/event_taxi.dart';

class Payload extends StatefulWidget {
  final Function onPayloadChanged;
  final String initialPayload;
  final bool allowEncryption;

  Payload(
      {@required this.onPayloadChanged,
      this.initialPayload = "",
      this.allowEncryption = true})
      : super();

  @override
  _PayloadState createState() => _PayloadState();
}

class _PayloadState extends State<Payload> {
  bool _hasPayload;
  String _payload;
  bool _encrypted;

  StreamSubscription<PayloadChangedEvent> _payloadSub;

  void _registerBus() {
    _payloadSub = EventTaxiImpl.singleton()
        .registerTo<PayloadChangedEvent>()
        .listen((event) {
      setState(() {
        _payload = event.payload;
        _encrypted = false;
        _hasPayload = isNotEmpty(event.payload);
      });
    });
  }

  void _destroyBus() {
    if (_payloadSub != null) {
      _payloadSub.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    this._hasPayload = isNotEmpty(widget.initialPayload);
    this._payload = widget.initialPayload;
    this._encrypted = false;
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  void handlePayloadChange(String newPayload, bool encrypted) {
    if (isNotEmpty(newPayload) && mounted) {
      widget.onPayloadChanged(newPayload, encrypted);
      setState(() {
        _payload = newPayload;
        _hasPayload = true;
        _encrypted = encrypted;
      });
    } else if (mounted) {
      widget.onPayloadChanged(newPayload, encrypted);
      setState(() {
        _payload = "";
        _hasPayload = false;
        _encrypted = encrypted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Payload text and edit button
    return this._hasPayload
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container for the payload
              Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 110),
                  margin: EdgeInsetsDirectional.fromSTEB(30, 20, 12, 0),
                  padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1,
                        color: StateContainer.of(context).curTheme.textDark15),
                    color: StateContainer.of(context).curTheme.textDark10,
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width -
                              (_encrypted ? 151 : 136)),
                      child: AutoSizeText(
                        this._payload,
                        maxLines: 3,
                        stepGranularity: 0.1,
                        minFontSize: 6,
                        textAlign: TextAlign.left,
                        style: AppStyles.paragraphMedium(context),
                      ),
                    ),
                    _encrypted
                        ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsetsDirectional.only(start: 3.0),
                            child: Icon(FontAwesomeIcons.lock,
                                size: 12,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textDark))
                        : SizedBox()
                  ])),
              // Container for the edit button
              Container(
                  margin: EdgeInsetsDirectional.fromSTEB(0, 20, 30, 0),
                  child: TextFieldButton(
                    icon: Icons.edit,
                    onPressed: () async {
                      await showAppDialog(
                          context: context,
                          builder: (_) => PayloadDialog(
                                initialPayload: _payload,
                                encrypted: _encrypted,
                                onPayloadChanged: (newPayload, encrypted) {
                                  handlePayloadChange(newPayload, encrypted);
                                },
                              ));
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
                  borderRadius: BorderRadius.circular(100.0),
                  color: StateContainer.of(context).curTheme.backgroundPrimary,
                  boxShadow: [
                    StateContainer.of(context).curTheme.shadowTextDark,
                  ],
                ),
                margin: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 40),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: AutoSizeText(
                    AppLocalization.of(context).addAPayloadButton,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    stepGranularity: 0.1,
                    style: AppStyles.buttonMiniBg(context),
                  ),
                  onPressed: () async {
                    await showAppDialog(
                        context: context,
                        builder: (_) => PayloadDialog(
                              onPayloadChanged: (newPayload, encrypted) {
                                handlePayloadChange(newPayload, encrypted);
                              },
                              allowEncryption: widget.allowEncryption,
                            ));
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
  final bool encrypted;
  final bool allowEncryption;

  PayloadDialog(
      {@required this.onPayloadChanged,
      this.initialPayload = "",
      this.encrypted = false,
      this.allowEncryption = true})
      : super();

  @override
  _PayloadDialogState createState() => _PayloadDialogState();
}

class _PayloadDialogState extends State<PayloadDialog>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _opacityAnimation;

  TextEditingController payloadController;

  bool _encrypted;

  @override
  void initState() {
    super.initState();
    // Set initial value
    this.payloadController = TextEditingController();
    this.payloadController.text = widget.initialPayload;
    this._encrypted = widget.encrypted;

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
                      margin: EdgeInsetsDirectional.only(
                          start: 20,
                          end: 20,
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 50),
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
                                        label: AppLocalization.of(context)
                                            .payloadTextFieldHeader,
                                        controller: payloadController,
                                        style: AppStyles.paragraph(context),
                                        maxLines: 1,
                                        firstButton: TextFieldButton(
                                            icon: AppIcons.paste,
                                            onPressed: () {
                                              Clipboard.getData("text/plain")
                                                  .then((clipboardData) {
                                                if (clipboardData.text.length <=
                                                    80) {
                                                  widget.onPayloadChanged(
                                                      clipboardData.text,
                                                      _encrypted);
                                                  payloadController.text =
                                                      clipboardData.text;
                                                }
                                              });
                                            }),
                                        secondButton: TextFieldButton(
                                            icon: AppIcons.scan,
                                            onPressed: () async {
                                              String text =
                                                  await UserDataUtil.getQRData(
                                                      DataType.RAW,
                                                      StateContainer.of(context).curTheme.scannerTheme);
                                              if (text != null &&
                                                  text.length <= 80) {
                                                widget.onPayloadChanged(
                                                    text, _encrypted);
                                                payloadController.text = text;
                                              }
                                            }),
                                        onChanged: (payload) {
                                          widget.onPayloadChanged(
                                              payload, _encrypted);
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(80)
                                        ],
                                      ),
                                    ),
                                    widget.allowEncryption
                                        ? Row(
                                            children: <Widget>[
                                              Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              152),
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(20, 16, 0, 20),
                                                  child: AutoSizeText(
                                                    AppLocalization.of(context)
                                                        .encryptPayloadHeader,
                                                    style: AppStyles
                                                        .textFieldLabel(
                                                            context),
                                                    minFontSize: 8,
                                                    stepGranularity: 0.1,
                                                    maxLines: 1,
                                                  )),
                                              Container(
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(4, 16, 30, 18),
                                                child: Switch(
                                                  value: _encrypted,
                                                  onChanged: (bool) {
                                                    widget.onPayloadChanged(
                                                        this
                                                            .payloadController
                                                            .text,
                                                        !_encrypted);
                                                    setState(() {
                                                      _encrypted = !_encrypted;
                                                    });
                                                  },
                                                  inactiveThumbColor:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .switchKnob,
                                                  inactiveTrackColor:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .switchTrack,
                                                  activeColor:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .primary,
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(height: 34),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
