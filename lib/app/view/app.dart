import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubrs_app/l10n/l10n.dart';
import 'package:kubrs_app/timer/timer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0D0D0D),
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0D0D0D),
          selectedItemColor: Color(0xFFFF8837),
          unselectedItemColor: Color(0xFFFFFFFF),
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFF121212),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const TimerPage(),
    );
  }
}
