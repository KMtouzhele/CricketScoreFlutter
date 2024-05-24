// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDYaRgE8x_GcK61hRT1M4gVNz-YI6L02V8',
    appId: '1:926842508938:web:f6c6f7d15d1ddd4ce27f73',
    messagingSenderId: '926842508938',
    projectId: 'flutter-c523d',
    authDomain: 'flutter-c523d.firebaseapp.com',
    storageBucket: 'flutter-c523d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhLzIVNgRHxqVPfLcRdAHWuA_wuWXDILM',
    appId: '1:926842508938:android:c0dd7ab86bcb40b3e27f73',
    messagingSenderId: '926842508938',
    projectId: 'flutter-c523d',
    storageBucket: 'flutter-c523d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHiuFJUdHbgEIdX0HmbIerMyrSum6ZUrw',
    appId: '1:926842508938:ios:76c5e98e257956aee27f73',
    messagingSenderId: '926842508938',
    projectId: 'flutter-c523d',
    storageBucket: 'flutter-c523d.appspot.com',
    iosBundleId: 'au.edu.utas.kaimol.cricketscore.crossplatform',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHiuFJUdHbgEIdX0HmbIerMyrSum6ZUrw',
    appId: '1:926842508938:ios:76c5e98e257956aee27f73',
    messagingSenderId: '926842508938',
    projectId: 'flutter-c523d',
    storageBucket: 'flutter-c523d.appspot.com',
    iosBundleId: 'au.edu.utas.kaimol.cricketscore.crossplatform',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYaRgE8x_GcK61hRT1M4gVNz-YI6L02V8',
    appId: '1:926842508938:web:4db064d50fea3a93e27f73',
    messagingSenderId: '926842508938',
    projectId: 'flutter-c523d',
    authDomain: 'flutter-c523d.firebaseapp.com',
    storageBucket: 'flutter-c523d.appspot.com',
  );
}