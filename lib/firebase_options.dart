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
    apiKey: 'AIzaSyCOOZEiPBiLRjOOsB4OUjKZzPRVz7RY7vA',
    appId: '1:1016272451637:web:f4770602242d92d62e197c',
    messagingSenderId: '1016272451637',
    projectId: 'chat-app-706a2',
    authDomain: 'chat-app-706a2.firebaseapp.com',
    storageBucket: 'chat-app-706a2.firebasestorage.app',
    measurementId: 'G-EDFLVWG1WM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4cL39ya-1Zb5PcQ7gZoa7CO8AnKSo82k',
    appId: '1:1016272451637:android:10a2ce3a9fa27cc02e197c',
    messagingSenderId: '1016272451637',
    projectId: 'chat-app-706a2',
    storageBucket: 'chat-app-706a2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3pQn4w5LUW2HhFJQvWfpOiDMSF74JZcA',
    appId: '1:1016272451637:ios:c165ea8769729a4f2e197c',
    messagingSenderId: '1016272451637',
    projectId: 'chat-app-706a2',
    storageBucket: 'chat-app-706a2.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3pQn4w5LUW2HhFJQvWfpOiDMSF74JZcA',
    appId: '1:1016272451637:ios:c165ea8769729a4f2e197c',
    messagingSenderId: '1016272451637',
    projectId: 'chat-app-706a2',
    storageBucket: 'chat-app-706a2.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOOZEiPBiLRjOOsB4OUjKZzPRVz7RY7vA',
    appId: '1:1016272451637:web:a35c0799d5fe1ac72e197c',
    messagingSenderId: '1016272451637',
    projectId: 'chat-app-706a2',
    authDomain: 'chat-app-706a2.firebaseapp.com',
    storageBucket: 'chat-app-706a2.firebasestorage.app',
    measurementId: 'G-KY48W8EXVE',
  );
}
