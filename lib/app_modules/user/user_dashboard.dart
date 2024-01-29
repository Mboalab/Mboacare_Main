// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mboacare/app_modules/notifications/notifications_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/user/screens/dashboard/blog_page.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/map_services/permision.dart';
import '../../global/styles/assets_string.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/myBottomBar.dart';
import 'screens/dashboard/home.dart';
import 'screens/dashboard/hospital.dart';
import 'screens/dashboard/settings.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;

  const DashboardScreen({required this.userName, Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void didChangeDependencies() {
    locatePosition(context);
    super.didChangeDependencies();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const HospitalDashboard(),
    const BlogPage(),
    const SettingsPage(),
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
        elevation: 0,
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
              Get.to(() => const NotificationsPage());
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
