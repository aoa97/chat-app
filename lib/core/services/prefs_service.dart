import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsProvider = Provider((ref) => PrefsService());

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
