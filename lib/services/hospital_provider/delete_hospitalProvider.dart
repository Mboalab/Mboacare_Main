// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mboacare/app_modules/auth/hospital_message/delete_success.dart';
import 'package:mboacare/services/apis.dart';
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';

class DeleteHospitalProvider extends ChangeNotifier {
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  void deleteHospital(
      {required String hospitalId, required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.deleteHospital;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response req = await http.delete(
      Uri.parse("$url$hospitalId"),
      headers: headers,
    );

    try {
      if (req.statusCode == 200 || req.statusCode == 201) {
        var res = json.decode(req.body);
        print(res);
        _isLoading = false;

        notifyListeners();
        snackMessage(message: res['message'], context: context);
        notifyListeners();
        Get.to(() => const DeleteHospitalSuccess(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.circularReveal);
        notifyListeners();
      }
    } catch (e) {
      var res = json.decode(req.body);
      print(res);
      _isLoading = false;

      notifyListeners();
      snackErrorMessage(message: res['message'], context: context);
      notifyListeners();
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
