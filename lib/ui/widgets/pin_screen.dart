import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/util/haptic_util.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PinOverlayType { NEW_PIN, ENTER_PIN }

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    //t from 0.0 to 1.0
    return sin(t * 3 * pi);
  }
}

class PinScreen extends StatefulWidget {
  final PinOverlayType type;
  final String expectedPin;
  final String description;
  final Function onSuccess;

  PinScreen(
      {@required this.type,
      @required this.onSuccess,
      this.description = "",
      this.expectedPin = ""});

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen>
    with SingleTickerProviderStateMixin {
  static const int MAX_ATTEMPTS = 5;
  static const int PIN_LENGTH = 6;

  String pinEnterTitle = "";
  String pinCreateTitle = "";

  // Stateful data
  List<IconData> _dotStates;
  String _pin;
  String _pinConfirmed;
  bool
      _awaitingConfirmation; // true if pin has been entered once, false if not entered once
  String _header;
  int _failedAttempts = 0;

  // Invalid animation
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize list all empty
    if (widget.type == PinOverlayType.ENTER_PIN) {
      _header = pinEnterTitle;
    } else {
      _header = pinCreateTitle;
    }
    _dotStates = List.filled(PIN_LENGTH, FontAwesomeIcons.circle);
    _awaitingConfirmation = false;
    _pin = "";
    _pinConfirmed = "";
    // Get adjusted failed attempts
    sl.get<SharedPrefsUtil>().getLockAttempts().then((attempts) {
      setState(() {
        _failedAttempts = attempts % MAX_ATTEMPTS;
      });
    });
    // Set animation
    _controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: _controller, curve: ShakeCurve());
    _animation = Tween(begin: 0.0, end: 25.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.type == PinOverlayType.ENTER_PIN) {
            sl.get<SharedPrefsUtil>().incrementLockAttempts().then((_) {
              _failedAttempts++;
              if (_failedAttempts >= MAX_ATTEMPTS) {
                setState(() {
                  _controller.value = 0;
                });
                sl.get<SharedPrefsUtil>().updateLockDate().then((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/lock_screen', (Route<dynamic> route) => false);
                });
              } else {
                setState(() {
                  _pin = "";
                  _header = AppLocalization.of(context).invalidPINParagraph;
                  _dotStates = List.filled(PIN_LENGTH, FontAwesomeIcons.circle);
                  _controller.value = 0;
                });
              }
            });
          } else {
            setState(() {
              _awaitingConfirmation = false;
              _dotStates = List.filled(PIN_LENGTH, FontAwesomeIcons.circle);
              _pin = "";
              _pinConfirmed = "";
              _header = AppLocalization.of(context).noMatchPINParagraph;
              _controller.value = 0;
            });
          }
        }
      })
      ..addListener(() {
        setState(() {
          // the animation object’s value is the changed state
        });
      });
  }

  /// Set next character in the pin set
  /// return true if all characters entered
  bool _setCharacter(String character) {
    if (_awaitingConfirmation) {
      setState(() {
        _pinConfirmed = _pinConfirmed + character;
      });
    } else {
      setState(() {
        _pin = _pin + character;
      });
    }
    for (int i = 0; i < _dotStates.length; i++) {
      if (_dotStates[i] == FontAwesomeIcons.circle) {
        setState(() {
          _dotStates[i] = FontAwesomeIcons.solidCircle;
        });
        break;
      }
    }
    if (_dotStates.last == FontAwesomeIcons.solidCircle) {
      return true;
    }
    return false;
  }

  void _backSpace() {
    if (_dotStates[0] != FontAwesomeIcons.circle) {
      int lastFilledIndex;
      for (int i = 0; i < _dotStates.length; i++) {
        if (_dotStates[i] == FontAwesomeIcons.solidCircle) {
          if (i == _dotStates.length ||
              _dotStates[i + 1] == FontAwesomeIcons.circle) {
            lastFilledIndex = i;
            break;
          }
        }
      }
      setState(() {
        _dotStates[lastFilledIndex] = FontAwesomeIcons.circle;
        if (_awaitingConfirmation) {
          _pinConfirmed = _pinConfirmed.substring(0, _pinConfirmed.length - 1);
        } else {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      });
    }
  }

  Widget buildPINButton(String text) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: text == ""
          ? SizedBox()
          : InkWell(
              // Real tap function
              onTapDown: (details) {
                if (_controller.status == AnimationStatus.forward ||
                    _controller.status == AnimationStatus.reverse) {
                  return;
                }
                if (text == "-") {
                  _backSpace();
                } else {
                  if (_setCharacter(text)) {
                    // Mild delay so they can actually see the last dot get filled
                    Future.delayed(Duration(milliseconds: 50), () {
                      if (widget.type == PinOverlayType.ENTER_PIN) {
                        // Pin is not what was expected
                        if (_pin != widget.expectedPin) {
                          HapticUtil.error();
                          _controller.forward();
                        } else {
                          sl
                              .get<SharedPrefsUtil>()
                              .resetLockAttempts()
                              .then((_) {
                            widget.onSuccess(_pin);
                          });
                        }
                      } else {
                        if (!_awaitingConfirmation) {
                          // Switch to confirm pin
                          setState(() {
                            _awaitingConfirmation = true;
                            _dotStates = List.filled(
                                PIN_LENGTH, FontAwesomeIcons.circle);
                            _header = AppLocalization.of(context).confirmPINParagraph;
                          });
                        } else {
                          // First and second pins match
                          if (_pin == _pinConfirmed) {
                            widget.onSuccess(_pin);
                          } else {
                            HapticUtil.error();
                            _controller.forward();
                          }
                        }
                      }
                    });
                  }
                }
              },
              // For the splash effect
              onTap: () {},
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 8),
              child: Center(
                child: text == "-"
                    ? Icon(
                        Icons.backspace,
                        color: StateContainer.of(context).curTheme.primary,
                      )
                    : Text(
                        text,
                        style: AppStyles.pinNumberPad(context),
                      ),
              ),
            ),
    );
  }

  List<Widget> buildPINScreenDots() {
    List<Widget> ret = List();
    for (int i = 0; i < PIN_LENGTH; i++) {
      ret.add(
        Container(
          margin: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
          child: Icon(_dotStates[i],
              size: 18,
              color: StateContainer.of(context).curTheme.backgroundPrimary),
        ),
      );
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    if (pinEnterTitle.isEmpty) {
      setState(() {
        pinEnterTitle = AppLocalization.of(context).enterPINParagraph;
        if (widget.type == PinOverlayType.ENTER_PIN) {
          _header = pinEnterTitle;
        }
      });
    }
    if (pinCreateTitle.isEmpty) {
      setState(() {
        pinCreateTitle = AppLocalization.of(context).createPINParagraph;
        if (widget.type == PinOverlayType.NEW_PIN) {
          _header = pinCreateTitle;
        }
      });
    }
    // Main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      // A Stack to achive the overlap between background gradient and number pad
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: <Widget>[
            // Pin Text & Dots
            Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width * 5 / 4),
              width: double.maxFinite,
              padding: EdgeInsetsDirectional.fromSTEB(
                  0,
                  MediaQuery.of(context).padding.top,
                  0,
                  MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                  gradient:
                      StateContainer.of(context).curTheme.gradientPrimary),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // PIN header
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                      child: AutoSizeText(
                        _header,
                        style: AppStyles.modalHeader(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        minFontSize: 10,
                        stepGranularity: 0.1,
                      ),
                    ),
                    // PIN description
                    widget.description == null
                        ? Container(
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 4, 30, 0),
                            child: AutoSizeText(
                              widget.description,
                              textAlign: TextAlign.center,
                              style: AppStyles.pinDescription(context),
                              maxLines: 2,
                              minFontSize: 10,
                              stepGranularity: 0.1,
                            ),
                          )
                        : SizedBox(),
                    // Dots
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: MediaQuery.of(context).size.width * 0.25 +
                              _animation.value,
                          end: MediaQuery.of(context).size.width * 0.25 -
                              _animation.value,
                          top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildPINScreenDots(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Number Pad
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.width * 5 / 4 + 16,
                width: double.maxFinite,
                padding: EdgeInsetsDirectional.fromSTEB(
                    MediaQuery.of(context).size.width * 0.075,
                    MediaQuery.of(context).size.width * 0.075,
                    MediaQuery.of(context).size.width * 0.075,
                    MediaQuery.of(context).padding.bottom +
                        MediaQuery.of(context).size.width * 0.075),
                decoration: BoxDecoration(
                  color: StateContainer.of(context).curTheme.backgroundPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    StateContainer.of(context).curTheme.shadowBottomBar,
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            buildPINButton("1"),
                            buildPINButton("2"),
                            buildPINButton("3"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            buildPINButton("4"),
                            buildPINButton("5"),
                            buildPINButton("6"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            buildPINButton("7"),
                            buildPINButton("8"),
                            buildPINButton("9"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            buildPINButton(""),
                            buildPINButton("0"),
                            buildPINButton("-"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
