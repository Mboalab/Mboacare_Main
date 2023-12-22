import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/add_hopital.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/search_address.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/address.dart';
import 'package:mboacare/model/placepredicts.dart';
import 'package:mboacare/services/apis.dart';
import 'package:mboacare/services/map_services/mapService.dart';
import 'package:provider/provider.dart';

import 'locationProvider.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({Key? key, required this.predictions}) : super(key: key);
  final PlacePredictions predictions;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getPlaceDetails(predictions.place_id.toString(), context);
      },
      child: Column(
        children: [
          const SizedBox(
            width: 8,
          ),
          Row(
            children: [
              const Icon(
                Icons.add_location,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      predictions.main_text.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      predictions.secondary_text.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }

  void getPlaceDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SpinKitThreeBounce(
            color: AppColors.primaryColor,
          );
        });
    String getPlaceDetailUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey';

    var req = await MapServices.getRequest(getPlaceDetailUrl);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SearchAddress()));
    if (req == 'failed') {
      return;
    } else {
      if (req['status'] == 'OK') {
        Address address = Address();
        address.placeName = req['result']['name'];
        address.placeId = placeId;
        address.latitude = req['result']['geometry']['location']['lat'];
        address.longitude = req['result']['geometry']['location']['lng'];

        Provider.of<LocationProvider>(context, listen: false)
            .updateSearchLocationAddress(address);
      }
    }
  }
}
