import 'package:flutter/material.dart';
import 'package:mboacare/user_provider.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:provider/provider.dart';
import 'colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => userDataProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Change password",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current password *', style: mediumTextStyle(context)),
                const SizedBox(height: 10),
                PasswordTextField(
                  hintText: 'Enter your current password',
                  controller: userDataProvider.currentPasswordController,
                  isPasswordVisible: userDataProvider.isCurrentPasswordVisible,
                  togglePasswordVisibility: () {
                    userDataProvider.toggleCurrentPasswordVisibility();
                  },
                ),
                const SizedBox(height: 16),
                Text('New password', style: mediumTextStyle(context)),
                const SizedBox(height: 10),
                PasswordTextField(
                  hintText: 'Enter your new password',
                  controller: userDataProvider.newPasswordController,
                  isPasswordVisible: userDataProvider.isNewPasswordVisible,
                  togglePasswordVisibility: () {
                    userDataProvider.toggleNewPasswordVisibility();
                  },
                ),
                const SizedBox(height: 16),
                Text('Confirm new password', style: mediumTextStyle(context)),
                const SizedBox(height: 10),
                PasswordTextField(
                  hintText: 'Enter your new password again',
                  controller: userDataProvider.confirmNewPasswordController,
                  isPasswordVisible: userDataProvider.isConfirmPasswordVisible,
                  togglePasswordVisibility: () {
                    userDataProvider.toggleConfirmPasswordVisibility();
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      userDataProvider.saveNewPassword(
                          context,
                          userDataProvider.currentPasswordController.text,
                          userDataProvider.newPasswordController.text,
                          userDataProvider.confirmNewPasswordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(340, 45),
                    ),
                    child: !userDataProvider.savingData
                        ? const Text('Update',
                            style: TextStyle(
                                fontSize: 17, color: AppColors.whiteColor))
                        : const Text('Updating...',
                            style: TextStyle(
                                fontSize: 17, color: AppColors.whiteColor)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                        child: TextButton(
                      onPressed: () {
                        userDataProvider.sendPasswordResetEmail(context);
                      },
                      child: !userDataProvider.sendingResetEmail
                          ? const Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.primaryColor),
                            )
                          : const Text('Sending...',
                              style: TextStyle(
                                  fontSize: 17, color: AppColors.primaryColor)),
                    )))
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
