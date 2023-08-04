import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? get(String key) {
    return _prefs!.getString(key);
  }

  Future save(String key, String value) async {
    await _prefs!.setString(key, value);
  }
}
