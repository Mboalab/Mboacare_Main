import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/login.dart';
import 'package:mboacare/register.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/validations.dart';
import 'package:mboacare/view_model/signup_view_model.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/input_fields.dart';
import 'package:mboacare/widgets/password_validation_view.dart';
import 'package:provider/provider.dart';
import 'colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppFontSizes.fontSize30,
            left: AppFontSizes.fontSize30,
            right: AppFontSizes.fontSize30,
            bottom: AppFontSizes.fontSize30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appLogo,
                  width: AppFontSizes.fontSize125,
                ),
                SizedBox(
                  height: AppFontSizes.fontSize10,
                ),
                Text(
                  ' Create an account',
                  style: GoogleFonts.inter(
                    fontSize: AppFontSizes.fontSize24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(
                  height: AppFontSizes.fontSize30,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Name *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                    hintText: "Enter your name",
                    onChanged: (value) {
                      setState(() {
                        provider.setName(value);
                        provider.validRegister();
                      });
                    },
                    controller: provider.nameController),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize1),
                      child: Text(
                        'Email *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                    hintText: "Enter your email",
                    onChanged: (value) {
                      setState(() {
                        provider.setEmail(value);
                        provider.validRegister();
                      });
                    },
                    controller: provider.emailController),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: AppFontSizes.fontSize4,
                          bottom: AppFontSizes.fontSize1),
                      child: Text(
                        'Password *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                  hintText: "Enter your password",
                  controller: provider.passwordController,
                  autofillHints: const [AutofillHints.newPassword],
                  onChanged: (value) {
                    setState(() {
                      provider.setPassword(value);
                      provider.validRegister();
                    });
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: AppFontSizes.fontSize4,
                          bottom: AppFontSizes.fontSize1),
                      child: Text(
                        'Confirm Password *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                  hintText: "Confirm your password",
                  controller: provider.confirmPasswordController,
                  autofillHints: const [AutofillHints.newPassword],
                  onChanged: (value) {
                    setState(() {
                      provider.setConfirmPassword(value);
                      provider.validRegister();
                    });
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize18),
                PasswordValidationView(
                  condition: passwordHasMinLength,
                  text: 'Must be at least 8 characters',
                  controller: provider.passwordController,
                ),
                SizedBox(height: AppFontSizes.fontSize8),
                PasswordValidationView(
                  condition: passwordHasSpecialCharacter,
                  text: 'Must contain one special character',
                  controller: provider.passwordController,
                ),
                SizedBox(height: AppFontSizes.fontSize18),
                AppButton(
                  onPressed: () {
                    provider.signUpWithEmailAndPassword(onSuccessNavigate: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    });
                  },
                  title: "Register",
                  enabled: provider.isValidRegister,
                  //model.isValidRegister
                ),
                SizedBox(height: AppFontSizes.fontSize1),
                Text(
                  provider.registrationStatus,
                  style: GoogleFonts.inter(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: AppFontSizes.fontSize1),
                AppBorderButton(
                  onPressed: () {
                    provider.signUpWithGoogle(onSuccessNavigate: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    });
                  },
                  title: "Register with Google",
                  showImage: true,
                  image: AppImages.googleIcon,
                  borderColor: AppColors.borderColor,
                  textColor: AppColors.greenColor,
                  //model.isValidRegister
                ),
                SizedBox(height: AppFontSizes.fontSize16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const LoginScreen(title: "Mboacare")));
                  },
                  child: Text(
                    "Already have an account? Log in",
                    style: GoogleFonts.inter(
                      color: AppColors.greenColor,
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
