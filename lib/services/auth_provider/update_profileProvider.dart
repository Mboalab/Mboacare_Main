// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mboacare/app_modules/auth/auth_messages/update_success.dart';
import 'package:mboacare/services/apis.dart';
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileProvider extends ChangeNotifier {
  // final auth = FirebaseAuth.instance;
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final profileFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String _reqMessage = "";
  bool _isLoading = false;
  String phone = '';

  String user_name = '';
  String user_phone = '';

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;
  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void clearInput() {
    phoneController.clear();
    nameController.clear();
  }

  void updateProfile(
      String phone, String name, File? image, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences pref = await _pref;
    String id = pref.getString('uid') ?? '';
    print(id);
    user_name = pref.getString('name') ?? "";
    user_phone = pref.getString('phone') ?? "";
    print(user_name);
    final url = Uri.parse(Apis.updateProfile);
    print(url);
    final request = http.MultipartRequest('PUT', url);

    request.fields['phone'] = phone;
    request.fields['name'] = name;
    request.fields['id'] = id;

    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', image.path));
    }

    final response = await request.send();
    print(phone);
    print(name);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        snackMessage(message: "Profile Updated Successful!", context: context);
        pref.setString('name', name);
        pref.setString('phone', phone);
        pref.commit();
        Get.to(() => const UpdateProfileSuccess(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
        clearInput();
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        const errorMessage = 'failed to update profile! Image is required!';
        snackErrorMessage(message: errorMessage, context: context);
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      final errorMessage = 'Error in updating profile: $e';
      snackErrorMessage(message: errorMessage, context: context);
      notifyListeners();
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
