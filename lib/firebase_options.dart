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
    apiKey: 'AIzaSyBJRTKrXAxSYXImXCDpUJUVjnsGADnoTAM',
    appId: '1:73377390785:web:8e142a4b27bf2c91f6b440',
    messagingSenderId: '73377390785',
    projectId: 'fintrack-eeca0',
    authDomain: 'fintrack-eeca0.firebaseapp.com',
    storageBucket: 'fintrack-eeca0.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqCfbR08h1d66KGJV_5fZYc_CGqQh5MSg',
    appId: '1:73377390785:android:431fb7cd4cd127bef6b440',
    messagingSenderId: '73377390785',
    projectId: 'fintrack-eeca0',
    storageBucket: 'fintrack-eeca0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4KgwwSMxcrCKo9XCuBVaoBKYb8DJThuM',
    appId: '1:73377390785:ios:324bbd67b6c6f0d0f6b440',
    messagingSenderId: '73377390785',
    projectId: 'fintrack-eeca0',
    storageBucket: 'fintrack-eeca0.firebasestorage.app',
    iosBundleId: 'com.example.fintrack',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4KgwwSMxcrCKo9XCuBVaoBKYb8DJThuM',
    appId: '1:73377390785:ios:324bbd67b6c6f0d0f6b440',
    messagingSenderId: '73377390785',
    projectId: 'fintrack-eeca0',
    storageBucket: 'fintrack-eeca0.firebasestorage.app',
    iosBundleId: 'com.example.fintrack',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBJRTKrXAxSYXImXCDpUJUVjnsGADnoTAM',
    appId: '1:73377390785:web:66a754655e7572dff6b440',
    messagingSenderId: '73377390785',
    projectId: 'fintrack-eeca0',
    authDomain: 'fintrack-eeca0.firebaseapp.com',
    storageBucket: 'fintrack-eeca0.firebasestorage.app',
  );
}
