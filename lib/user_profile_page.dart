import 'package:flutter/material.dart';
import 'package:mboacare/user_avatar.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/user_password_update.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'user_model.dart';
import 'user_provider.dart';
import 'utils/validator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final UserModel user = userDataProvider.currentUser;

    void showEditDialog(BuildContext context, String hint, String item,
        UserDataProvider userDataProvider) {
      String textFieldValue = '';
      String errorText = '';

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        textFieldValue = value;
                      },
                      decoration: InputDecoration(hintText: hint),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: !userDataProvider.savingData
                      ? Text(
                          'SAVE',
                          style: dialogActionButtonTextStyle(),
                        )
                      : Text('SAVING...', style: dialogActionButtonTextStyle()),
                  onPressed: () async {
                    setState(() {
                      userDataProvider.savingData;
                    });
                    if (item == 'email') {
                      if (UserInfoValidator.isEmailValid(textFieldValue)) {
                        await userDataProvider.updateUserEmail(
                            context, textFieldValue);
                        setState(() {
                          errorText = ''; // Clear error message.
                        });
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          errorText =
                              'Invalid email format'; // Set error message
                        });
                      }
                    } else if (item == 'name' && textFieldValue != '') {
                      await userDataProvider.updateUserDisplayName(
                          context, textFieldValue);
                      if (!context.mounted) return;

                      Navigator.of(context).pop();
                    } else if (item == 'phone' && textFieldValue != '') {
                      await userDataProvider.updateUserPhoneNumber(
                          context, textFieldValue);
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            );
          });
        },
      );
    }

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
                              : user.photoURL != ''
                                  ? CachedNetworkImage(
                                      imageUrl: user.photoURL!,
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : RandomColorAvatar(
                                      username: user.displayName,
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
                      userDataProvider.updateProfilePic(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: !userDataProvider.savingImage
                        ? const Text(
                            'Change Photo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Uploading...',
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
                title: const Text('Name'),
                trailing: const Icon(
                  Icons.edit_square,
                  size: 19,
                ),
                subtitle: Text(user.displayName),
                onTap: () {
                  showEditDialog(
                      context, user.displayName, 'name', userDataProvider);
                },
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
                subtitle: user.phoneNumber != ''
                    ? Text(user.phoneNumber!)
                    : const Text('Add phone number'),
                onTap: () {
                  showEditDialog(
                      context, user.phoneNumber!, 'phone', userDataProvider);
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
                  showEditDialog(
                      context, user.email, 'email', userDataProvider);
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
