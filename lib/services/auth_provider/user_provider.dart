

import 'package:flutter/foundation.dart';
import 'package:mboacare/model/user_model.dart';
import 'package:mboacare/services/appService.dart';

class UserProvider extends ChangeNotifier{
   UserModel? data;
  bool isHasData = false;

  getUserData() async {
    isHasData = true;
    data = (await ApiServices().getAccount());
    isHasData = false;
    notifyListeners();
  }
}