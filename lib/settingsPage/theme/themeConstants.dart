import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeColors {
  static const Color background = Color(0xFF121212);
  static const Color cardBackground = Color.fromARGB(255, 156, 151, 151);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color.fromARGB(255, 233, 223, 223);
  static const Color accentText = Color(0xFF009688);
  static const Color buttonBackground = Color(0xFF009688);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color divider = Color.fromARGB(255, 240, 234, 234);
  static const Color accentColor = Color(0xFF009688);
}

class ThemeProvider with ChangeNotifier {
  ThemeMode? _themeMode;
  //= ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode? get themeMode => _themeMode;

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    // final isDarkTheme = prefs.getBool('isDarkTheme');
    // final Brightness systemBrightness = ui.windows.PlatformBrightness;
    // _themeMode = isDarkTheme == true
    //     ? ThemeMode.dark
    //     : isDarkTheme == false
    //         ? ThemeMode.light
    //         : systemBrightness == ui.Brightness.dark
    //             ? ThemeMode.dark
    //             : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _themeMode == ThemeMode.dark);
    notifyListeners();
  }

  ThemeData getThemeData() {
    if (_themeMode == ThemeMode.dark) {
      return ThemeData.dark().copyWith(
        scaffoldBackgroundColor: DarkThemeColors.background,
        cardColor: DarkThemeColors.cardBackground,
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
