import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFF0776F3);

final Color darkPrimaryColor = Color(0xFFECEFF1);
final Color darkSecondaryColor = Color(0xFF607D88);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 92,
    color: Colors.black,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 57,
    color: Colors.black,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 46,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 32,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 23,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 19,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 13,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.nunito(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.nunito(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.nunito(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.nunito(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.nunito(
    fontSize: 10,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: myTextTheme.apply(bodyColor: Colors.black),
    elevation: 1,
    backgroundColor: secondaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: secondaryColor,
      textStyle: TextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: darkPrimaryColor,
  accentColor: darkSecondaryColor,
  scaffoldBackgroundColor: Colors.white,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: myTextTheme.apply(bodyColor: Colors.white),
    elevation: 1,
    backgroundColor: darkSecondaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: darkSecondaryColor,
      textStyle: TextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
  ),
);
