import 'package:flutter/material.dart';

import '../global/styles/colors.dart';


void snackMessage({required String message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: AppColors.whiteColor,
      ),
    ),
    backgroundColor: AppColors.danger,
  ));
}