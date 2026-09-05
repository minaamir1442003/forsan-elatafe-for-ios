import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:forsan_eltafe/firebase_options.dart';

/// Central analytics facade. All screens and cubits call this — never Firebase/Meta directly.
class AnalyticsService {
  AnalyticsService._();

  static final AnalyticsService instance = AnalyticsService._();

  static FirebaseAnalytics? _firebase;
  static FacebookAppEvents? _meta;
  static bool _firebaseReady = false;
  static bool _metaReady = false;
  static bool _trackingRequested = false;

  static bool get isFirebaseReady => _firebaseReady;
  static bool get isMetaReady => _metaReady;

  /// Initialize Firebase and Meta SDKs. Safe to call with placeholder config.
  static Future<void> init() async {
    await _initFirebase();
    _initMeta();
  }

  static Future<void> _initFirebase() async {
    if (DefaultFirebaseOptions.isPlaceholder) {
      if (kDebugMode) {
        debugPrint(
          '[AnalyticsService] Firebase skipped — replace placeholder firebase_options.dart '
          '(run: flutterfire configure)',
        );
      }
      return;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _firebase = FirebaseAnalytics.instance;
      _firebaseReady = true;
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Firebase Analytics initialized');
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Firebase init failed: $e\n$st');
      }
    }
  }

  static void _initMeta() {
    try {
      _meta = FacebookAppEvents();
      // Android has no ATT prompt; enable advertiser ID collection explicitly
      // (iOS is handled by ATT in requestTrackingIfNeeded).
      if (Platform.isAndroid) {
        _meta!.setAdvertiserTracking(enabled: true, collectId: true);
      }
      _metaReady = true;
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Meta App Events initialized');
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Meta init failed: $e\n$st');
      }
    }
  }

  /// Request ATT on iOS after the first frame is visible. No-op on Android.
  static Future<void> requestTrackingIfNeeded() async {
    if (_trackingRequested || !Platform.isIOS || !_metaReady) return;
    _trackingRequested = true;

    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      TrackingStatus finalStatus = status;

      if (status == TrackingStatus.notDetermined) {
        finalStatus =
            await AppTrackingTransparency.requestTrackingAuthorization();
      }

      final granted = finalStatus == TrackingStatus.authorized;
      await _meta?.setAdvertiserTracking(enabled: granted);

      if (kDebugMode) {
        debugPrint(
          '[AnalyticsService] ATT status: $finalStatus, idCollection: $granted',
        );
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AnalyticsService] ATT request failed: $e\n$st');
      }
    }
  }

  /// Sign-up request submitted successfully.
  static Future<void> logSignUpRequest() =>
      instance._logSignUpRequest();

  Future<void> _logSignUpRequest() async {
    await _logFirebase(
      'sign_up_request_submitted',
      null,
    );
    await _logMetaCompletedRegistration();
  }

  Future<void> _logMetaCompletedRegistration() async {
    if (!_metaReady || _meta == null) return;

    try {
      await _meta!.logCompletedRegistration(registrationMethod: 'request_form');
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Meta: CompleteRegistration');
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Meta log failed (CompleteRegistration): $e\n$st');
      }
    }
  }

  /// Family login succeeded.
  static Future<void> logLogin() => instance._logLogin();

  Future<void> _logLogin() async {
    await _logFirebase('login', {'method': 'family_account'});
    await _logMeta(eventName: 'login', parameters: const {'method': 'family_account'});
  }

  /// Contact button tapped. [method] must be `whatsapp` or `phone`.
  static Future<void> logContactClick({required String method}) =>
      instance._logContactClick(method: method);

  Future<void> _logContactClick({required String method}) async {
    await _logFirebase('contact_click', {'method': method});
    await _logMeta(
      eventName: 'Contact',
      parameters: {'method': method},
    );
  }

  /// Tab/section opened. [section] must be `resort` or `medical_unit`.
  static Future<void> logContentView({required String section}) =>
      instance._logContentView(section: section);

  Future<void> _logContentView({required String section}) async {
    await _logFirebase('content_view', {'section': section});
    await _logMeta(
      eventName: FacebookAppEvents.eventNameViewedContent,
      parameters: {'content_type': section},
    );
  }

  Future<void> _logFirebase(
    String name,
    Map<String, Object>? parameters,
  ) async {
    if (!_firebaseReady || _firebase == null) return;

    try {
      await _firebase!.logEvent(name: name, parameters: parameters);
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Firebase: $name $parameters');
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Firebase log failed ($name): $e\n$st');
      }
    }
  }

  Future<void> _logMeta({
    required String eventName,
    Map<String, dynamic>? parameters,
  }) async {
    if (!_metaReady || _meta == null) return;

    try {
      await _meta!.logEvent(name: eventName, parameters: parameters);
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Meta: $eventName $parameters');
      }
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[AnalyticsService] Meta log failed ($eventName): $e\n$st');
      }
    }
  }
}
