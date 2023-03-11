import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kubrs',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextButton.icon(
              onPressed: signInWithGoogle,
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
        ),
      ),
    );
  }
}
