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
    apiKey: 'AIzaSyBD9anEcd2Tw0zMxBJ3S4Wtb9I3RyI21UA',
    appId: '1:741352721927:web:fb5fa76e3616dfb353a4a2',
    messagingSenderId: '741352721927',
    projectId: 'barbearia-f05f6',
    authDomain: 'barbearia-f05f6.firebaseapp.com',
    databaseURL: 'https://barbearia-f05f6-default-rtdb.firebaseio.com',
    storageBucket: 'barbearia-f05f6.appspot.com',
    measurementId: 'G-CTHPD8EN50',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0xxjA-5HnHVJtvJ4Hq8lIpYO8o5MsA_A',
    appId: '1:741352721927:android:52a7b79d802e2c3253a4a2',
    messagingSenderId: '741352721927',
    projectId: 'barbearia-f05f6',
    databaseURL: 'https://barbearia-f05f6-default-rtdb.firebaseio.com',
    storageBucket: 'barbearia-f05f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMYfsq2nH6dfGO2twQylgftOo8-5N_uKE',
    appId: '1:741352721927:ios:d020e635dc719e7353a4a2',
    messagingSenderId: '741352721927',
    projectId: 'barbearia-f05f6',
    databaseURL: 'https://barbearia-f05f6-default-rtdb.firebaseio.com',
    storageBucket: 'barbearia-f05f6.appspot.com',
    iosClientId: '741352721927-aqv944ajfbetvtgtaoe3itro5pc37mf5.apps.googleusercontent.com',
    iosBundleId: 'com.example.barbearia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDMYfsq2nH6dfGO2twQylgftOo8-5N_uKE',
    appId: '1:741352721927:ios:d020e635dc719e7353a4a2',
    messagingSenderId: '741352721927',
    projectId: 'barbearia-f05f6',
    databaseURL: 'https://barbearia-f05f6-default-rtdb.firebaseio.com',
    storageBucket: 'barbearia-f05f6.appspot.com',
    iosClientId: '741352721927-aqv944ajfbetvtgtaoe3itro5pc37mf5.apps.googleusercontent.com',
    iosBundleId: 'com.example.barbearia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBD9anEcd2Tw0zMxBJ3S4Wtb9I3RyI21UA',
    appId: '1:741352721927:web:36a16a6ed513e07a53a4a2',
    messagingSenderId: '741352721927',
    projectId: 'barbearia-f05f6',
    authDomain: 'barbearia-f05f6.firebaseapp.com',
    databaseURL: 'https://barbearia-f05f6-default-rtdb.firebaseio.com',
    storageBucket: 'barbearia-f05f6.appspot.com',
    measurementId: 'G-D1JSHV8RM8',
  );

}