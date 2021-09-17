import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static intentAndRemove(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  static back() => navigatorKey.currentState?.pop();
}
