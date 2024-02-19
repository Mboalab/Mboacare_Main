import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/edit_facilities_page.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/settings.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/hospital_model/hospital_model.dart';
import 'package:mboacare/services/appService.dart';
import 'package:mboacare/utils/router.dart';
import 'package:mboacare/widgets/manageFaciltiesCard.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/add_hopital.dart';
import 'package:mboacare/widgets/manage_card.dart';

class ManageFacilities extends StatelessWidget {
  const ManageFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0.0,
        title: Text(
          'Manage Hospitals',
          style: GoogleFonts.inter(
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            PageNavigator(ctx: context).nextPageOnly(page: const Settings());
            // Get.to(() => const Settings(),
            //     duration: const Duration(
            //       milliseconds: 800,
            //     ),
            //     curve: Curves.easeInCirc,
            //     transition: Transition.fadeIn);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.secondaryTextColor,
            size: 25.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Facility',
        backgroundColor: AppColors.buttonColor,
        onPressed: () {
          Get.to(() => AddHospitalPage(
                placeName: '',
                lat: 0.0,
                lng: 0.0,
              ));
        },
        child: const Icon(
          Icons.add,
          size: 24,
          color: AppColors.whiteColor,
        ),
      ),
      body: FutureBuilder<List<HospitalModel>>(
          future: ApiServices().myHospitalData(context: context),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: AppColors.cardbg,
                    ),
                    Text(
                      'Loading My Hospital....',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Hospital Available!',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Text(
                'No Internet Connection!',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                ),
              );
            }
            final data = snapshot.data;
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: false,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: data?.length,
                itemBuilder: (context, index) {
                  final hospital = data![index];

                  return ManageCard(
                    onCardTap: () {},
                    imagePath: hospital.hospitalImage.toString(),
                    blogTitle: hospital.name.toString(),
                    blogTime: hospital.placeAddress.toString(),
                    onPressedStackCardButton: () {
                      Get.to(
                          () => EditFacilitiesPage(
                              id: hospital.id,
                              name: hospital.name,
                              email: hospital.email,
                              hospitalAddress: hospital.placeAddress,
                              hospitalFacilities:
                                  hospital.facilitiesType?.join(','),
                              hospitalOwner: hospital.hospitalOwner,
                              hospitalServices: hospital.serviceType?.join(','),
                              image: hospital.hospitalImage,
                              hospitalSize: hospital.hospitalSize,
                              hospitalType: hospital.hospitalType,
                              lat: hospital.latitude.toString(),
                              lng: hospital.longitude.toString()),
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          curve: Curves.easeIn,
                          transition: Transition.fade);
                    },
                  );
                });
          })),
    );
  }
}

// SafeArea(
//           child: SingleChildScrollView(
//         physics: null,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Get.to(() => const Settings());
//                     },
//                     icon: Icon(Icons.arrow_back)),
//                 Text(
//                   'Manage Facilities',
//                   style: AppTextStyles.bodyOne.copyWith(fontSize: 18),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ManageFacilitiesCard(
//               onTap: () {
//                 Navigator.pushNamed(context, '/editFacilities');
//               },
//               nameOfHospital: 'Central Park Hospital',
//               locationOfHospital: 'London, UK',
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             ManageFacilitiesCard(
//               onTap: () {
//                 Navigator.pushNamed(context, '/editFacilities');
//               },
//               nameOfHospital: 'OakVille Hospital',
//               locationOfHospital: 'Cape Town, South-Africa',
//             ),
//           ],
//         ),
//       )),