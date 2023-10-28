import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/settingsPage/settings_widget.dart';
import 'package:mboacare/view_model/signup_view_model.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.registerCard,
        title: Image.asset(
          'lib/assests/images/logo.png',
          width: 60,
          height: 60,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset('lib/assests/icons/notification.svg'),
          )
        ],
        leading: Builder(
          builder: (context) {
            return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SvgPicture.asset(
                    'lib/assests/icons/menu.svg',
                    width: 20,
                  ),
                ));
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //physics: null,
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
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor2),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 5)),
                          Text(
                            'janetdolittle@mail.org',
                            style: TextStyle(
                              fontSize: 15,
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
                color: AppColors.dividerColor,
                endIndent: 2,
                indent: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              SettingsPageListTiles(
                  icon: const Icon(
                    Iconsax.profile_add,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'Account',
                  subtitle: 'Profile',
                  trailingIcon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/profilePage');
                  }),
              SettingsPageListTiles(
                  icon: const Icon(
                    Iconsax.global_edit,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'Language',
                  subtitle: 'English',
                  trailingIcon: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const LanguageDialog();
                        });
                  }),
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
              SettingsPageListTiles(
                  icon: SvgPicture.asset(
                    'lib/assests/icons/hospital.svg',

                    color: AppColors.textColor2,
                    //size: 25,
                  ),
                  title: 'Facilities',
                  subtitle: 'Manage Facilities',
                  trailingIcon: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: null),
              SettingsPageListTiles(
                  icon: const Icon(
                    Iconsax.info_circle,
                    color: AppColors.textColor2,
                    size: 25,
                  ),
                  title: 'About Us',
                  subtitle: 'Contact us',
                  trailingIcon: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, '/aboutUs');
                  }),
              Signout(
                  icon: const Icon(Iconsax.logout,
                      color: AppColors.textColor2, size: 25),
                  title: 'Signout',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const SignoutDialog();
                        });
                  }),
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

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  int? clickedOption;

  bool firstValue = false;
  bool secondValue = false;
  bool thirdValue = false;
  bool fourthValue = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            //constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
            decoration: BoxDecoration(
              color: AppColors.googleButtonColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Select language',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                ),
                const Divider(
                  color: AppColors.dividerColor,
                ),
                // ListTile(
                //   leading:
                // Checkbox(
                //       value: firstValue,
                //       onChanged: (value) {
                //         setState(() {
                //           firstValue = value!;
                //           print('hi');
                //         });
                //       }),
                //   title: const Text('English',
                //       style:
                //           TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
                // )

                RadioTile(
                    groupValue: clickedOption,
                    value: 0,
                    onchanged: (value) {
                      setState(() {
                        clickedOption = value!;
                      });
                    },
                    text: 'English'),

                RadioTile(
                    value: 1,
                    groupValue: clickedOption,
                    onchanged: (value) {
                      setState(() {
                        clickedOption = value!;
                      });
                      //secondValue != value;
                    },
                    text: 'Hindi'),
                RadioTile(
                    value: 2,
                    groupValue: clickedOption,
                    onchanged: (value) {
                      setState(() {
                        clickedOption = value!;
                      });
                    },
                    text: 'Espanol'),
                RadioTile(
                    value: 3,
                    groupValue: clickedOption,
                    onchanged: (value) {
                      setState(() {
                        clickedOption = value!;
                      });
                    },
                    text: 'Francais'),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 21.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop;
                        },
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                              color: AppColors.deleteColor, fontSize: 17),
                        )),
                  ),
                )
              ],
            )));
  }
}

class SignoutDialog extends StatefulWidget {
  const SignoutDialog({super.key});

  @override
  State<SignoutDialog> createState() => _SignoutDialogState();
}

class _SignoutDialogState extends State<SignoutDialog> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
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
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        'lib/assests/icons/x.svg',
                        height: 18,
                      )),
                )),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 15)),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(13),
                color: AppColors.navbar,
              ),
              child: const Icon(
                Iconsax.logout,
                color: AppColors.textColor2,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Sign Out',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'You are about to log out from the Mboacare app',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                provider.signOut();
                Navigator.pushNamed(context, '/home');
              },
              child: Container(
                width: MediaQuery.of(context).size.height * 0.34,
                height:
                    //50,
                    MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: AppColors.deleteColor,
                    borderRadius: BorderRadius.circular(35)),
                child: const Center(
                  child: Text(
                    'Sign out',
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
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        'lib/assests/icons/x.svg',
                        height: 18,
                      )),
                )),
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 15)),
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
              height: 15,
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
                child: const Center(
                  child: Text(
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
