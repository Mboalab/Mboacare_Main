import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_up_page.dart';
import 'register.dart';
import 'colors.dart';
import 'dart:developer' as devtools show log;

import 'package:connectivity_plus/connectivity_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required String title}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _isPasswordVisible = false;

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _checkUserLoggedIn();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      _showMessage("No internet connection. Please check your connection.");
      return;
    }

    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        _showMessage("Please enter email and password.");
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          _showMessage(
              "A verification email has been sent to your email address. Please verify your email.");
        } else {
          _saveUserEmail(user.email!);
          _showMessage("Sign in successful: ${user.email}");
          if (mounted) {
            // Navigate to register.dart
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterPage()),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMessage("User account not found. Please sign in with Google.");
      } else {
        _showMessage("Sign in failed: ${e.toString()}");
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    bool isConnected = await _checkConnectivity();
    if (!isConnected) {
      _showMessage("No internet connection. Please check your connection.");
      return;
    }
    try {
      GoogleSignInAccount? googleUser = _googleSignIn.currentUser;

      googleUser ??= await _googleSignIn.signIn();

      if (googleUser != null) {
        _navigatetoHospitalRegistrationForm();
      }
    } catch (e) {
      _showMessage("Google sign-in failed: ${e.toString()}");
    }
  }

  // Future<void> _sendVerificationEmail(User user) async {
  //   try {
  //     await user.sendEmailVerification();
  //     _showMessage(
  //         "A verification email has been sent to your email address. Please verify your email.");
  //   } catch (e) {
  //     _showMessage("Email verification failed: ${e.toString()}");
  //   }
  // }

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

  void _navigatetoHospitalRegistrationForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  _saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', email);
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  _checkUserLoggedIn() async {
    String? userEmail = await _getUserEmail();
    if (userEmail != null && userEmail.isNotEmpty) {
      devtools.log(userEmail);
      // _navigateToRegisterPage();
    }
  }

  Future<void> _sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showMessage(
          "A password reset email has been sent to your email address. Please follow the instructions to reset your password.");
    } catch (e) {
      _showMessage("Password reset email failed: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assests/images/logo.png',
                width: 120,
              ),
              const SizedBox(height: 12),
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Welcome back! Please enter your details.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.signInButtonColor,
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
                    color: AppColors.greenColor,
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
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'Password *',
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
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10.0,
                      ),
                      hintText: 'Enter your password',
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      const Text(
                        "Remember Me",
                        style: TextStyle(
                          color: AppColors.textColor2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (_emailController.text.isNotEmpty) {
                        _sendPasswordResetEmail(_emailController.text.trim());
                      } else {
                        _showMessage(
                            "Please enter your email to reset the password.");
                      }
                    },
                    child: const Text(
                      "Forgot password",
                      style: TextStyle(
                        color: AppColors.textColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // Login with Email Button
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(340, 45),
                ),
                child: const Text(
                  "Login with Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Login with Google Button
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(340, 45),
                ),
                icon: Image.asset(
                  'lib/assests/images/google-icon.png',
                  height: 32,
                  width: 32,
                ),
                label: const Text(
                  "Login with Google",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()));
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
