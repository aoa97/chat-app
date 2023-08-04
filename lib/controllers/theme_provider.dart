import 'package:chat/core/services/prefs_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final PrefsService _prefs;
  ThemeMode currentTheme = ThemeMode.system;

  ThemeProvider({required PrefsService prefs}) : _prefs = prefs {
    String? savedTheme = _prefs.get("theme");
    if (savedTheme != null) {
      currentTheme = savedTheme == "dark" ? ThemeMode.dark : ThemeMode.light;
    }
  }

  switchTheme() async {
    currentTheme = (currentTheme == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    await _prefs.save("theme", currentTheme.name);
    notifyListeners();
  }

  bool get isDark => currentTheme == ThemeMode.dark;
}
