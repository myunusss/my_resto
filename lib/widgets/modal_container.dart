import 'package:flutter/material.dart';
import 'package:my_resto/styles/styles.dart';

class ModalContainer extends StatelessWidget {
  final String title;
  final Widget? child;
  final double? height;

  ModalContainer({
    required this.title,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: new BoxDecoration(
                    color: primaryColor,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 2,
                        color: Colors.grey,
                        margin: EdgeInsets.only(bottom: 16, top: 5),
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 16),
                      child ?? SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
