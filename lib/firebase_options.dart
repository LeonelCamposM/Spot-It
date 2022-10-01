import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyD0-CGemBlANsMJBSJA0DShZg38_kqDFdw',
    appId: '1:157998617919:web:2324f64ee6c0c007d42f8a',
    messagingSenderId: '157998617919',
    projectId: 'unitconverter-30ca7',
    authDomain: 'unitconverter-30ca7.firebaseapp.com',
    storageBucket: 'unitconverter-30ca7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwltKXe11F8qt-qM2HQbQrnfQUQTxgQko',
    appId: '1:157998617919:android:23ef66df060087eed42f8a',
    messagingSenderId: '157998617919',
    projectId: 'unitconverter-30ca7',
    storageBucket: 'unitconverter-30ca7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDz1dY87eKzVXz4h0SHFVtlT9UOEnU_E4c',
    appId: '1:157998617919:ios:0b37fa6cb4417e4dd42f8a',
    messagingSenderId: '157998617919',
    projectId: 'unitconverter-30ca7',
    storageBucket: 'unitconverter-30ca7.appspot.com',
    iosClientId:
        '157998617919-ee40o527upbepgk6g6gf5dpen0bu1jq4.apps.googleusercontent.com',
    iosBundleId: 'com.example.unitConverter',
  );
}
