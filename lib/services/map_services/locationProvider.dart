
import 'package:flutter/material.dart';

import '../../model/address.dart';

class LocationProvider extends ChangeNotifier {
    Address? searchLocation;
  void updateSearchLocationAddress(Address searchAddress) {
    searchLocation = searchAddress;
    notifyListeners();
  }

}