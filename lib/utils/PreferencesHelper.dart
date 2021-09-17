import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  static const DARK_THEME = 'DARK_THEME';
  static const DAILY_INFO = 'DAILY_INFO';

  PreferencesHelper({
    required this.sharedPreferences,
  });

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_THEME) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_THEME, value);
  }

  Future<bool> get isDailyInfoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_INFO) ?? false;
  }

  void setDailyInfo(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_INFO, value);
  }
}
