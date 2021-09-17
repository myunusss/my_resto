import 'package:my_resto/styles/styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function() onClicked;
  final String label;
  final int height;
  final bool isNegative;

  RoundedButton({
    required this.onClicked,
    required this.label,
    required this.height,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: height.toDouble(),
          width: 150.0,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                isNegative ? Colors.grey : secondaryColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: Colors.white,
                    fontSize: height / 2,
                  ),
            ),
            onPressed: onClicked,
          ),
        ),
      ],
    );
  }
}
