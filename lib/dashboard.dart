// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mboacare/appStyles.dart';
import 'package:mboacare/login/login.dart';
import 'package:mboacare/notifications/notifications.dart';
import 'package:mboacare/sign_up/sign_up_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mboacare/blog/blog_page.dart';
import 'package:mboacare/user_profile_page.dart';
import 'package:mboacare/widgets/home_navigation_list_item.dart';
import 'colors.dart';
import 'facilities/view/screens/facilities_page.dart';
import 'settingsPage/settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hospitaldashboard.dart';
import 'widgets/drawer_widget.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;

  const DashboardScreen({required this.userName, Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late FirebaseAuth _auth;
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _initializeScreens(context); // Call the method to initialize _screens
    _checkUserVerificationStatus(); // Check user verification status
  }

  void _checkUserVerificationStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        _navigateToLoginPage(); // Always navigate to login page
      } else {
        _navigateToLoginPage();
      }
    } else {
      _navigateToLoginPage();
    }
  }

  void _navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen(title: 'Login')),
    );
  }

  void _initializeScreens(BuildContext context) {
    _screens = [
      const DashboardContent(),
      const HospitalDashboard(),
      const BlogPage(),
      const SettingsPage(),
    ];
  }

  // ignore: unused_field
  final List<String> _screenTitles = [
    'Home',
    'Hospital Dashbord',
    'Blog',
    'Profile',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onHomeTabTapped(int index) {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.registerCard,
        title: Image.asset(
          'lib/assests/images/logo.png',
          width: 30,
          height: 30,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notifications()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset('lib/assests/icons/notification.svg',
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
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.registerCard,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: AppColors.buttonColor,
          iconSize: iconSize,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/assests/icons/unselected_home.svg',
                  width: 20.0,
                  height: 20.0,
                ),
                label: 'Home',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_home.svg',
                  width: 20.0,
                  height: 20.0,
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'lib/assests/icons/unselected_hospital.svg',
                    width: 20.0,
                    height: 20.0),
                label: 'Hospitals',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_hospital.svg',
                  width: 20.0,
                  height: 20.0,
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/assests/icons/unselected_blog.svg',
                  width: 20.0,
                  height: 20.0,
                ),
                label: 'Blogs',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_blog.svg',
                  width: 20.0,
                  height: 20.0,
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/assests/icons/unselected_user.svg',
                  width: 20.0,
                  height: 20.0,
                ),
                label: 'Settings',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_user.svg',
                  width: 20.0,
                  height: 20.0,
                )),
          ],
        ),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            _buildCard(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Your Health, Simplified.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headerOne.copyWith(
                          color: AppColors.textColor2, fontSize: 35.0),
                      // TextStyle(
                      //   fontSize: 36,
                      //   fontWeight: FontWeight.w700,
                      //   fontFamily: 'Inter',
                      //   color: AppColors.textColor2,
                      // ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Discover a world of medical facilities at your fingertips with Mboacare. Connect globally, collaborate effortlessly, and improve healthcare outcomes. Join now and revolutionize the way medical professionals connect and deliver care.',
                      style: AppTextStyles.bodyThree.copyWith(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 33.0),
                    const Text(
                      'Services',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: AppColors.secondaryTextColor,
                            //Colors.black87,
                            blurRadius: 10.0,
                            offset: Offset(0, 4.0),
                          ),
                        ],
                      ),
                    ),
                    HomeNavigationItems(
                      title: 'Register medical facility',
                      subtitle: 'Want to register a medical facility?',
                      iconImage: 'lib/assests/icons/hospital.svg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                    ),
                    HomeNavigationItems(
                      title: 'Facilities',
                      subtitle: 'Browse through facilities',
                      iconImage: 'lib/assests/icons/hospital.svg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HospitalDashboard(),
                          ),
                        );
                      },
                    ),
                    HomeNavigationItems(
                      title: 'Blog',
                      subtitle: 'Read blog posts',
                      iconImage: 'lib/assests/icons/blog.svg',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BlogPage(),
                          ),
                        );
                      },
                    ),
                    HomeNavigationItems(
                      title: 'Community',
                      subtitle: 'Join the Mboacare Community',
                      iconImage: 'lib/assests/icons/location.svg',
                      onTap: () async {
                        // Open the LinkedIn URL in the browser
                        const url = 'https://www.linkedin.com/company/mboalab/';
                        final Uri uri = Uri.parse(url);
                        await launchUrl(uri);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 14.0),
      constraints: const BoxConstraints(
        maxWidth: 500,
        maxHeight: 900,
      ),
      child: Card(
        color: AppColors.cardbg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/assests/images/doctor.png',
                  height: 300,
                  width: 150,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Join the network and make a global impact in Healthcare!',
                      style: AppTextStyles.bodyOne
                          .copyWith(fontSize: 16, color: AppColors.colorWhite)
                      // TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 18,
                      //   fontFamily: 'Inter',
                      // ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
