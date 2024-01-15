import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/auth_provider/forgotPasswordProvider.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/input_fields.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForgotPasswordProvider>(context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 150),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImageAssets.logo,
              height: 120,
              width: 120,
            ),
          ),
          Text(
            'Forgot your Password?',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyOne
                .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Enter your email to receive a Reset Password Link.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyFour
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
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
          const SizedBox(
            height: 40,
          ),
          Consumer<ForgotPasswordProvider>(builder: (
            context,
            auth,
            child,
          ) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (auth.reqMessage != '') {
                // snackMessage(
                //   message: auth.reqMessage,
                //   context: context,
                // );
                auth.clear();
              }
            });
            return AppButton(
              onPressed: () {
                auth.resetPassword(
                  context: context,
                  email: provider.emailController.text,
                );
              },
              title: "Submit",
              enabled: provider.isValidSignIn,
              status: auth.isLoading,
            );

           
          }),
        ],
      ),
    );
  }
}
