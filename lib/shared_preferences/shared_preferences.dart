import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String nicknameKey = 'nickname';
  static const String dayKey = 'day';
  static const String monthKey = 'month';
  static const String yearKey = 'year';
  static const String isAppUnlockedKey = 'isAppUnlocked';

  // Save nickname
  static Future<void> saveNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(nicknameKey, nickname);
  }

  // Get nickname
  static Future<String?> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(nicknameKey);
  }

  // Set app unlock status
  static Future<void> setIsAppUnlocked(bool isUnlocked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isAppUnlockedKey, isUnlocked);
  }

  // Get app unlock status
  static Future<bool> getIsAppUnlocked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isAppUnlockedKey) ?? false;
  }

  // Save date (day, month, year)
  static Future<void> saveDate(String day, String month, String year) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dayKey, day);
    await prefs.setString(monthKey, month);
    await prefs.setString(yearKey, year);
  }

  // Get date
  static Future<Map<String, String?>> getDate() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'day': prefs.getString(dayKey),
      'month': prefs.getString(monthKey),
      'year': prefs.getString(yearKey),
    };
  }
}
