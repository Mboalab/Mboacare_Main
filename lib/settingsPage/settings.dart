import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/settingsPage/settingsWidget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        actions: <Widget>[
          const IconButton(
              onPressed: null,
              icon: Icon(Iconsax.notification,
                  color: AppColors.textColor2, size: 30))
        ],

        title: Padding(
          padding: const EdgeInsets.only(left: 95),
          child: SizedBox(
            width: 55,
            height: 65,
            child: Image.asset("lib/assests/images/logo.png"),
          ),
        ),

        backgroundColor: AppColors.navbar,
        leading: const IconButton(
          icon: Icon(
            Iconsax.menu_1,
            size: 30,
            color: AppColors.textColor2,
          ),
          onPressed: null,
        ),
        // Color.fromARGB(255, 232, 247, 215),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: null,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assests/images/lady.jpeg'),
                      radius: 45,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Janet Dolittle',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor2),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 5)),
                          Text(
                            'janetdolittle@mail.org',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                //height: 5,
                color: Color(0xFFECEFF1),
                endIndent: 2,
                indent: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              const SettingsPageListTiles(
                  icon: Icon(
                    Iconsax.profile_add,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'Account',
                  subtitle: 'Profile',
                  trailingIcon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  onTap: null),
              const SettingsPageListTiles(
                  icon: Icon(
                    Iconsax.global_edit,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'Language',
                  subtitle: 'English',
                  trailingIcon: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: null),
              SettingsPageListTiles(
                  icon: const Icon(
                    Iconsax.moon,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'Theme',
                  subtitle: 'System',
                  trailingIcon: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/themeScreen');
                  }),
              const SettingsPageListTiles(
                  icon: Icon(
                    Iconsax.hospital5,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'Facilities',
                  subtitle: 'Manage Facilities',
                  trailingIcon: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: null),
              const SettingsPageListTiles(
                  icon: Icon(
                    Iconsax.moon,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'About Us',
                  subtitle: 'Contact us',
                  trailingIcon: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: null),
              const Signout(
                  icon: Icon(Iconsax.logout,
                      color: AppColors.textColor2, size: 25),
                  title: 'Signout',
                  onTap: null),
              DeleteAccount(
                  //iconColor: Colors.redAccent,
                  icon: const Icon(
                    Iconsax.trash,
                    color: Colors.redAccent,
                  ),
                  //color: AppColors.textColor2, size: 25),
                  title: 'Delete Account',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DeleteAccountDialog();
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
        decoration: BoxDecoration(
          color: AppColors.googleButtonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 15)),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(13),
                color: Color.fromARGB(255, 228, 207, 207),
              ),
              child: const Icon(
                Iconsax.trash,
                color: Colors.red,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Delete account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'If your account is deleted, all your data willl be lost.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: null,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.34,
                height:
                    //50,
                    MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: AppColors.deleteColor,
                    borderRadius: BorderRadius.circular(35)),
                child: Center(
                  child: const Text(
                    'Delete my account',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    //textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
