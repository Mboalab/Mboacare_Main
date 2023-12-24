import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mboacare/app_modules/auth/login.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';

class CheckMailScreen extends StatelessWidget {
  const CheckMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 150),
      Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          ImageAssets.checkedRing,
          height: 120,
          width: 120,
        ),
      ),
      Text(
        'Check your Mail ',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyOne
            .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 16,
      ),
      Text(
        'A reset password link has been sent to you.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyFour
            .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    ]));
  }
}
