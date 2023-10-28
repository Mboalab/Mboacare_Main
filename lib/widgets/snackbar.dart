import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';
import '../utils/constants.dart';

final ScaffoldMessengerState?  scaffoldMessengerState = scaffoldKey.currentState;

SnackBar showSuccessSnackBar(String message) {
  return SnackBar(
    backgroundColor: AppColors.primaryColor,
    content: Text(
        message,
      style: GoogleFonts.inter(
          color: Colors.white,
        fontSize: AppFontSizes.fontSize12
      ),
    ),
  );
}

SnackBar showErrorSnackBar(String message) {
  return SnackBar(
    backgroundColor: AppColors.redColor,
    content: Text(
      message,
      style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: AppFontSizes.fontSize12
      ),
    ),
  );
}

void showMessage({bool? isError, String? message}) {
  scaffoldMessengerState?.showSnackBar(
      isError == true ? showErrorSnackBar(
          message.toString())
  : showSuccessSnackBar(
          message.toString()));
}