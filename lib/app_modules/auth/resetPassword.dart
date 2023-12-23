import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mboacare/app_modules/auth/login.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(height: 100),
      Align(
        alignment: Alignment.topCenter,
        child: Image.asset(
          ImageAssets.logo,
          height: 120,
          width: 120,
        ),
      ),
      Text(
        'Enter your New Password',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyOne
            .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 25,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your New Password'),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Confirm Password'),
        ),
      ),
      SizedBox(
        height: 25,
      ),
      ElevatedButton(
        onPressed: () {
          //call the routing here
          // Navigator.pushNamed(context, '/resetPassword');
          Get.to(() => const LoginScreen(title: ''));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 26, 99, 32),
          foregroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(150, 45),
        ),
        child: const Text(
          'Proceed to Login',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ]));
  }
}
