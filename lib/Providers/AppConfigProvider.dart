import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  // Theme
  ThemeMode themeMode = ThemeMode.dark;

  bool isDarkModeEnabled() {
    return themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  // Localization
  String locale = 'en';

  void changeLocale(String newLocale) {
    if (newLocale == locale) {
      return;
    }
    locale = newLocale;
    notifyListeners();
  }

  void saveLocalization(String newLocale) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', newLocale);
  }
}
