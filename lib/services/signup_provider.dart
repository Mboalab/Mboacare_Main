import 'dart:convert';
import 'dart:developer' as devtools show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/validations.dart';

class SignUpProvider extends ChangeNotifier {
  SignUpProvider() {
    fetchApiKey();
  }

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final firebaseFirestore = FirebaseFirestore.instance;
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

  final String documentId = 'aeac9fSTIeI6UD0OywSj';
  final String collectionName = 'sendgrid';
  final String fieldName = 'apiKey';
  String apiKeySG = '';

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

  Future<void> fetchApiKey() async {
    try {
      DocumentSnapshot documentSnapshot = await firebaseFirestore
          .collection(collectionName)
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        apiKeySG = documentSnapshot.get(fieldName);
        debugPrint(apiKeySG);
        devtools.log(apiKeySG);
      } else {
        debugPrint('Document not found');
        devtools.log('Document not found');
      }
    } catch (error) {
      debugPrint('Error fetching data: $error');
      devtools.log('Error fetching data: $error');
    }
  }

  Future<void> sendWelcomeEmail(
      String recipientEmail, String recipientName) async {
    String apiKey = apiKeySG;
    final Uri uri = Uri.https(
      'api.sendgrid.com',
      '/v3/mail/send',
    );

    final Map<String, dynamic> data = {
      'personalizations': [
        {
          'to': [
            {'email': recipientEmail, 'name': recipientName},
          ],
          'subject': 'Welcome to Mboacare!',
        },
      ],
      'from': {'email': 'mboacare@gmail.com'},
      'content': [
        {
          'type': 'text/plain',
          'value': '''
Dear $recipientName,

Welcome to Mboacare! We're thrilled to have you as part of our community. Your commitment to better healthcare accessibility is appreciated.

Thank you for signing up. We look forward to providing you with a seamless experience as you explore medical facilities and connect with healthcare experts.

If you have any questions or need assistance, feel free to reach out to us anytime. Once again, welcome aboard!

Best regards,
The Mboacare Team
        '''
        },
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 202) {
      debugPrint('Email sent successfully');
    } else {
      debugPrint('Failed to send email. Status code: ${response.statusCode}');
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {Function()? onSuccessNavigate}) async {
    try {
      final String password = passwordController.text;
      final String confirmPassword = confirmPasswordController.text;

      if (password != confirmPassword) {
        registrationStatus = 'Passwords do not match';
        notifyListeners();
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(nameController.text.trim());

        sendWelcomeEmail(
            emailController.text.trim(), nameController.text.trim());

        registrationStatus = 'Registration successful';
        //Handle navigation to RegisterPage
        onSuccessNavigate!();

        notifyListeners();
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        // Handle specific FirebaseAuthException types
        if (error.code == 'email-already-in-use') {
          registrationStatus =
              "Registration failed: ${error.message.toString()}";
        } else if (error.code == 'weak-password') {
          registrationStatus =
              "Registration failed: ${error.message.toString()}";
        } else {
          registrationStatus = 'Registration failed: ${error.toString()}';
        }
      } else {
        registrationStatus = 'Registration failed: ${error.toString()}';
      }
      debugPrint(error.toString());
    }
  }

  Future<void> signUpWithGoogle({Function()? onSuccessNavigate}) async {
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );
      var finalResult = await _auth.signInWithCredential(credential);
      final User? user = finalResult.user;

      if (user != null) {
        registrationStatus = 'Google sign-in successful';
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isSignedIn', true);
      prefs.setString('email', user?.email ?? "");

      //Handle navigation to RegisterPage
      onSuccessNavigate!();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedIn', false);
      await prefs.remove('email');

      // Add any other necessary clean-up or navigation logic here.
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
