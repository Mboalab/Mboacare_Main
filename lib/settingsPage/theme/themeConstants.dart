import 'package:flutter/material.dart';
//import 'package:path/path.dart' as Path;
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeColors {
  static const Color background = Color.fromARGB(255, 32, 32, 32);
  static const Color cardBackground = Color.fromARGB(255, 221, 217, 217);
  static const Color primaryText = Color.fromARGB(255, 255, 255, 255);
  static const Color secondaryText = Color.fromARGB(255, 151, 144, 144);
  static const Color accentText = Color(0xFF009688);
  static const Color buttonBackground = Color(0xFF009688);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color divider = Color.fromARGB(255, 240, 234, 234);
  static const Color accentColor = Color(0xFF009688);
}

class ThemeProvider with ChangeNotifier {
  ThemeMode? _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode? get themeMode => _themeMode;

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final isDark = prefs.getBool('isDarkTheme') ?? false;
    // _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    // notifyListeners();
    final isDarkTheme = prefs.getBool('isDarkTheme');

    final Brightness systemBrightness = ui.window.platformBrightness;
    _themeMode = isDarkTheme == true
        ? ThemeMode.dark
        : isDarkTheme == false
            ? ThemeMode.light
            : systemBrightness == ui.Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light;
  }

  Future<void> toggleTheme(ThemeMode? selectedTheme) async {
    if (selectedTheme == ThemeMode.system) {
      // Set the theme based on system brightness
      final systemBrightness = ui.window.platformBrightness;
      _themeMode = systemBrightness == ui.Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      // Set the theme based on the selected option
      _themeMode = selectedTheme;
    }

    notifyListeners();

    if (selectedTheme != ThemeMode.system) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isDarkTheme', _themeMode == ThemeMode.dark);
    }
    // _themeMode =
    //     _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    // notifyListeners();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('isDarkTheme', _themeMode == ThemeMode.dark);
    // notifyListeners();
  }

  ThemeData getThemeData() {
    if (_themeMode == ThemeMode.dark) {
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: DarkThemeColors.background,
        cardColor: const Color.fromARGB(255, 245, 242, 242),
        primaryColor: DarkThemeColors.primaryText,
        //accentColor: DarkThemeColors.accentColor,
        //buttonColor: DarkThemeColors.buttonBackground,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: DarkThemeColors.primaryText,
          ),
          bodyMedium: TextStyle(
            color: DarkThemeColors.secondaryText,
          ),
        ),
      );
    } else {
      return ThemeData.light();
    }
  }
}
