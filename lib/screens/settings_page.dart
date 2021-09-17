import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_resto/provider/preferences_provider.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:my_resto/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/setting_page';

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: Text(
              'Dark Theme',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: Consumer<PreferencesProvider>(
              builder: (context, provider, child) {
                return Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      provider.enableDarkTheme(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(height: 5),
        Material(
          child: ListTile(
            title: Text(
              'Scheduling News',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: Consumer<PreferencesProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isDailyInfoActive,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.enableDailyInfo(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          title: Text(
        'Settings',
        style: Theme.of(context).textTheme.headline6!.copyWith(color: primaryColor),
      )),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: _buildList(context),
        ),
      ),
    );
  }
}
