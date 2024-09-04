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
    apiKey: 'AIzaSyCJ16FsxOXeGq4Isgx4eUslRcDT-laAdWc',
    appId: '1:442222561921:web:4835db76e9bb2afa9adb80',
    messagingSenderId: '442222561921',
    projectId: 'waving-164fa',
    authDomain: 'waving-164fa.firebaseapp.com',
    storageBucket: 'waving-164fa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5pZLGeTXSbtLPvUc2TUQfKZnWArt0qx4',
    appId: '1:442222561921:android:bd59878038d16e359adb80',
    messagingSenderId: '442222561921',
    projectId: 'waving-164fa',
    storageBucket: 'waving-164fa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFnEXW2vNctv0n0Ux12vKIp-Zit9BHvXo',
    appId: '1:442222561921:ios:ec9ff0bf071c880e9adb80',
    messagingSenderId: '442222561921',
    projectId: 'waving-164fa',
    storageBucket: 'waving-164fa.appspot.com',
    iosBundleId: 'com.example.bookWave',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFnEXW2vNctv0n0Ux12vKIp-Zit9BHvXo',
    appId: '1:442222561921:ios:ec9ff0bf071c880e9adb80',
    messagingSenderId: '442222561921',
    projectId: 'waving-164fa',
    storageBucket: 'waving-164fa.appspot.com',
    iosBundleId: 'com.example.bookWave',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJ16FsxOXeGq4Isgx4eUslRcDT-laAdWc',
    appId: '1:442222561921:web:c672676ef4a1d7379adb80',
    messagingSenderId: '442222561921',
    projectId: 'waving-164fa',
    authDomain: 'waving-164fa.firebaseapp.com',
    storageBucket: 'waving-164fa.appspot.com',
  );
}
