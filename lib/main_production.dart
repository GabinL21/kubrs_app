import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kubrs_app/app/app.dart';
import 'package:kubrs_app/bootstrap.dart';
import 'package:kubrs_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await bootstrap(() => const App());
}
