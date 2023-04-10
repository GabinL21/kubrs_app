import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const ColorScheme _colorScheme = ColorScheme.dark(
    background: Color.fromRGBO(13, 13, 13, 1),
    primary: Color.fromRGBO(18, 18, 18, 1),
    onPrimary: Color.fromRGBO(255, 255, 255, 1),
    tertiary: Color.fromRGBO(247, 241, 149, 1),
    error: Color.fromRGBO(247, 149, 149, 1),
  );

  static final TextTheme _textTheme = GoogleFonts.montserratTextTheme(
    TextTheme(
      displayLarge: TextStyle(
        color: _colorScheme.onBackground,
        fontSize: 64,
        fontWeight: FontWeight.w700,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      displayMedium: TextStyle(
        color: _colorScheme.onBackground,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    ),
  );

  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: _colorScheme.primary,
    elevation: 0,
  );

  static final BottomNavigationBarThemeData _bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: _colorScheme.primary,
    selectedItemColor: _colorScheme.tertiary,
    unselectedItemColor: _colorScheme.onPrimary,
    elevation: 0,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static final DrawerThemeData _drawerTheme = DrawerThemeData(
    backgroundColor: _colorScheme.primary,
    elevation: 0,
  );

  static final ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: _colorScheme.onPrimary,
  );

  static ThemeData get themeData {
    return ThemeData(
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: _colorScheme.background,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      drawerTheme: _drawerTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
    );
  }
}
