// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mboacare/app_modules/med_user/med_dashboard.dart';
import 'package:mboacare/app_modules/user/user_dashboard.dart';
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:mboacare/utils/validations.dart';

class LoginProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

 bool _loading = false;
  String _reqMessage = "";
  bool _isLoading = false;
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String userEmail = '';
  String userName = '';
  String profileImage = "";
  String email = "";
  String password = "";
  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isValidSignIn = false;
  String get reqMessage => _reqMessage;
  bool get isLoading => _isLoading;
  bool get loading => _loading;
  setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void validSignIn() {
    final isPasswordFilled = password.trim().isNotEmpty && password.length >= 4;
    final isValidEmail = isValidEmails(email.trim());

    isValidSignIn = isValidEmail && isPasswordFilled;
    notifyListeners();
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      print(user);

      if (user!.emailVerified == false) {
        _isLoading = false;
        _reqMessage = "Email is not verified! Check email to verify Account!";
        snackErrorMessage(
            message: "Email is not verified! Check email to verify Account!",
            context: context);
        print(_reqMessage);
        notifyListeners();
      } else {
        _isLoading = false;

        snackMessage(message: "Login Successful!", context: context);
        print(user);
        notifyListeners();
        Get.to(() => const MedDashboard(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          _isLoading = false;
          //_reqMessage = e.code;
          snackErrorMessage(message: e.code, context: context);
        } else {
          _isLoading = false;
          _reqMessage = e.message!;
          snackErrorMessage(message: e.message!, context: context);
          notifyListeners();
        }
      }
    }
  }

  void signInWithGoogle({required BuildContext context}) async {
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
      print(user);
      userEmail = user.email!;
      userName = user.displayName!;
      profileImage = user.photoURL!;
      // Handle successful sign-in
      if (user.emailVerified == false) {
        _isLoading = false;
        snackErrorMessage(
            message: "Email is not verified! Check email to verify Account!",
            context: context);
        print(_reqMessage);
        notifyListeners();
      } else {
        _isLoading = false;
        snackMessage(message: "Login Successful!", context: context);
        print(user);
        notifyListeners();
        Get.to(() => const MedDashboard(),
            duration: const Duration(
              milliseconds: 800,
            ),
            curve: Curves.easeInCirc,
            transition: Transition.fadeIn);
      }
    } catch (e) {
      notifyListeners();
      print(e.toString());
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          _isLoading = false;
          snackErrorMessage(message: e.code, context: context);
          _reqMessage = e.code;
        } else {
          _isLoading = false;
          snackErrorMessage(message: e.message!, context: context);
          notifyListeners();
        }
      }
    }
  }

  void signOut({required BuildContext context}) async {
    _loading = true;
    snackMessage(message: "Logout Successful!", context: context);
    notifyListeners();
    Get.to(() => const DashboardScreen(userName: ''),
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInCirc,
        transition: Transition.fadeIn);
    try {
      await auth.signOut();
      await googleSignIn.signOut(); // For Google sign-in
      _loading = false;
      notifyListeners();
    } catch (error) {
      // Handle signout errors
      if (error is FirebaseAuthException) {
        if (error.code == "user-not-found") {
          _loading = false;
          snackErrorMessage(message: error.code, context: context);
          _reqMessage = error.code;
        } else {
          _loading = false;
          snackErrorMessage(message: error.message!, context: context);
          notifyListeners();
        }
      }
      print(error);
    }
  }

  void clear() {
    _reqMessage = '';
    notifyListeners();
  }
}
