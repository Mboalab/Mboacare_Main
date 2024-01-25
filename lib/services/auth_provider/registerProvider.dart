// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mboacare/app_modules/auth/auth_messages/success_screen.dart';
import 'package:mboacare/services/apis.dart';
import 'package:http/http.dart' as http;
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:mboacare/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  String _reqMessage = "";
  bool _isLoading = false;

  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String registrationStatus = '';
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool isValidRegister = false;

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void validRegister() {
    final isNameFilled = name.trim().isNotEmpty;
    final isValidEmail = isValidEmails(email.trim());
    final isPasswordValid = passwordHasMinLength(password.trim()) &&
        passwordHasSpecialCharacter(password.trim());
    final arePasswordsMatching = confirmPassword.trim() == password.trim();

    isValidRegister =
        isNameFilled && isValidEmail && isPasswordValid && arePasswordsMatching;
    notifyListeners();
  }

  void clearInput() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    confirmPasswordController.clear();
  }

  void register(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    String url = Apis.verificationLink;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    final body = {"email": email};

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));
      print(user);

      if (req.statusCode == 200 || req.statusCode == 201) {
        var res = json.decode(req.body);

        _isLoading = false;

        snackMessage(message: res['message'], context: context);
        clearInput();
        notifyListeners();
        Get.to(() => const SuccessScreen(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
      }
    } catch (e) {
      notifyListeners();
      log(e.toString());
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          _isLoading = false;

          snackErrorMessage(message: e.code, context: context);
        } else {
          _isLoading = false;

          snackErrorMessage(message: e.message!, context: context);
          notifyListeners();
        }
      }
    }
  }

  // Sign-up with google
  void signUpWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User user = userCredential.user!;

      String url = Apis.verificationLink;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Charset': 'utf-8'
      };

      final body = {"email": user.email};

      http.Response req = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(body));
      if (req.statusCode == 200 || req.statusCode == 201) {
        var res = json.decode(req.body);

        snackMessage(message: res['message'], context: context);
        clearInput();
        _isLoading = false;
        notifyListeners();
        Get.to(() => const SuccessScreen(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
      }

      // Handle successful sign-in
    } catch (e) {
      notifyListeners();
      log(e.toString());
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          _isLoading = false;
          snackErrorMessage(message: e.code, context: context);
        } else {
          _isLoading = false;

          snackErrorMessage(message: e.message!, context: context);
          notifyListeners();
        }
      }
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedIn', false);
      await prefs.remove('email');

      // Add any other necessary clean-up or navigation logic here.
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
