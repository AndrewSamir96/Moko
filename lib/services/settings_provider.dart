import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moko/themes/dark_mode.dart';
import 'package:moko/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  //Theme Data
  ThemeData _currTheme = lightMode;
  //Opened screen for the first time
  bool _isFirstTime = true;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //GETTERS
  ThemeData get currTheme => _currTheme;
  bool get isDarkMode => _currTheme == darkMode;
  bool get isFirstTime => _isFirstTime;

  //SETTERS
  set currTheme(ThemeData theme) {
    _currTheme = theme;
    notifyListeners();
  }

  //Functions
  //Get Settings from shared Prefs
  void getSettings() async {
    final SharedPreferences prefs = await _prefs;
    //theme Settings
    _isFirstTime = prefs.getBool('seen') ?? false;
    var theme = prefs.getString('theme');
    if (theme == 'dark') {
      _currTheme = darkMode;
    } else if (theme == 'light') {
      _currTheme = lightMode;
    } else {
      await prefs.setString('theme', 'light');
    }
    notifyListeners();
    FlutterNativeSplash.remove();
  }

  //Toggles the theme
  void toggleTheme() async {
    final SharedPreferences prefs = await _prefs;
    if (_currTheme == lightMode) {
      _currTheme = darkMode;
      await prefs.setString('theme', 'dark');
    } else {
      _currTheme = lightMode;
      await prefs.setString('theme', 'light');
    }
    notifyListeners();
  }
  //finished
}
