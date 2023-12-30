// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/auth/checkMail.dart';
import 'package:mboacare/services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:mboacare/utils/validations.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;
  final emailController = TextEditingController();
  bool isValidSignIn = false;
  String email = "";

setEmail(String value) {
    email = value;
    notifyListeners();
  }
  void validSignIn() {
    final isValidEmail = isValidEmails(email.trim());
    isValidSignIn = isValidEmail;
    notifyListeners();
  }

  void resetPassword(
      {
     required BuildContext context,
      required String email}) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.resetPassword;
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    final body = {"email": email};
    print(body);

    http.Response req = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    try {
      if (req.statusCode == 200 || req.statusCode == 201) {
        var res = json.decode(req.body);
        print(res);
        _isLoading = false;
        // _reqMessage = res['message'];
        snackMessage(context: context, message: res['message']);
        notifyListeners();
        Get.to(() => const CheckMailScreen(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
      }
    } catch (e) {
      var res = json.decode(req.body);
      _isLoading = false;
      // _reqMessage = res['message'];
      snackErrorMessage(message: res['message'], context: context);
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
