import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  switchTheme() {
    currentTheme = (currentTheme == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool get isDark => currentTheme == ThemeMode.dark;
}
