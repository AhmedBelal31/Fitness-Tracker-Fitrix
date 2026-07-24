import 'package:shared_preferences/shared_preferences.dart';

class CelebrationPrefs {
  static const String _celebrationDisabledKey = 'celebration_disabled';

  static Future<bool> isCelebrationDisabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_celebrationDisabledKey) ?? false;
  }

  static Future<void> setCelebrationDisabled(bool disabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_celebrationDisabledKey, disabled);
  }
}
