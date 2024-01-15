// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:mboacare/app_modules/auth/blog_messages/delete_success.dart';
import 'package:mboacare/services/apis.dart';

import '../../utils/snack_error.dart';
import '../../utils/snack_succ.dart';

class DeleteBlogProvider extends ChangeNotifier {

  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;



  void deleteBlog({
    required String blogId,
    required BuildContext context
  }) async {
    _isLoading = true;
    notifyListeners();
   
    String url = Apis.deleteBlog;
    
   
    Map<String, String> headers = {
      'Content-Type': 'application/json',
     
    };

   

 
    http.Response req = await http.delete(Uri.parse("$url$blogId"),
        headers: headers, );

    try {
      if (req.statusCode == 200 || req.statusCode == 201) {
        var res = json.decode(req.body);
        print(res);
        _isLoading = false;
        
        notifyListeners();
        snackMessage(message: res['message'], context: context);
        notifyListeners();
        Get.to(() => const DeleteBlogSuccess(),
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
