import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // is user logged in key
  static const String isUserLoggedInKay = 'isUserLoggedIn';

  // set user logged in
  static Future<void> setIsUserLoggedIn() async {
    await _prefs!.setBool(isUserLoggedInKay, true);
  }

  // get user logged in
  static bool getIsUserLoggedIn() {
    return _prefs!.getBool(isUserLoggedInKay) ?? false;
  }
}
