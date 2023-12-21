import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/add_hopital.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/placepredicts.dart';
import 'package:mboacare/services/apis.dart';
import 'package:mboacare/services/map_services/locationProvider.dart';
import 'package:mboacare/services/map_services/mapService.dart';
import 'package:mboacare/services/map_services/searchSelection.dart';
import 'package:provider/provider.dart';

class SearchAddress extends StatefulWidget {
  const SearchAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  TextEditingController searchController = TextEditingController();

  List<PlacePredictions> placePredictionsList = [];

  List<PlacePredictions> searchPredictionsList = [];

  @override
  Widget build(BuildContext context) {
    String placeName =
        Provider.of<LocationProvider>(context).searchLocation?.placeName ?? "";
    double searchLat =
        Provider.of<LocationProvider>(context).searchLocation?.latitude ?? 0.0;
    double searchLng =
        Provider.of<LocationProvider>(context).searchLocation?.longitude ?? 0.0;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: AppColors.grey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => AddHospitalPage(
                  placeName: placeName,
                ));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Hospital Address'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  searchAddress(value);
                },
                controller: searchController,
                obscureText: false,
                maxLines: 1,
                cursorColor: AppColors.primaryColor,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  suffixIconColor: AppColors.primaryColor,
                  hintText: 'Search location.......',
                  hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                  //filled: true,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              Positioned(
                  top: height * 0.07,
                  left: 0,
                  right: 0,
                  child: Text('Hospital Location is: $placeName')),
              SizedBox(height: height * 2),
              Positioned(
                top: height * 0.07,
                left: 0,
                right: 0,
                child: searchPredictionsList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          elevation: 2,
                          color: AppColors.whiteColor,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(0.0),
                            itemBuilder: (context, index) {
                              return SearchTile(
                                  predictions: searchPredictionsList[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemCount: searchPredictionsList.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchAddress(String searchPlace) async {
    if (searchPlace.length > 1) {
      String autoCompleteUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchPlace&key=$mapKey&sessiontoken=1234567890&components=country:CM';
      var res = await MapServices.getRequest(autoCompleteUrl);

      if (res == 'failed') {
        return;
      } else {
        if (res['status'] == 'OK') {
          var predictions = res['predictions'];
          var placeList = (predictions as List)
              .map((e) => PlacePredictions.fromJson(e))
              .toList();
          searchPredictionsList = placeList;

          //setState(() {});
        }
      }
    }
  }
}
