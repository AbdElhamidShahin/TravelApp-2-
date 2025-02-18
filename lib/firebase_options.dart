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
    apiKey: 'AIzaSyCP-nMB9byhoFXCvMrEyUBTIvVjDVoAf14',
    appId: '1:253004647318:web:95ac54eee990f56468ebb7',
    messagingSenderId: '253004647318',
    projectId: 'toursm-app',
    authDomain: 'toursm-app.firebaseapp.com',
    storageBucket: 'toursm-app.firebasestorage.app',
    measurementId: 'G-BYNGQM575R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFZK6eTIzKUPxhKgpSg4GLyl0McbHX_bQ',
    appId: '1:253004647318:android:6ca8ee37e26535a468ebb7',
    messagingSenderId: '253004647318',
    projectId: 'toursm-app',
    storageBucket: 'toursm-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFarSj64pgauHmKG4qpM5UT7qp9Z6tK6s',
    appId: '1:253004647318:ios:f2bc57421aebd35768ebb7',
    messagingSenderId: '253004647318',
    projectId: 'toursm-app',
    storageBucket: 'toursm-app.firebasestorage.app',
    iosBundleId: 'com.example.tourismApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFarSj64pgauHmKG4qpM5UT7qp9Z6tK6s',
    appId: '1:253004647318:ios:f2bc57421aebd35768ebb7',
    messagingSenderId: '253004647318',
    projectId: 'toursm-app',
    storageBucket: 'toursm-app.firebasestorage.app',
    iosBundleId: 'com.example.tourismApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCP-nMB9byhoFXCvMrEyUBTIvVjDVoAf14',
    appId: '1:253004647318:web:dd077f15e20d6e6768ebb7',
    messagingSenderId: '253004647318',
    projectId: 'toursm-app',
    authDomain: 'toursm-app.firebaseapp.com',
    storageBucket: 'toursm-app.firebasestorage.app',
    measurementId: 'G-X4JY0W6RQ9',
  );

}