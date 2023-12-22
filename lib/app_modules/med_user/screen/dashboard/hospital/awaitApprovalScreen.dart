import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';

class AwaitApprovalScreen extends StatelessWidget {
  const AwaitApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImageAssets.checkedRing,
              height: 150,
              width: 150,
            ),
          ),
          Text(
            'Hospital details submitted successfully.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyOne
                .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Your hospital is under review, you will receive an email on your Application Status',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyFour
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              //call the routing here
              Navigator.pushNamed(context, '/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(150, 45),
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
