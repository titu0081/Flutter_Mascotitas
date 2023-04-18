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
        return macos;
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC191stN0z3-SUf0wvfucTyuUtBXMSMS4Y',
    appId: '1:878470169636:web:a3f12b91d13650402444b1',
    messagingSenderId: '878470169636',
    projectId: 'mascotitas-f62f8',
    authDomain: 'mascotitas-f62f8.firebaseapp.com',
    storageBucket: 'mascotitas-f62f8.appspot.com',
    measurementId: 'G-444EQE3HM1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrI6Umgy4Op-s3N7gcTt40qSnlY-Kub3I',
    appId: '1:878470169636:android:9f9055b10dd551872444b1',
    messagingSenderId: '878470169636',
    projectId: 'mascotitas-f62f8',
    storageBucket: 'mascotitas-f62f8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTlNoAowwLiB1Ax-Cy60GGspRyOuTxDKU',
    appId: '1:878470169636:ios:469e6eb77c37f7952444b1',
    messagingSenderId: '878470169636',
    projectId: 'mascotitas-f62f8',
    storageBucket: 'mascotitas-f62f8.appspot.com',
    androidClientId: '878470169636-m6hhi8knb0jg6remq6l82ghl5qkujuou.apps.googleusercontent.com',
    iosClientId: '878470169636-uu9gufjs13feagffo27ucc3td7ems9sd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mascotitas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTlNoAowwLiB1Ax-Cy60GGspRyOuTxDKU',
    appId: '1:878470169636:ios:469e6eb77c37f7952444b1',
    messagingSenderId: '878470169636',
    projectId: 'mascotitas-f62f8',
    storageBucket: 'mascotitas-f62f8.appspot.com',
    androidClientId: '878470169636-m6hhi8knb0jg6remq6l82ghl5qkujuou.apps.googleusercontent.com',
    iosClientId: '878470169636-uu9gufjs13feagffo27ucc3td7ems9sd.apps.googleusercontent.com',
    iosBundleId: 'com.example.mascotitas',
  );
}
