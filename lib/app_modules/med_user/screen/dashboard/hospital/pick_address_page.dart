import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/placemodel/geometry_model.dart';
import 'package:mboacare/services/facilities_provider.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/map_screen.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/search_facilties_page.dart';
import 'package:provider/provider.dart';

class PickAddressPage extends StatefulWidget {
  const PickAddressPage({super.key});

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  @override
  void initState() {
    super.initState();
    final facilitiesProvider =
        Provider.of<FacilitiesProvider>(context, listen: false);
    // facilitiesProvider.getPlace(query: 'Dubai');
  }

  final placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final facilitiesProvider = Provider.of<FacilitiesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: const Text(
          'Hospital address',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                facilitiesProvider.getPlace(query: value);
                // placeController.text = value;
              },
              // onTap: () {
              //   if (placeController.text.isEmpty) {
              //     placeController.text =
              //         _previousQuery; // Restore previous query on click
              //   }
              // },
              controller: placeController,
              decoration: const InputDecoration(
                hintText: 'Search location.......',
                hintStyle: TextStyle(color: AppColors.grey300),
                contentPadding: EdgeInsets.only(left: 40),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                // facilitiesProvider.getPlace(query: 'Dubai');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SearchFacilitiesPage()));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchFacilitiesPage(
                              geometryModel: GeometryModel(),
                            )));
              },
              child: Row(
                children: [
                  SvgPicture.asset('lib/assests/icons/location_search.svg'),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'Choose current location',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey300),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: facilitiesProvider.place.length,
                  itemBuilder: (context, index) {
                    // facilitiesProvider.getGeometry(
                    //     placeId: 'ChIJYa1Q9z-5woAR2EuC6RcSFZ8');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapSample(
                                        // geometryModel: facilitiesProvider
                                        //     .geometry[index]
                                        )));
                          },
                          child: Text(
                              facilitiesProvider.place[index].description ??
                                  '')),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
