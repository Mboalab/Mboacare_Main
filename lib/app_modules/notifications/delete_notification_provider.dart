import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'dart:convert';

import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:mboacare/app_modules/med_user/med_dashboard.dart';
import 'package:mboacare/app_modules/notifications/notification_deleted.dart';
import 'package:mboacare/app_modules/notifications/notifications_page.dart';
import 'package:mboacare/global/styles/colors.dart';

import 'package:mboacare/services/apis.dart';
import 'package:mboacare/utils/snack_succ.dart';

class DeleteNotificationProvider extends ChangeNotifier {
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  void deleteTheNotification(
      {required String notificationId, required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.deleteNotification;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response req = await http.delete(
      Uri.parse("$url$notificationId"),
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
        Get.to(() => const DeleteNotificationSuccessful(),
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

void snackErrorMessage(
    {required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: AppColors.whiteColor,
      ),
    ),
    backgroundColor: AppColors.redColor,
  ));
  void snackMessage({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
      backgroundColor: AppColors.primaryColor,
    ));
  }
}
