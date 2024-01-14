import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/widgets/manageFaciltiesCard.dart';

class ManageFacilities extends StatelessWidget {
  const ManageFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Add Facility',
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          Navigator.pushNamed(context, '/addHospital');
        },
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: null,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                Text(
                  'Manage Facilities',
                  style: AppTextStyles.bodyOne.copyWith(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ManageFacilitiesCard(
              onTap: () {
                Navigator.pushNamed(context, '/editFacilities');
              },
              nameOfHospital: 'Central Park Hospital',
              locationOfHospital: 'London, UK',
            ),
            const SizedBox(
              height: 30,
            ),
            ManageFacilitiesCard(
              onTap: () {
                Navigator.pushNamed(context, '/editFacilities');
              },
              nameOfHospital: 'OakVille Hospital',
              locationOfHospital: 'Cape Town, South-Africa',
            ),
          ],
        ),
      )),
    );
  }
}
