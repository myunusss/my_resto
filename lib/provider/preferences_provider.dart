import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_resto/styles/styles.dart';
import 'package:my_resto/utils/PreferencesHelper.dart';
import 'package:my_resto/utils/background_service.dart';
import 'package:my_resto/utils/date_time_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({
    required this.preferencesHelper,
  }) {
    _getTheme();
    _getDailyInfoPreferences();
  }

  bool _isDarkTheme = false;
  bool _isDailyInfoActive = false;

  bool get isDarkTheme => _isDarkTheme;
  bool get isDailyInfoActive => _isDailyInfoActive;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyInfoPreferences() async {
    _isDailyInfoActive = await preferencesHelper.isDailyInfoActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyInfo(bool value) async {
    preferencesHelper.setDailyInfo(value);
    _getDailyInfoPreferences();

    if (!isDailyInfoActive) {
      print('Scheduling News Activated');
      await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      await AndroidAlarmManager.cancel(1);
    }
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
