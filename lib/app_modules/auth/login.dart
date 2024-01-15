import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/auth/forgotPassword.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/services/auth_provider/loginProvider.dart';

import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/snack_succ.dart';
import 'package:provider/provider.dart';

import 'sign_up_page.dart';
import '../../global/styles/colors.dart';

import '../../widgets/custom_btn.dart';
import '../../widgets/input_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppFontSizes.fontSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.logo,
                  width: 120,
                ),
                SizedBox(height: AppFontSizes.fontSize12),
                Text(
                  AppStrings.welcome,
                  style: GoogleFonts.inter(
                    fontSize: AppFontSizes.fontSize22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: AppFontSizes.fontSize14),
                Text(
                  AppStrings.details,
                  style: GoogleFonts.inter(
                    fontSize: AppFontSizes.fontSize16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greenColor,
                  ),
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Text(
                        AppStrings.email,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: AppFontSizes.fontSize20,
                            color: AppColors.greenColor),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                  hintText: AppStrings.enterEmail,
                  controller: provider.emailController,
                  onChanged: (value) {
                    setState(() {
                      provider.setEmail(value);
                      provider.validSignIn();
                    });
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        AppStrings.password,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: AppFontSizes.fontSize14,
                            color: AppColors.greenColor),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                PasswordForm(
                  hintText: AppStrings.enterPassword,
                  controller: provider.passwordController,
                  onChanged: (value) {
                    setState(() {
                      provider.setPassword(value);
                      provider.validSignIn();
                    });
                  },
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: provider.rememberMe,
                          onChanged: (value) {
                            setState(() {
                              provider.rememberMe = value!;
                            });
                          },
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: provider.rememberMe
                                    ? AppColors.primaryColor
                                    : AppColors.borderColor,
                                width: 1.0),
                            borderRadius:
                                BorderRadius.circular(AppFontSizes.fontSize4),
                          ),
                        ),
                        Text(
                          AppStrings.remember,
                          style: GoogleFonts.inter(
                            color: AppColors.signInButtonColor,
                            fontSize: AppFontSizes.fontSize14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordScreen(),
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                            curve: Curves.easeInCirc,
                            transition: Transition.fadeIn);
                      },
                      child: Text(
                        AppStrings.forgot,
                        style: GoogleFonts.inter(
                          color: AppColors.signInButtonColor,
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                // Login with Email Button
                Consumer<LoginProvider>(builder: (
                  context,
                  auth,
                  child,
                ) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (auth.reqMessage != '') {
                      auth.clear();
                    }
                  });
                  return AppButton(
                    onPressed: () {
                      auth.login(
                          context: context,
                          email: provider.emailController.text,
                          password: provider.passwordController.text);
                    },
                    title: "Login",
                    enabled: provider.isValidSignIn,
                    status: auth.isLoading,
                  );
                }),
                SizedBox(height: AppFontSizes.fontSize14),
                // Login with Google Button
                Consumer<LoginProvider>(builder: (
                  context,
                  auth,
                  child,
                ) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (auth.reqMessage != '') {
                      auth.clear();
                    }
                  });
                  return AppBorderButton(
                    onPressed: () {
                      auth.signInWithGoogle(context: context);
                    },
                    title: AppStrings.signInWithGoogle,
                    showImage: true,
                    image: ImageAssets.googleIcon,
                    borderColor: AppColors.borderColor,
                    textColor: AppColors.greenColor,
                    //model.isValidRegister
                  );
                }),
                SizedBox(height: AppFontSizes.fontSize10),
                TextButton(
                    onPressed: () {
                      Get.to(() => const SignUpPage(),
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          curve: Curves.easeInCirc,
                          transition: Transition.zoom);
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: AppStrings.doNotHaveAccount,
                              style: GoogleFonts.inter(
                                  color: AppColors.primaryColor,
                                  fontSize: AppFontSizes.fontSize14,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                            text: AppStrings.signUp,
                            style: GoogleFonts.inter(
                                color: AppColors.primaryColor,
                                fontSize: AppFontSizes.fontSize14,
                                fontWeight: FontWeight
                                    .w600 // Set the color for "Sign up"
                                ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
