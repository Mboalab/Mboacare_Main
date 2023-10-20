import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mboacare/colors.dart';

class AppStrings {}

class AppImages {
  static const String appLogo = "lib/assests/images/logo.png";
  static const String googleIcon = "lib/assests/images/google-icon.png";
  static const String checkIcon = "lib/assests/images/check_icon.svg";
}

class AppFontSizes {
  static double fontSize125 = 125.0;
  static double fontSize64 = 64.0;
  static double fontSize40 = 40.0;
  static double fontSize32 = 32.0;
  static double fontSize30 = 30.0;
  static double fontSize24 = 24.0;
  static double fontSize22 = 22.0;
  static double fontSize20 = 20.0;
  static double fontSize18 = 18.0;
  static double fontSize16 = 16.0;
  static double fontSize15 = 15.0;
  static double fontSize14 = 14.0;
  static double fontSize12 = 12.0;
  static double fontSize10 = 10.0;
  static double fontSize8 = 8.0;
  static double fontSize4 = 4.0;
  static double fontSize3 = 3.0;
  static double fontSize1 = 1.0;
}

final currentUserID = FirebaseAuth.instance.currentUser!.uid;

TextStyle largeTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isLightTheme = theme.brightness == Brightness.light;

  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: isLightTheme ? Colors.black : Colors.white,
  );
}

TextStyle mediumTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isLightTheme = theme.brightness == Brightness.light;

  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: isLightTheme ? Colors.black : Colors.white,
  );
}

TextStyle smallTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isLightTheme = theme.brightness == Brightness.light;

  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: isLightTheme ? Colors.black : Colors.white,
  );
}

TextStyle xSmallTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isLightTheme = theme.brightness == Brightness.light;

  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: isLightTheme ? const Color(0xFF767D88) : const Color(0xFF767D88),
  );
}

TextStyle hintTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isLightTheme = theme.brightness == Brightness.light;

  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: isLightTheme ? const Color(0xFF767D88) : const Color(0xFF767D88),
  );
}

TextStyle inputTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isLightTheme = theme.brightness == Brightness.light;

  return TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: isLightTheme ? Colors.black : Colors.white,
  );
}

TextStyle dialogActionButtonTextStyle() {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );
}
