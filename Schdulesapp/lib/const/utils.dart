import 'package:flutter/material.dart';

import 'colors.dart';


final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: lightThemePrimaryColor,
    primaryColorDark: lightThemePrimaryColorDark,
    hintColor: lightThemeAccentColor,
    canvasColor: Colors.transparent,
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline5: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 18),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 16),
      caption: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 14),
    ),
  );
}

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: darkThemePrimaryColor,
    primaryColorDark: darkThemePrimaryColorDark,
    hintColor: darkThemeAccentColor,
    canvasColor: Colors.transparent,
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline5: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 16),
      caption: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14),
    ),
  );
}

final ThemeData kAmoledTheme = _buildAmoledTheme();

ThemeData _buildAmoledTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: amoledThemePrimaryColor,
    primaryColorDark: amoledThemePrimaryColorDark,
    hintColor: amoledThemeAccentColor,
    canvasColor: Colors.transparent,
    primaryIconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline5: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20),
      bodyText2: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18),
      bodyText1: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 16),
      caption: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontSize: 14),
    ),
  );
}