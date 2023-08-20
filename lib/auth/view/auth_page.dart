import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubrs_app/auth/bloc/auth_bloc.dart';
import 'package:kubrs_app/auth/view/sign_in_button.dart';
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 196, 0, 196),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getHeader(context),
          _getGoogleSignInButton(context),
        ],
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 128, child: Image.asset('assets/logo.png')),
        const SizedBox(height: 32),
        Text(
          'Kubrs',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    );
  }

  Widget _getGoogleSignInButton(BuildContext context) {
    return SignInButton(
      iconData: Icons.account_circle_rounded,
      label: 'Sign-in with Google',
      onPressed: () => _authenticateWithGoogle(context),
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
