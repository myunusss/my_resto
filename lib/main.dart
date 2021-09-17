import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/data/db/database_helper.dart';
import 'package:my_resto/data/models/restaurant.dart';
import 'package:my_resto/provider/database_provider.dart';
import 'package:my_resto/provider/preferences_provider.dart';
import 'package:my_resto/provider/restaurant_provider.dart';
import 'package:my_resto/provider/restaurants_provider.dart';
import 'package:my_resto/screens/detail_page.dart';
import 'package:my_resto/screens/favorite_page.dart';
import 'package:my_resto/screens/home_page.dart';
import 'package:my_resto/screens/search_page.dart';
import 'package:my_resto/screens/settings_page.dart';
import 'package:my_resto/screens/splash_screen.dart';
import 'package:my_resto/utils/PreferencesHelper.dart';
import 'package:my_resto/utils/background_service.dart';
import 'package:my_resto/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Submission 2 - Restaurant App',
            theme: provider.themeData,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              HomePage.routeName: (context) => HomePage(),
              SearchPage.routeName: (context) => SearchPage(),
              DetailPage.routeName: (context) => DetailPage(
                    restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
                  ),
              SettingsPage.routeName: (context) => SettingsPage(),
              FavoritePage.routeName: (context) => FavoritePage(),
            },
          );
        },
      ),
    );
  }
}
