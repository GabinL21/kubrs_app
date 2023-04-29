import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/auth/auth.dart';
import 'package:kubrs_app/user/bloc/user_bloc.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 96, 32, 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Text(
                    'Hello ${state.userName}!',
                    style: Theme.of(context).textTheme.displayMedium,
                  );
                }
                return Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.displayMedium,
                );
              },
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              child: Text(
                'Sign out',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
