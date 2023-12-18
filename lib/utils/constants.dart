import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mboacare/global/styles/colors.dart';

import '../cache/sharedpreferences.dart';

///Global variables
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
final SharedPreference sharedPreference = SharedPreference();

class AppStrings {
  static String welcome ="Welcome back";
  static String remember ="Remember Me";
  static String sign ="Sign in";
  static String signUp ="Sign up";
  static String doNotHaveAccount ="Don't have an account? ";
  static String signInWithGoogle ="Sign in with Google";
  static String forgot ="Forgot password";
  static String enterPassword ="Enter your password";
  static String email ="Email *";
  static String back ="Back";
  static String information ="Hospital Information";
  static String password ="Password *";
  static String enterEmail ="Enter your email";
  static String details ="Welcome back! Please enter your details.";
  static String photoType ="SVG, PNG, JPG or GIF (max. 800x400px)";
  static String uploadImage ="Click to upload your hospital image";

}

class AppImages {
  static const String appLogo = "lib/assests/images/logo.png";
  static const String googleIcon = "lib/assests/images/google-icon.png";
  static const String checkIcon = "lib/assests/images/check_icon.svg";
  static const String emailIcon = "lib/assests/images/email_Icon.png";
  static const String Icon = "lib/assests/images/icon.svg";
  static const String markerPinIcon = "lib/assests/images/marker_pin.png";
  static const String arrowDown = "lib/assests/images/arrow_down.png";
  static const String uploadIcon = "lib/assests/images/upload_icon.png";
  static const String uncheckRingIcon = "lib/assests/images/uncheck_ring.png";
  static const String checkRingIcon = "lib/assests/images/check_ring.png";
  static const String closeIcon = "lib/assests/images/close.svg";
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
  static double fontSize6 = 6.0;
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


