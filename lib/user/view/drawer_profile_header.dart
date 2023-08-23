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
        return _getHeaderContent(state, theme);
      },
    );
  }

  Widget _getHeaderContent(UserState userState, ThemeData theme) {
    if (userState is UserLoaded) {
      return Text(
        userState.userName,
        style: theme.textTheme.displayMedium,
      );
    }
    return Text(
      'Loading...',
      style: theme.textTheme.displayMedium,
    );
  }
}
