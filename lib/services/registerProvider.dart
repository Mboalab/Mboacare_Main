import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare/services/apis.dart';
import 'package:http/http.dart' as http;

import '../app_modules/auth/login.dart';

class RegisterProvider extends ChangeNotifier {
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  void register({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.register;
    print(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    final body = {"email": email, "password": password};
    print(body);
    http.Response req = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    try {
      if (req.statusCode == 200 || req.statusCode == 201) {
        var res = json.decode(req.body);
        print(res);
        _isLoading = false;
        _reqMessage = res['message'];
        notifyListeners();
        Get.to(
            () => const LoginScreen(
                  title: '',
                ),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
      }
    } catch (e) {
      var res = json.decode(req.body);
      print(res);
      _isLoading = false;
      _reqMessage = res['message'];
      notifyListeners();
      log(e.toString());
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
