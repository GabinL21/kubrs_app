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
            _navigateToTimerPage(context);
          } else if (state is AuthError) {
            _showAuthenticationError(context);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Unauthenticated) {
            return Center(child: _getAuthForm(context));
          }
          return Container();
        },
      ),
    );
  }

  void _navigateToTimerPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<Widget>(
        builder: (context) => const TimerPage(),
      ),
    );
  }

  void _showAuthenticationError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Authentication failed, check your network'),
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
        const SizedBox(
          height: 256,
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton.icon(
              onPressed: () => _authenticateWithGoogle(context),
              icon: Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              label: Text(
                'Sign-in with Google',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _authenticateWithGoogle(BuildContext context) {
    try {
      BlocProvider.of<AuthBloc>(context).add(
        GoogleSignInRequested(),
      );
    } catch (e) {
      _showAuthenticationError(context);
    }
  }
}
