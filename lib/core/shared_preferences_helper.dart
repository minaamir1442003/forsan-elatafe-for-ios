import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences _prefs;
  static const String _hasSeenOnboarding = 'has_seen_onboarding';
  static const String _nationalId = 'national_id';
  static const String _hasSubmittedRequest = 'has_submitted_request';
  static const String _requestStatus = 'request_status';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Onboarding
  static Future<void> setHasSeenOnboarding(bool value) async {
    await _prefs.setBool(_hasSeenOnboarding, value);
  }

  static bool getHasSeenOnboarding() {
    return _prefs.getBool(_hasSeenOnboarding) ?? false;
  }

  // National ID
  static Future<void> saveNationalId(String id) async {
    await _prefs.setString(_nationalId, id);
  }

  static Future<String?> getNationalId() async {
    return _prefs.getString(_nationalId);
  }

  // Request submission status
  static Future<void> setHasSubmittedRequest(bool value) async {
    await _prefs.setBool(_hasSubmittedRequest, value);
  }

  static Future<bool> getHasSubmittedRequest() async {
    return _prefs.getBool(_hasSubmittedRequest) ?? false;
  }

  // Request status
  static Future<void> saveRequestStatus(String status) async {
    await _prefs.setString(_requestStatus, status);
  }

  static String? getSavedRequestStatus() {
    return _prefs.getString(_requestStatus);
  }

  // Clear all request data
  static Future<void> clearRequestData() async {
    await _prefs.remove(_nationalId);
    await _prefs.remove(_hasSubmittedRequest);
    await _prefs.remove(_requestStatus);
  }
}