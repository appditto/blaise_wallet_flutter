import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:flutter/material.dart';

class PinScreen extends StatefulWidget {
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Main scaffold that holds everything
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
        // A Stack to achive the overlap between background gradient and number pad
        body: Stack(
          children: <Widget>[
            // Pin Text & Dots
            Positioned(
              top: 0,
              child: Container(),
            ),
            // Number Pad
            Positioned(
              bottom: 0,
              child: Container(),
            ),
          ],
        ));
  }
}
