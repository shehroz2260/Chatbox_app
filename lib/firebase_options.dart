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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEoJY2kcA8-ltZ6ARjYYngTl5WbN0NGMs',
    appId: '1:19774752137:android:d42abefe5906b3643e8d58',
    messagingSenderId: '19774752137',
    projectId: 'hero-pain-tech',
    storageBucket: 'hero-pain-tech.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5BJ2xHeMMOwS5EePBX3vXoK3NN5kVveo',
    appId: '1:19774752137:ios:944b2034b1c724513e8d58',
    messagingSenderId: '19774752137',
    projectId: 'hero-pain-tech',
    storageBucket: 'hero-pain-tech.appspot.com',
    androidClientId: '19774752137-u7ouan0hhisitkuj2a8ofu554g95o7dc.apps.googleusercontent.com',
    iosClientId: '19774752137-rt7rl06taur0fm3t9dr5jnd2nf1g778p.apps.googleusercontent.com',
    iosBundleId: 'com.example.practiceProject',
  );
}
