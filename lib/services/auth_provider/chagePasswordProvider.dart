// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/auth/auth_messages/change_password.dart';
import 'package:mboacare/app_modules/auth/auth_messages/checkMail.dart';
import 'package:mboacare/services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:mboacare/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordProvider extends ChangeNotifier {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final changePasswordFormKey = GlobalKey<FormState>();
  String _reqMessage = "";
  bool _isLoading = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isNewPasswordVisible => _isNewPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String userEmail = '';
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

  void toggleNewPasswordVisibility() {
    _isNewPasswordVisible = !_isNewPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void changePassword({
    required BuildContext context,
    required String u_email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences pref = await _pref;
    String id = pref.getString('uid') ?? '';
    userEmail = pref.getString('userEmail') ?? "";
    String url = Apis.changePassword;
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    final body = {"uid": id, "new_password": password, "email": u_email};
    print(body);
    if (u_email.toString() != userEmail) {
      _isLoading = false;
      notifyListeners();
      snackErrorMessage(
          message: 'Email provided do not match!', context: context);
      notifyListeners();
    } else {
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      try {
        if (req.statusCode == 200 || req.statusCode == 201) {
          var res = json.decode(req.body);
          print(res);
          _isLoading = false;
          notifyListeners();
          // _reqMessage = res['message'];
          snackMessage(context: context, message: res['message']);
          notifyListeners();
          Get.to(() => const ChangePasswordSuccess(),
              duration: const Duration(
                milliseconds: 800,
              ),
              curve: Curves.easeInCirc,
              transition: Transition.fadeIn);
          notifyListeners();
        }
      } catch (e) {
        var res = json.decode(req.body);
        _isLoading = false;
        notifyListeners();

        snackErrorMessage(message: res['message'], context: context);
        notifyListeners();
      }
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
