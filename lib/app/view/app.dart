import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/app/view/app_theme.dart';
import 'package:kubrs_app/auth/bloc/auth_bloc.dart';
import 'package:kubrs_app/auth/repository/auth_repository.dart';
import 'package:kubrs_app/auth/view/auth_page.dart';
import 'package:kubrs_app/gui/bloc/gui_bloc.dart';
import 'package:kubrs_app/l10n/l10n.dart';
import 'package:kubrs_app/nav/bloc/navigation_bloc.dart';
import 'package:kubrs_app/scramble/bloc/scramble_bloc.dart';
import 'package:kubrs_app/scramble/utils/scramble_generator.dart';
import 'package:kubrs_app/session/bloc/session_bloc.dart';
import 'package:kubrs_app/solve/bloc/solve_bloc.dart';
import 'package:kubrs_app/solve/repository/cache_solve_repository.dart';
import 'package:kubrs_app/solve/repository/firestore_synced_solve_repository.dart';
import 'package:kubrs_app/solve/repository/solve_repository.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';
import 'package:kubrs_app/user/repository/user_repository.dart';
import 'package:kubrs_app/user/view/user_drawer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
            create: (_) => AuthRepository(),
          ),
          RepositoryProvider<UserRepository>(
            create: (_) => UserRepository(),
          ),
          RepositoryProvider<SolveRepository>(
            create: (_) => FirestoreSyncedSolveRepository(
              solveRepository: CacheSolveRepository(),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              ),
            ),
            BlocProvider<UserBloc>(
              create: (context) => UserBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
              ),
            ),
          ],
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) return _getScaffold(context);
              return const AuthPage();
            },
          ),
        ),
      ),
    );
  }

  Widget _getScaffold(BuildContext context) {
    final solveRepository = RepositoryProvider.of<SolveRepository>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GuiBloc(),
        ),
        BlocProvider(
          create: (_) => NavigationBloc(),
        ),
        BlocProvider(
          // Keeps the same scramble even if you switch to another page
          create: (_) => ScrambleBloc(scrambleGenerator: ScrambleGenerator()),
        ),
        BlocProvider(
          // Keeps the same solve even if you switch to another page
          create: (_) => SolveBloc(solveRepository: solveRepository),
        ),
        BlocProvider(
          // Maintains the session start date time
          create: (_) => SessionBloc(solveRepository: solveRepository),
        ),
      ],
      child: BlocBuilder<GuiBloc, GuiState>(
        builder: (_, state) {
          return Scaffold(
            appBar: state is GuiShowed ? AppBar() : null,
            bottomNavigationBar:
                state is GuiShowed ? _getBottomNavigationBar() : null,
            drawer: const UserDrawer(),
            body: _getPage(),
          );
        },
      ),
    );
  }

  Widget _getBottomNavigationBar() {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final navigationBloc = BlocProvider.of<NavigationBloc>(context);
        return DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined),
                label: 'Timer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.query_stats_outlined),
                label: 'Stats',
              ),
            ],
            currentIndex: state.index,
            onTap: (index) => navigationBloc.add(NavigateToIndex(index)),
          ),
        );
      },
    );
  }

  Widget _getPage() {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (_, state) {
        return state.page;
      },
    );
  }
}
