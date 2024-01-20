import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/manageFacilities.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';

class UpdateHospitalSuccess extends StatelessWidget {
  const UpdateHospitalSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.25,
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
            'Hospital Updated successfully!.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyOne
                .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Kindly Check your email for account Hospital status!!',
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
              Get.to(() => const ManageFacilities());
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
              'Manage Hospital',
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
