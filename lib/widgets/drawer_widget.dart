import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/app_modules/user/screens/dashboard/blog_page.dart';
import 'package:mboacare/app_modules/user/screens/dashboard/home.dart';
import 'package:mboacare/global/styles/assets_string.dart';

import '../global/styles/colors.dart';
import '../app_modules/user/screens/dashboard/hospital.dart';
import '../app_modules/user/screens/dashboard/settings.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.colorWhite,
      child: ListView(
        //  padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  ImageAssets.user,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Janet Dolittle',
                  style: AppTextStyles.headerThree,
                  // TextStyle(
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('janetdolittle@mail.com',
                    style: AppTextStyles.bodyOne.copyWith(
                      fontWeight: FontWeight.w600,
                    )
                    // TextStyle(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.grey),
                    ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 1.5,
            color: AppColors.grey100,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedIndex == 0
                    ? AppColors.buttonColor
                    : Colors.transparent),
            child: ListTile(
              leading: SvgPicture.asset(
                ImageAssets.home,
                color: selectedIndex == 0 ? Colors.white : Colors.black,
              ),
              title: Text(
                'Home',
                style: AppTextStyles.headerThree.copyWith(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedIndex == 1
                    ? AppColors.buttonColor
                    : Colors.transparent),
            child: ListTile(
              leading: SvgPicture.asset(
                ImageAssets.blog,
                color: selectedIndex == 1 ? Colors.white : Colors.black,
              ),
              title: Text(
                'Hospitals',
                style: AppTextStyles.headerThree.copyWith(
                    color: selectedIndex == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HospitalDashboard()));
              },
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedIndex == 2
                    ? AppColors.buttonColor
                    : Colors.transparent),
            child: ListTile(
              leading: SvgPicture.asset(
                ImageAssets.hospital,
                color: selectedIndex == 2 ? Colors.white : Colors.black,
              ),
              title: Text(
                'Blogs',
                style: AppTextStyles.headerThree.copyWith(
                    color: selectedIndex == 2 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BlogPage()));
              },
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedIndex == 3
                    ? AppColors.buttonColor
                    : Colors.transparent),
            child: ListTile(
              leading: SvgPicture.asset(
                ImageAssets.user1,
                color: selectedIndex == 3 ? Colors.white : Colors.black,
              ),
              title: Text(
                'Settings',
                style: AppTextStyles.headerThree.copyWith(
                    color: selectedIndex == 3 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
            ),
          ),
          const SizedBox(
            height: 180,
          ),
          const Divider(
            color: AppColors.grey100,
            thickness: 1.5,
          ),
          const Center(
            child: Text(
              'Mboacare',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey),
            ),
          ),
          const Center(
            child: Text(
              'v0.0.1',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.buttonColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
