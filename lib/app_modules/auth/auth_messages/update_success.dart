import 'package:flutter/material.dart';

import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';

import 'package:mboacare/services/auth_provider/loginProvider.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

class UpdateProfileSuccess extends StatelessWidget {
  const UpdateProfileSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.25,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImageAssets.checkedRing,
              height: 150,
              width: 150,
            ),
          ),
          Text(
            'Profile Updated Successfully!.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyOne
                .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Kindly  Logout and Login again for Account Updates!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyFour
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
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
                auth.signOut(context: context);
              },
              title: "Logout",
              enabled: true,
              status: auth.isLoading,
            );
          }),
        ],
      ),
    );
  }
}
