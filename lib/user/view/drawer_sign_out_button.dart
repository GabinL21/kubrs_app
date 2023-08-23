import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/auth/bloc/auth_bloc.dart';

class DrawerSignOutButton extends StatelessWidget {
  const DrawerSignOutButton({super.key});

  static const String label = 'Sign out';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    return TextButton.icon(
      onPressed: () => _signOut(context),
      icon: Icon(Icons.logout_outlined, color: color),
      label: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: color,
            ),
      ),
    );
  }

  void _signOut(BuildContext context) {
    context.read<AuthBloc>().add(SignOutRequested());
  }
}
