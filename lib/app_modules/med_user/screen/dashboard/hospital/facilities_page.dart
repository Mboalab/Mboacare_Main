import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/facilities_provider.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/add_facilities_page.dart';
import 'package:mboacare/widgets/facilities_widget.dart';
import 'package:provider/provider.dart';

class FacilitiesPage extends StatefulWidget {
  const FacilitiesPage({super.key});

  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  // @override
  // void initState() {
  //   Provider.of<FacilitiesProvider>(context, listen: false).getFacilities();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final facilitiesProvider = Provider.of<FacilitiesProvider>(context);
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                
                  itemCount: facilitiesProvider.facilities.length,
                  itemBuilder: (context, index) {
                    return FacilitiesWidget(
                      facilitiesModel: facilitiesProvider.facilities[index],
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddFacilitiesPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(350, 50),
              ),
              child: const Text(
                'ADD A FACILITY',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ));
  }
}
