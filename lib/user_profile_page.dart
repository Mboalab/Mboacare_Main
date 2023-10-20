import 'package:flutter/material.dart';
import 'package:mboacare/user_color_avatar.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/user_password_change.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'user_model.dart';
import 'user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final UserModel user = userDataProvider.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal info',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Update your photo and personal details',
                  style:
                      TextStyle(fontSize: 16, color: AppColors.primaryColor)),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: userDataProvider.image != null
                              ? Image.memory(
                                  userDataProvider
                                      .image!, // Use the local image data
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                )
                              : user.profilePicURL != ''
                                  ? CachedNetworkImage(
                                      imageUrl: user.profilePicURL!,
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : RandomColorAvatar(
                                      username: user.firstName,
                                      fontSize: 50,
                                      avatarSize: 65,
                                    ),
                        )
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
                      userDataProvider.updateProfilePic();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Change Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_4_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text('First Name'),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: Text(user.firstName),
                onTap: () {
                  userDataProvider.showEditDialog(
                      context, user.firstName, 'firstname');
                },
              ),
              const Divider(
                thickness: 0.3,
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_2_outlined,
                  color: AppColors.primaryColor,
                ),
                title: const Text('Last Name'),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: Text(user.lastName),
                onTap: () {
                  userDataProvider.showEditDialog(
                      context, user.lastName, 'lastname');
                },
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
                subtitle: Text(user.email),
                onTap: () {
                  userDataProvider.showEditDialog(context, user.email, 'email');
                },
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()));
                },
              ),
            ],
          ),
        ));
  }
}
