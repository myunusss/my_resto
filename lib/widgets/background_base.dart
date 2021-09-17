import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      height: MediaQuery.of(context).size.height * 0.40,
    );
  }
}
