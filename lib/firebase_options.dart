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
    // if (kIsWeb) {
    //   return web;
    // }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      // case TargetPlatform.macOS:
      //   return macos;
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

  // static FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyCTw23b189tbmLQlKbfrBXFmBNuB0KnhXw',
  //   appId: '1:675947114692:web:4bfe38beb2dcc06a011991',
  //   messagingSenderId: '675947114692',
  //   projectId: 'tarides',
  //   authDomain: 'tarides.firebaseapp.com',
  //   storageBucket: 'tarides.appspot.com',
  //   measurementId: 'G-S9VH0XBGGY',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGF993dY8qWAMFF6hUzVpz6EcReWOzVtc',
    appId: '1:675947114692:android:7208765a0b38d454011991',
    messagingSenderId: '675947114692',
    projectId: 'tarides',
    storageBucket: 'tarides.appspot.com',
  );

  // static  FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyDujSnEQKeMR_Vvla8TtbTjfD0I9o5_VRM',
  //   appId: '1:675947114692:ios:67c3a14867cbcaae011991',
  //   messagingSenderId: '675947114692',
  //   projectId: 'tarides',
  //   storageBucket: 'tarides.appspot.com',
  //   iosBundleId: 'com.example.taRides',
  // );

  // static  FirebaseOptions macos = FirebaseOptions(
  //   apiKey: 'AIzaSyDujSnEQKeMR_Vvla8TtbTjfD0I9o5_VRM',
  //   appId: '1:675947114692:ios:67c3a14867cbcaae011991',
  //   messagingSenderId: '675947114692',
  //   projectId: 'tarides',
  //   storageBucket: 'tarides.appspot.com',
  //   iosBundleId: 'com.example.taRides',
  // );
}