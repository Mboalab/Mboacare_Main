import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/placemodel/facilities_model.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/edit_facilities_page.dart';

class FacilitiesWidget extends StatelessWidget {
  final FacilitiesModel facilitiesModel;
  const FacilitiesWidget({
    super.key,
    required this.facilitiesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(15.0),
            height: MediaQuery.sizeOf(context).height * .32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              // elevation: 1,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(16.0),
              // ),
              color: Colors.white,
              child: Column(children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * .18,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                facilitiesModel.name ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(facilitiesModel.website ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                              Text(
                                facilitiesModel.name ?? '',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                facilitiesModel.latitude ?? '',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey),
                              )
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditFacilitiesPage(
                                            facilitiesModel: facilitiesModel,
                                          )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              foregroundColor: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: const Size(100, 30),
                            ),
                            child: const Text(
                              'EDIT',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ]),
            )),
      ],
    );
  }
}
