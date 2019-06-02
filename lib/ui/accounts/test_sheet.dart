import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:flutter/material.dart';


class StatefulSheet extends StatefulWidget {
  _StatefulSheetState createState() => _StatefulSheetState();
}

class _StatefulSheetState extends State<StatefulSheet> {

  @override Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundPrimary,
          boxShadow: [
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay20,
                offset: Offset(-5, 0),
                blurRadius: 20),
          ],
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
            top: 60,
          ),
          child: 
            Text('bebes'),
        ));
  }
}