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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwpyNOC5OV00a_P6N9CX2kfyVSVlrsKoQ',
    appId: '1:56705165052:android:9751850274f8b7ba31d979',
    messagingSenderId: '56705165052',
    projectId: 'task-app-1fa22',
    storageBucket: 'task-app-1fa22.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRWBGbjPfyBD60B5XrVgbz0VDEOVv-Ubw',
    appId: '1:56705165052:ios:ea13ed4dd0ffe43a31d979',
    messagingSenderId: '56705165052',
    projectId: 'task-app-1fa22',
    storageBucket: 'task-app-1fa22.appspot.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZNEGfb0Ovv6WkWkQUCMd8pJXGpwlaPxk',
    appId: '1:56705165052:web:6ca20a5e738df07231d979',
    messagingSenderId: '56705165052',
    projectId: 'task-app-1fa22',
    authDomain: 'task-app-1fa22.firebaseapp.com',
    storageBucket: 'task-app-1fa22.appspot.com',
  );
}
