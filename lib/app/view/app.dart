import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubrs_app/auth/view/auth_page.dart';
import 'package:kubrs_app/l10n/l10n.dart';
import 'package:kubrs_app/timer/timer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _getThemeData(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return const TimerPage();
          return const AuthPage();
        },
      ),
    );
  }

  ThemeData _getThemeData() {
    const colorScheme = ColorScheme.dark(
      background: Color(0xFF0D0D0D),
      primary: Color(0xFF121212),
      onPrimary: Color(0xFFFFFFFF),
      tertiary: Color.fromARGB(255, 247, 241, 149),
    );
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: GoogleFonts.montserratTextTheme(
        TextTheme(
          displayLarge: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 64,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
          displayMedium: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.primary,
        selectedItemColor: colorScheme.tertiary,
        unselectedItemColor: colorScheme.onPrimary,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
    );
  }
}
