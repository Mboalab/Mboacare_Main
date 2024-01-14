import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/colors.dart';

class ManageFacilitiesCard extends StatelessWidget {
  final String nameOfHospital;
  final String locationOfHospital;
  BuildContext? Function() onTap;
  ManageFacilitiesCard(
      {required this.nameOfHospital,
      required this.locationOfHospital,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            image: DecorationImage(
              image: AssetImage('assets/images/facilitiesImage.png'),
            ),
          ),
          height: 135,
          width: size.height * 0.5,
        ),
        Container(
          decoration: const BoxDecoration(
              color: AppColors.navbarColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14))),
          width: size.height * 0.45,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(nameOfHospital,
                        style: AppTextStyles.bodyOne.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(locationOfHospital,
                        style: AppTextStyles.bodyOne.copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(80, 30),
                  ),
                  child: const Text(
                    'EDIT',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
