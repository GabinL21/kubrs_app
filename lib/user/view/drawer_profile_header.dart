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
    final displayedUserName = Text(
      userState is UserLoaded ? userState.userName : 'Loading...',
      style: theme.textTheme.displayMedium,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: theme.colorScheme.tertiary,
          child: const Icon(Icons.person),
        ),
        const SizedBox(height: 16),
        displayedUserName,
        const SizedBox(height: 32),
        Divider(color: theme.colorScheme.secondary),
      ],
    );
  }
}
