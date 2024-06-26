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
    apiKey: 'AIzaSyBQYFqVxIWnfBVDPz-aT4vUV0aSN9cFDr0',
    appId: '1:156461131733:web:dfa2d3615797bea34b3f5c',
    messagingSenderId: '156461131733',
    projectId: 'flutterfiredb01-bdf7f',
    authDomain: 'flutterfiredb01-bdf7f.firebaseapp.com',
    storageBucket: 'flutterfiredb01-bdf7f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUnyqvQ0eel9dsYrem8XAYVq_BCMR63vE',
    appId: '1:156461131733:android:308e505f24d2826e4b3f5c',
    messagingSenderId: '156461131733',
    projectId: 'flutterfiredb01-bdf7f',
    storageBucket: 'flutterfiredb01-bdf7f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwCAgjGhzvFzLUCqstOYmckfYjzbqZvBM',
    appId: '1:156461131733:ios:caf7e8e655b635c64b3f5c',
    messagingSenderId: '156461131733',
    projectId: 'flutterfiredb01-bdf7f',
    storageBucket: 'flutterfiredb01-bdf7f.appspot.com',
    iosBundleId: 'com.example.flutterlist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwCAgjGhzvFzLUCqstOYmckfYjzbqZvBM',
    appId: '1:156461131733:ios:caf7e8e655b635c64b3f5c',
    messagingSenderId: '156461131733',
    projectId: 'flutterfiredb01-bdf7f',
    storageBucket: 'flutterfiredb01-bdf7f.appspot.com',
    iosBundleId: 'com.example.flutterlist',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBQYFqVxIWnfBVDPz-aT4vUV0aSN9cFDr0',
    appId: '1:156461131733:web:29bf4ad4c82af6fd4b3f5c',
    messagingSenderId: '156461131733',
    projectId: 'flutterfiredb01-bdf7f',
    authDomain: 'flutterfiredb01-bdf7f.firebaseapp.com',
    storageBucket: 'flutterfiredb01-bdf7f.appspot.com',
  );
}
