import 'package:flutter/material.dart';
import 'package:my_resto/common/navigation.dart';
import 'package:my_resto/screens/home_page.dart';
import 'package:my_resto/styles/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash_page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () async {
      Navigation.intentAndRemove(HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Image(
          image: AssetImage("images/logo_blue.png"),
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
