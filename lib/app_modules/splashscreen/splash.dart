import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../global/styles/assets_string.dart';
import '../../global/styles/colors.dart';
import '../user/user_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Replace with your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCube(
              color: AppColors
                  .primaryColor, // Replace with your desired spinner color
              size:
                  50.0, // Adjust the size of the spinner as per your requirements
            ),
            const SizedBox(height: 16.0),
            Image.asset(
              ImageAssets.logo, // Replace with your own image path
              width: 130, // Adjust the width as per your requirements
              height: 130, // Adjust the height as per your requirements
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Mboacare',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Your Health, Simplified!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(
        () => DashboardScreen(
          userName: 'Mboacare',
        ),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeIn,
        transition: Transition.fadeIn,
      );
    });
  }
}
