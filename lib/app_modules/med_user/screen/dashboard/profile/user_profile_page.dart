import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/profile/update_profile.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/profile/user_password_update.dart';
import 'package:mboacare/model/user_model.dart';
import 'package:mboacare/services/auth_provider/loginProvider.dart';

import 'package:mboacare/global/styles/colors.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key, this.userModel});
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.registerCard,
          leading: IconButton(
              color: AppColors.secondaryTextColor,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
          title: const Text(
            'Personal info',
            style: TextStyle(
                fontSize: 17,
                color: AppColors.secondaryTextColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(userModel!.photoURL.toString()),
                          radius: 45,
                          //child: Container( child: Image.network(provider.profileImage)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const UpdateProfile(),
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                            curve: Curves.easeInCirc,
                            transition: Transition.fadeIn);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_4_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Name'),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: userModel?.displayName.toString() != null
                    ? Text(userModel!.displayName.toString())
                    : const Text('Update your Name'),
                // onTap: () {
                //   showEditDialog(
                //       context, user.displayName, 'name', userDataProvider);
                // },
              ),
              const Divider(
                thickness: 0.3,
              ),
              ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Phone number'),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: userModel!.phoneNumber != null
                    ? Text(userModel!.phoneNumber.toString())
                    : const Text('Update your profile'),
                // onTap: () {
                //   showEditDialog(
                //       context, user.phoneNumber!, 'phone', userDataProvider);
                // },
              ),
              const Divider(
                thickness: 0.3,
              ),
              ListTile(
                leading: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text(
                  'Email',
                ),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: Text(userModel!.email.toString()),
                // onTap: () {
                //   showEditDialog(
                //       context, user.email, 'email', userDataProvider);
                // },
              ),
              const Divider(
                thickness: 0.3,
              ),
              ListTile(
                leading: const Icon(
                  Icons.lock_outline,
                  color: AppColors.primaryColor,
                ),
                title: const Text(
                  'Password',
                ),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: const Text('Change password'),
                onTap: () {
                  Get.to(() => const ChangePasswordScreen(),
                      duration: const Duration(
                        milliseconds: 800,
                      ),
                      curve: Curves.easeInCirc,
                      transition: Transition.fadeIn);
                },
              ),
            ],
          ),
        ));
  }
}
