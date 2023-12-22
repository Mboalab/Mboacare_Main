import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/services/registerProvider.dart';
import 'package:mboacare/services/signup_provider.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/validations.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/input_fields.dart';
import 'package:mboacare/widgets/password_validation_view.dart';
import 'package:provider/provider.dart';
import '../../utils/snack_succ.dart';
import '../med_user/screen/dashboard/hospital/add_hopital.dart';
import '../../global/styles/colors.dart';
import 'login.dart';

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
      body: SafeArea(
        child: Center(
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
                    ImageAssets.logo,
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

                  // Consumer<RegisterProvider>(builder: (
                  //   context,
                  //   auth,
                  //   child,
                  // ) {
                  //   WidgetsBinding.instance.addPostFrameCallback((_) {
                  //     if (auth.reqMessage != '') {
                  //       snackMessage(
                  //         message: auth.reqMessage,
                  //         context: context,
                  //       );
                  //       auth.clear();
                  //     }
                  //   });
                  //   return AppButton(
                  //     onPressed: () {
                  //       auth.register(
                  //           email: provider.emailController.text, password: provider.passwordController.text);
                  //     },
                  //     title: "Register",
                  //     enabled: provider.isValidRegister,
                  //     status: auth.isLoading,
                  //     //model.isValidRegister
                  //   );
                  // }),
                  AppButton(
                    onPressed: () {
                      Get.to(() =>  AddHospitalPage(placeName: '',));
                      // provider.signUpWithEmailAndPassword(
                      //   onSuccessNavigate: () {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const AddHospitalPage(),
                      //       ),
                      //     );
                      //   }
                      // );
                    },
                    title: "Register",
                    enabled: provider.isValidRegister,
                    status: false,
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
                            builder: (context) =>  AddHospitalPage(placeName: '',),
                          ),
                        );
                      });
                    },
                    title: "Register with Google",
                    showImage: true,
                    image: ImageAssets.googleIcon,
                    borderColor: AppColors.borderColor,
                    textColor: AppColors.greenColor,
                    //model.isValidRegister
                  ),
                  SizedBox(height: AppFontSizes.fontSize16),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen(title: "Mboacare"));
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
      ),
    );
  }
}
