import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const ColorScheme _colorScheme = ColorScheme.light(
    background: Color.fromRGBO(248, 248, 248, 1),
    primary: Color.fromRGBO(69, 69, 69, 1),
    secondary: Color.fromRGBO(132, 132, 132, 1),
    onPrimary: Color.fromRGBO(69, 69, 69, 1),
    tertiary: Color.fromRGBO(88, 136, 229, 1),
    error: Color.fromRGBO(249, 82, 82, 1),
    shadow: Color.fromRGBO(0, 0, 0, 0.05),
  );

  static final TextTheme _textTheme = GoogleFonts.montserratTextTheme(
    TextTheme(
      displayLarge: TextStyle(
        color: _colorScheme.primary,
        fontSize: 64,
        fontWeight: FontWeight.w700,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      displayMedium: TextStyle(
        color: _colorScheme.primary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      displaySmall: TextStyle(
        color: _colorScheme.primary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    ),
  );

  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: _colorScheme.surface,
    elevation: 8,
    shadowColor: _colorScheme.shadow,
  );

  static final BottomNavigationBarThemeData _bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: _colorScheme.surface,
    selectedItemColor: _colorScheme.primary,
    unselectedItemColor: _colorScheme.secondary,
    elevation: 0,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  );

  static final DrawerThemeData _drawerTheme = DrawerThemeData(
    backgroundColor: _colorScheme.background,
    elevation: 0,
  );

  static final ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: _colorScheme.tertiary,
  );

  static final DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: _colorScheme.background,
    titleTextStyle: _textTheme.displayMedium,
    contentTextStyle: _textTheme.displaySmall,
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
      dialogTheme: _dialogTheme,
    );
  }
}
