import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_resto/styles/styles.dart';

class MainMenu extends StatelessWidget {
  final IconData icon;
  final void Function() onClicked;
  final Color color;

  MainMenu(
    this.icon,
    this.onClicked,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClicked();
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 24,
            color: primaryColor,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
