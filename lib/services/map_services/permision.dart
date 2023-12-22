// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mapService.dart';

late Position currentPosition;
var geoLocator = Geolocator();

void locatePosition(BuildContext context) async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  currentPosition = position;
  LatLng latLatPosition = LatLng(position.latitude, position.longitude);
  CameraPosition cameraPosition =
      CameraPosition(target: latLatPosition, zoom: 14);

  String address = await MapServices.searchCordinates(position, context);              

  print('This is your::$address');
}
