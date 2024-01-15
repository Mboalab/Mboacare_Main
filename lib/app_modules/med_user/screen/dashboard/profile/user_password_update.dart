import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/services/auth_provider/chagePasswordProvider.dart';

import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/snack_error.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/input_fields.dart';
import 'package:provider/provider.dart';
import '../../../../../global/styles/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePasswordProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.registerCard,
        title: Text(
          "Change password",
          style: AppTextStyles.bodyOne.copyWith(
            fontSize: 16,
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.changePasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email *', style: mediumTextStyle(context)),
                const SizedBox(height: 10),
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
                const SizedBox(height: 16),
                Text('New password', style: mediumTextStyle(context)),
                const SizedBox(height: 10),
                PasswordTextField(
                  hintText: 'Enter your new password',
                  controller: provider.passwordController,
                  isPasswordVisible: provider.isNewPasswordVisible,
                  togglePasswordVisibility: () {
                    provider.toggleNewPasswordVisibility();
                  },
                ),
                const SizedBox(height: 16),
                Text('Confirm new password', style: mediumTextStyle(context)),
                const SizedBox(height: 10),
                PasswordTextField(
                  hintText: 'Enter your new password again',
                  controller: provider.confirmPasswordController,
                  isPasswordVisible: provider.isConfirmPasswordVisible,
                  togglePasswordVisibility: () {
                    provider.toggleConfirmPasswordVisibility();
                  },
                ),
                const SizedBox(height: 24),
                Consumer<ChangePasswordProvider>(builder: (
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
                      if (!provider.changePasswordFormKey.currentState!
                          .validate()) {
                      } else if (provider.passwordController.text !=
                          provider.confirmPasswordController.text) {
                        snackErrorMessage(
                            message: 'Password do not match!',
                            context: context);
                      }
                      auth.changePassword(
                          context: context,
                          u_email: provider.emailController.text,
                          password: provider.passwordController.text);
                    },
                    title: "Update Password",
                    enabled: provider.isValidSignIn,
                    status: auth.isLoading,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;

  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            hintText: hintText,
            hintStyle: hintTextStyle(context),
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {
                togglePasswordVisibility();
              },
              child: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          obscureText: !isPasswordVisible,
        ),
      ),
    );
  }
}
