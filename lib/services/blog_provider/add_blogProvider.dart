// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:mboacare/services/apis.dart';
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_modules/auth/blog_messages/add_success.dart';

class AddBlogProvider extends ChangeNotifier {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final webLinkController = TextEditingController();
  final authorController = TextEditingController();
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;

  void clearInput() {
    titleController.clear();
    categoryController.clear();
    webLinkController.clear();
    authorController.clear();
  }

  void addBlog(String title, String author, String category, String webLink,
      File? image, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences pref = await _pref;
    String myEmail = pref.getString('userEmail') ?? '';
    print(myEmail);
    final url = Uri.parse(Apis.addBlog);
    print(url);
    final request = http.MultipartRequest('POST', url);

    request.fields['blogTitle'] = title;
    request.fields['blogAuthor'] = author;
    request.fields['blogCat'] = category;
    request.fields['blogWebLink'] = webLink;
    request.fields['userEmail'] = myEmail;

    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('blogImage', image.path));
    }
    print(title);
    final response = await request.send();

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        snackMessage(message: "Blog Added Successful!", context: context);
        Get.to(() => const BlogSuccess(),
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
