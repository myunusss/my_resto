import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedLoadingIndicator extends StatelessWidget {
  final double? height;

  BlockedLoadingIndicator({
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      width: double.maxFinite,
      height: height ?? MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
