// File generated from Firebase project forsan-elatafe.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYg059xYCEx_C1wstYgwawAHGwWL2OmQw',
    appId: '1:738414708293:android:6d4cd894b14452f553c52c',
    messagingSenderId: '738414708293',
    projectId: 'forsan-elatafe',
    storageBucket: 'forsan-elatafe.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoWkRN5wDw8MMdKk5WTK-zLuqviFs0OAM',
    appId: '1:738414708293:ios:1dc1406d9871751353c52c',
    messagingSenderId: '738414708293',
    projectId: 'forsan-elatafe',
    storageBucket: 'forsan-elatafe.firebasestorage.app',
    iosBundleId: 'com.example.forsanEltafe',
  );
  /// Returns true when placeholder values have not been replaced yet.
  static bool get isPlaceholder => false;
}
