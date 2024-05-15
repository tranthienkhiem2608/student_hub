import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  DarkModeProvider({required bool isDarkMode}) : _isDarkMode = isDarkMode;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarkMode', isDarkMode);
      print(prefs.getBool('isDarkMode'));
    });
    notifyListeners();
  }
}