import 'package:geolocator/geolocator.dart';
import 'package:mboacare/model/address.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../apis.dart';

class MapServices {
  
   static Future<String> searchCordinates(Position position, context) async {
    String placeAddress = '';
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    var res = await getRequest(url);

    if (res != 'failed') {
      placeAddress = res['results'][0]['formatted_address'];
      Address searchAddress = Address(placeName: placeAddress);
      searchAddress.longitude = position.longitude;
      searchAddress.latitude = position.latitude;
      searchAddress.placeName = placeAddress;

      // Provider.of<AppDataProvider>(context, listen: false)
      //     .updatePickupLocationAddress(userPickupAddress);
      // print(userPickupAddress.latitude);
      // print(userPickupAddress.longitude);
    }

    return placeAddress;
  }

   static Future<dynamic>getRequest(String url) async {
    http.Response req = await http.get(Uri.parse(url));
    try {
      if(req.statusCode == 200 || req.statusCode == 201) {
      final res = json.decode(req.body);
      print(res);
      return res;
    }
    else{
      return "failed";
    }
    } catch (e) {
      return "failed";
    }
  }
}