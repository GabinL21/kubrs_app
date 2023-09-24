import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';

class DrawerProfileHeader extends StatelessWidget {
  const DrawerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return _getProfileHeader(state, theme);
      },
    );
  }

  Widget _getProfileHeader(UserState userState, ThemeData theme) {
    final displayedUserName = Text(
      userState is UserLoaded ? userState.userName : 'Loading...',
      style: theme.textTheme.displayMedium,
    );
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: theme.colorScheme.background),
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      accountName: displayedUserName,
      accountEmail: Container(),
    );
  }
}
