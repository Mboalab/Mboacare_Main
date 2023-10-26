// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mboacare/register.dart';
import 'colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController =
      TextEditingController(); // New controller for Name
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _registrationStatus = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final String documentId =
      'aeac9fSTIeI6UD0OywSj'; // ID of the document to fetch
  final String collectionName = 'sendgrid'; // Name of the collection
  final String fieldName = 'apiKey'; // Name of the field to retrieve
  String apiKeySG = '';

  @override
  void initState() {
    super.initState();
    fetchApiKey();
  }

  Future<void> fetchApiKey() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        apiKeySG = documentSnapshot.get(fieldName);
        devtools.log(apiKeySG);
      } else {
        devtools.log('Document not found');
      }
    } catch (error) {
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
            {
              'email': recipientEmail,
              'name': recipientName
            }, // Included recipient's name
          ],
          'subject': 'Welcome to Mboacare!',
        },
      ],
      'from': {'email': 'mboacare@gmail.com'},
      'content': [
        {
          'type': 'text/plain',
          'value':
              '''
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
      devtools.log('Email sent successfully');
    } else {
      devtools.log('Failed to send email. Status code: ${response.statusCode}');
    }
  }

  void _signUpWithEmailAndPassword() async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      _showMessage("No internet connection. Please check your connection.");
      return;
    }
    try {
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        setState(() {
          _registrationStatus = 'Passwords do not match';
        });
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(_nameController.text.trim());

        sendWelcomeEmail(_emailController.text, _nameController.text.trim());

        setState(() {
          _registrationStatus = 'Registration successful';
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _registrationStatus = 'Registration failed: ${e.toString()}';
      });
    }
  }

  Future<void> _signUpWithGoogle() async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      _showMessage("No internet connection. Please check your connection.");
      return;
    }
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
      if (result == null) {
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = finalResult.user;

      if (user != null) {
        setState(() {
          _registrationStatus = 'Google sign-in successful';
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isSignedIn', true);
        prefs.setString('email', user.email ?? "");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
      }
    } catch (error) {
      devtools.log(error.toString());
    }
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void _showMessage(String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assests/images/logo.png',
                  width: 125,
                ),
                const SizedBox(height: 10),
                const Text(
                  ' Create an account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor2,
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'Name *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor2),
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.password,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10.0,
                        ),
                        hintText: 'Enter your name',
                        labelStyle: TextStyle(color: AppColors.primaryColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 1),
                      child: Text(
                        'Email *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor2),
                      ),
                    )),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.password,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10.0,
                        ),
                        hintText: 'Enter your email',
                        labelStyle: TextStyle(color: AppColors.primaryColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 1),
                      child: Text(
                        'Password *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor2),
                      ),
                    )),
                const SizedBox(height: 10),
                // Password Field
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.password,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              hintText: 'Enter your password',
                              labelStyle:
                                  TextStyle(color: AppColors.primaryColor),
                              border: InputBorder.none,
                            ),
                            obscureText: !_isPasswordVisible,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Confirm Password Field
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 1),
                      child: Text(
                        'Confirm Password *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor2),
                      ),
                    )),

                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.password,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              hintText: 'Confirm your password',
                              labelStyle:
                                  TextStyle(color: AppColors.primaryColor),
                              border: InputBorder.none,
                            ),
                            obscureText: !_isConfirmPasswordVisible,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),
                SizedBox(
                  height: 40,
                  width: 320,
                  child: ElevatedButton(
                    onPressed: _signUpWithEmailAndPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  _registrationStatus,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 1),
                SizedBox(
                  height: 40,
                  width: 320,
                  child: ElevatedButton(
                    onPressed: _signUpWithGoogle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.googleButtonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/assests/images/google-icon.png',
                          height: 32,
                          width: 32,
                        ),
                        const SizedBox(width: 4),
                        const Text('Register with Google'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
