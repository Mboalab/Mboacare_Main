import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mboacare/utils/constants.dart';
import 'dart:developer' as devtools show log;

import '../utils/validations.dart';
import '../widgets/snackbar.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider() {
    checkUserLoggedIn();
  }

  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email = "";
  String password = "";
  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isValidSignIn = false;

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

  Future<String?> getUserEmail() async {
    return sharedPreference.getEmail();
  }

  Future<void> checkUserLoggedIn() async {
    String? userEmail = await getUserEmail();
    if (userEmail != null && userEmail.isNotEmpty) {
      devtools.log(userEmail);
      debugPrint(userEmail);
      // _navigateToRegisterPage();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      showMessage(
          message:
              "A password reset email has been sent to your email address. Please follow the instructions to reset your password.");
    } catch (error) {
      showMessage(
          message:
              "A password reset email has been sent to your email address. Please follow the instructions to reset your password.");
      debugPrint("Password reset email failed: ${error.toString()}");
    }
  }

  Future<void> signInWithEmailAndPassword(
      {Function()? onSuccessNavigate}) async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      showMessage(
          isError: true,
          message: "No internet connection. Please check your connection.");
      return;
    }
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          showMessage(
              message:
                  "A verification email has been sent to your email address. "
                  "Please verify your email.");
        } else {
          sharedPreference.saveEmail(user.email.toString());
          showMessage(message: "Sign in successful: ${user.email}");

          //Handle navigation to RegisterPage
          onSuccessNavigate!();
        }
      }
      notifyListeners();
    } catch (error) {
      if (error is FirebaseAuthException) {
        // Handle specific FirebaseAuthException types
        if (error.code == 'user-not-found') {
          showMessage(
              isError: true,
              message: "User account not found. Please sign in with Google.");
        } else {
          showMessage(
              isError: true, message: "Sign in failed: ${error.toString()}");
        }
      }
      debugPrint(error.toString());
    }
  }

  Future<void> _sendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
      showMessage(
          message: "A verification email has been sent to your email address. Please verify your email.");
    } catch (e) {
      showMessage(
          isError: true,
          message:"Email verification failed: ${e.toString()}");
    }
  }

  Future<void> signInWithGoogle({Function()? onSuccessNavigate}) async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      showMessage(
          isError: true,
          message: "No internet connection. Please check your connection.");
      return;
    }

    try {
      GoogleSignInAccount? googleUser = googleSignIn.currentUser;

      googleUser ??= await googleSignIn.signIn();

      if (googleUser != null) {
        showMessage(message: "Google sign-in successful}");
        //Handle navigation to Hospital RegisterPage
        onSuccessNavigate!();
      }
    } catch (error) {
      showMessage(
          isError: true, message: "Google sign-in failed: ${error.toString()}");
      debugPrint(error.toString());
    }
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void _showMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
