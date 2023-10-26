import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
);

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.white,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;
  ThemeNotifier() {
    _darkTheme = false;
  }

  switchTheme() {
    _darkTheme = !_darkTheme;
  }
}
