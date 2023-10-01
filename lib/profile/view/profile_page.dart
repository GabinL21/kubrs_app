import 'package:flutter/material.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.userState});

  final UserState userState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ProfileView(userState: userState),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userState});

  final UserState userState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(48, 64, 48, 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getHeader(userState, theme),
        ],
      ),
    );
  }

  Widget _getHeader(UserState userState, ThemeData theme) {
    final userName =
        userState is UserLoaded ? userState.userName : 'Loading...';
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        userName,
        style: theme.textTheme.displayLarge,
      ),
    );
  }
}
