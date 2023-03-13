import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubrs_app/auth/bloc/auth_bloc.dart';
import 'package:kubrs_app/auth/repository/auth_repository.dart';
import 'package:kubrs_app/auth/view/auth_page.dart';
import 'package:kubrs_app/l10n/l10n.dart';
import 'package:kubrs_app/timer/timer.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';
import 'package:kubrs_app/user/repository/user_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _getThemeData(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (_) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
          child: RepositoryProvider(
            create: (_) => UserRepository(),
            child: BlocProvider(
              create: (context) => UserBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
              ),
              child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) return const TimerPage();
                  return const AuthPage();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  ThemeData _getThemeData() {
    const colorScheme = ColorScheme.dark(
      background: Color.fromRGBO(13, 13, 13, 1),
      primary: Color.fromRGBO(18, 18, 18, 1),
      onPrimary: Color.fromRGBO(255, 255, 255, 1),
      tertiary: Color.fromRGBO(247, 241, 149, 1),
      error: Color.fromRGBO(247, 149, 149, 1),
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
