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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANwmz7E5264aplEF0Pjaf5VTaXql8xogk',
    appId: '1:55247807174:web:ce653196f74d7c82adadc7',
    messagingSenderId: '55247807174',
    projectId: 'stylestack-7f1cc',
    authDomain: 'stylestack-7f1cc.firebaseapp.com',
    storageBucket: 'stylestack-7f1cc.appspot.com',
    measurementId: 'G-64M8KXF6N0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDq_8rzcHVzJzp5Wd4g9DC8lt9yV8I4s4Q',
    appId: '1:55247807174:android:63de5ba15185ff94adadc7',
    messagingSenderId: '55247807174',
    projectId: 'stylestack-7f1cc',
    storageBucket: 'stylestack-7f1cc.appspot.com',
  );
}
