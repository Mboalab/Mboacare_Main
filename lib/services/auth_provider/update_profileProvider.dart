// ignore_for_file: use_build_context_synchronously

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
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final profileFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

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

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        snackMessage(message: "Blog Added Successful!", context: context);
        Get.to(() => const UpdateProfileSuccess(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
        notifyListeners();
        clearInput();
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        final errorMessage =
            'Failed to add blog. Status Code: ${response.reasonPhrase}';
        snackErrorMessage(message: errorMessage, context: context);
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      final errorMessage = 'Error adding blog: $e';
      snackErrorMessage(message: errorMessage, context: context);
      notifyListeners();
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
