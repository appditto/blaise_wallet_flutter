import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/model/authentication_method.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/routes.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/pin_screen.dart';
import 'package:blaise_wallet_flutter/util/authentication.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';

class LockScreenPage extends StatefulWidget {
  @override
  _LockScreenPageState createState() => _LockScreenPageState();
}

class _LockScreenPageState extends State<LockScreenPage> {
  bool _showUnlockButton = false;
  bool _lockedOut = true;
  String _countDownTxt = "";

  void _goHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/overview', (Route<dynamic> route) => false);
  }

  Widget _buildPinScreen(BuildContext context, String expectedPin) {
    return PinScreen(
        type: PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: "Enter PIN to Unlock Blaise",
        onSuccess: (pin) {
          _goHome();
        });
  }

  String _formatCountDisplay(int count) {
    if (count <= 60) {
      // Seconds only
      String secondsStr = count.toString();
      if (count < 10) {
        secondsStr = "0" + secondsStr;
      }
      return "00:" + secondsStr;
    } else if (count > 60 && count <= 3600) {
      // Minutes:Seconds
      String minutesStr = "";
      int minutes = count ~/ 60;
      if (minutes < 10) {
        minutesStr = "0" + minutes.toString();
      } else {
        minutesStr = minutes.toString();
      }
      String secondsStr = "";
      int seconds = count % 60;
      if (seconds < 10) {
        secondsStr = "0" + seconds.toString();
      } else {
        secondsStr = seconds.toString();
      }
      return minutesStr + ":" + secondsStr;
    } else {
      // Hours:Minutes:Seconds
      String hoursStr = "";
      int hours = count ~/ 3600;
      if (hours < 10) {
        hoursStr = "0" + hours.toString();
      } else {
        hoursStr = hours.toString();
      }
      count = count % 3600;
      String minutesStr = "";
      int minutes = count ~/ 60;
      if (minutes < 10) {
        minutesStr = "0" + minutes.toString();
      } else {
        minutesStr = minutes.toString();
      }
      String secondsStr = "";
      int seconds = count % 60;
      if (seconds < 10) {
        secondsStr = "0" + seconds.toString();
      } else {
        secondsStr = seconds.toString();
      }
      return hoursStr + ":" + minutesStr + ":" + secondsStr;
    }
  }

  Future<void> _runCountdown(int count) async {
    if (count >= 1) {
      if (mounted) {
        setState(() {
          _showUnlockButton = true;
          _lockedOut = true;
          _countDownTxt = _formatCountDisplay(count);
        });
      }
      Future.delayed(Duration(seconds: 1), () {
        _runCountdown(count - 1);
      });
    } else {
      if (mounted) {
        setState(() {
          _lockedOut = false;
        });
      }
    }
  }

  Future<void> _authenticate({bool transitions = false}) async {
    // Test if user is locked out
    // Get duration of lockout
    DateTime lockUntil = await sl.get<SharedPrefsUtil>().getLockDate();
    if (lockUntil == null) {
      await sl.get<SharedPrefsUtil>().resetLockAttempts();
    } else {
      int countDown = lockUntil.difference(DateTime.now().toUtc()).inSeconds;
      // They're not allowed to attempt
      if (countDown > 0) {
        _runCountdown(countDown);
        return;
      }
    }
    setState(() {
      _lockedOut = false;
    });
    sl.get<SharedPrefsUtil>().getAuthMethod().then((authMethod) {
      AuthUtil().hasBiometrics().then((hasBiometrics) {
        if (authMethod.method == AuthMethod.BIOMETRICS && hasBiometrics) {
          setState(() {
            _showUnlockButton = true;
          });
          AuthUtil()
              .authenticateWithBiometrics("Authenticate to Unlock Blaise")
              .then((authenticated) {
            if (authenticated) {
              _goHome();
            } else {
              setState(() {
                _showUnlockButton = true;
              });
            }
          });
        } else {
          // PIN Authentication
          sl.get<Vault>().getPin().then((expectedPin) {
            if (transitions) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return _buildPinScreen(context, expectedPin);
                }),
              );
            } else {
              Navigator.of(context).push(
                NoPushTransitionRoute(builder: (BuildContext context) {
                  return _buildPinScreen(context, expectedPin);
                }),
              );
            }
            Future.delayed(Duration(milliseconds: 200), () {
              if (mounted) {
                setState(() {
                  _showUnlockButton = true;
                });
              }
            });
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: <Widget>[
            //A widget that holds lock icon and background
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // A stack for background gradient and the lock icon
                  Stack(
                    children: <Widget>[
                      // Container for the gradient background
                      Container(
                        height: (MediaQuery.of(context).padding.top +
                            MediaQuery.of(context).size.width * 0.4),
                        decoration: BoxDecoration(
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                        ),
                      ),
                      // "Locked" text
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).padding.top +
                                MediaQuery.of(context).size.width * 0.08),
                        alignment: Alignment(0, 0),
                        child: Text(
                          "LOCKED",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      // Lock Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                top: MediaQuery.of(context).padding.top +
                                    MediaQuery.of(context).size.width * 0.2),
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                gradient: StateContainer.of(context)
                                    .curTheme
                                    .gradientPrimary,
                                borderRadius: BorderRadius.circular(400)),
                            child: Icon(Icons.lock,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundPrimary,
                                size: MediaQuery.of(context).size.width * 0.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _lockedOut
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width-60,
                      child: Text(
                        "Too many failed unlock attempts",
                        style: AppStyles.paragraphDanger(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SizedBox(),
            // "Unlock" button
            _showUnlockButton
                ? Row(
                    children: <Widget>[
                      AppButton(
                        type: AppButtonType.Primary,
                        text: _lockedOut ? _countDownTxt : "Unlock",
                        onPressed: () {
                          if (!_lockedOut) {
                            _authenticate(transitions: true);
                          }
                        },
                        disabled: _lockedOut,
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
