// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for fuchsia - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAlbqt3zFeFfDHMtFy0z-SY78MxSqj9HRw',
    appId: '1:940539174983:web:4f9e7952f94a952d8d5162',
    messagingSenderId: '940539174983',
    projectId: 'kubrs-a5890',
    authDomain: 'kubrs-a5890.firebaseapp.com',
    storageBucket: 'kubrs-a5890.appspot.com',
    measurementId: 'G-66CKBM155M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAl8gSK3G_yIYsHgVX47RllgbXZzL1xQqo',
    appId: '1:940539174983:android:889b89f598440d9b8d5162',
    messagingSenderId: '940539174983',
    projectId: 'kubrs-a5890',
    storageBucket: 'kubrs-a5890.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGzNjIExvf84nMEfcN2eVuxLljyxdkpmY',
    appId: '1:940539174983:ios:5ab03a899b4b09718d5162',
    messagingSenderId: '940539174983',
    projectId: 'kubrs-a5890',
    storageBucket: 'kubrs-a5890.appspot.com',
    iosClientId:
        '940539174983-i91ej0c18hb3dq7d750q72upnar2e55u.apps.googleusercontent.com',
    iosBundleId: 'com.example.verygoodcore.kubrs-app',
  );
}
