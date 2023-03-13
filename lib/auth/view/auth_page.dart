import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/auth/bloc/auth_bloc.dart';
import 'package:kubrs_app/timer/timer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthView();
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<Widget>(
                builder: (context) => const TimerPage(),
              ),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authentication failed, check your network'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is Unauthenticated) {
            return Center(child: _getAuthForm(context));
          }
          return Container();
        },
      ),
    );
  }

  Widget _getAuthForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Kubrs',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        TextButton.icon(
          onPressed: () => _authenticateWithGoogle(context),
          icon: const Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          label: Text(
            'Sign-in with Google',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        )
      ],
    );
  }

  void _authenticateWithGoogle(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
