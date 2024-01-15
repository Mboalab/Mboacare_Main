import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/home.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/hospital_page.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/settings.dart';
import 'package:mboacare/app_modules/notifications/notifications.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/widgets/drawer_widget.dart';
import 'package:mboacare/widgets/myBottomBar.dart';

import '../user/screens/dashboard/blog_page.dart';

class MedDashboard extends StatefulWidget {
  const MedDashboard({Key? key}) : super(key: key);

  @override
  _MedDashboardState createState() => _MedDashboardState();
}

class _MedDashboardState extends State<MedDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const HospitalPage(),
    const BlogPage(),
    const Settings(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.registerCard,
        title: Image.asset(
          ImageAssets.logo,
          width: 30,
          height: 30,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => const Notifications());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset(ImageAssets.notification,
                  height: 24.0, width: 24.0),
            ),
          )
        ],
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(
                  Icons.menu,
                  color: AppColors.primaryColor,
                  weight: 28.0,
                ),
              ),
            );
          },
        ),
      ),
      drawer: DrawerWidget(),
      body: _pages[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: MyBottomBar(
          index: _currentIndex,
          tap: _onTabTapped,
        ),
      ),
    );
  }
}
