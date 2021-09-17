import 'package:flutter/material.dart';
import 'package:my_resto/common/navigation.dart';

Future<dynamic> showSimpleDialog({
  required BuildContext context,
  String title = 'Oops',
  String content = 'Something went wrong!',
  List<String>? listContent,
  List<Widget>? actions,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
        ),
        content: listContent == null
            ? Text(
                content,
                style: Theme.of(context).textTheme.bodyText2,
              )
            : _buildContent(listContent, context),
        actions: actions ??
            [
              TextButton(
                onPressed: () async {
                  Navigation.back();
                },
                child: Text('Ok'),
              )
            ],
      );
    },
  );
}

// only to build list of content text widget
Widget _buildContent(contents, context) {
  List<Widget> infoList = [];
  for (var item in contents) {
    infoList.add(ListTile(
      dense: false,
      title: Text(
        item,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      leading: Icon(Icons.circle, size: 10, color: Colors.grey.shade400),
      minLeadingWidth: 10,
    ));
  }

  return SingleChildScrollView(
    child: Wrap(
      children: infoList,
    ),
  );
}
