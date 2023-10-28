// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mboacare/blog/blog_page.dart';
import 'package:mboacare/login.dart';
import 'package:mboacare/sign_up_page.dart';
import 'package:mboacare/user_profile_page.dart';
import 'colors.dart';
import 'facilities/view/screens/facilities_page.dart';
import 'settingsPage/settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hospitaldashboard.dart';

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
      FacilitiesPage(),
      HospitalDashboard(),
      //SettingsPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.registerCard,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/assests/icons/unselected_home.svg',
                ),
                label: 'Home',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_home.svg',
                  width: 35,
                  height: 35,
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    'lib/assests/icons/unselected_hospital.svg'),
                label: 'Hospitals',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_hospital.svg',
                  width: 35,
                  height: 35,
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/assests/icons/unselected_blog.svg',
                ),
                label: 'Blogs',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/selected_blog.svg',
                  width: 35,
                  height: 35,
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'lib/assests/icons/unselected_user.svg',
                ),
                label: 'Account',
                activeIcon: SvgPicture.asset(
                  'lib/assests/icons/sett.svg',
                  width: 35,
                  height: 35,
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
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
      drawer: Drawer(
        backgroundColor: Colors.white,
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
                    'lib/assests/images/user.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Janet Dolittle',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'janetdolittle@mail.com',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey),
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
                  'lib/assests/icons/home.svg',
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardContent()));
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
                  'lib/assests/icons/blog.svg',
                  color: selectedIndex == 1 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Blogs',
                  style: TextStyle(
                      color: selectedIndex == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
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
                  'lib/assests/icons/hospital.svg',
                  color: selectedIndex == 2 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Hospitals',
                  style: TextStyle(
                      color: selectedIndex == 2 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
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
                  color: selectedIndex == 3
                      ? AppColors.buttonColor
                      : Colors.transparent),
              child: ListTile(
                leading: SvgPicture.asset(
                  'lib/assests/icons/unselected_user.svg',
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: selectedIndex == 3 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
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
                style: TextStyle(fontSize: 18, color: AppColors.buttonColor),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            _buildCard(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Your Health, Simplified.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: AppColors.textColor2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Discover a world of medical facilities at your fingertips with Mboacare. Connect globally, collaborate effortlessly, and improve healthcare outcomes. Join now and revolutionize the way medical professionals connect and deliver care.',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        color: AppColors.textColor2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height: 20), // Add some space before the buttons
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the RegisterPage
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage(
                                    //title: 'mboacare',
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.cardbg,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Hospital Sign Up'),
                    ),
                    const SizedBox(
                        height: 10), // Add some space between the buttons
                    ElevatedButton(
                      onPressed: () async {
                        // Open the LinkedIn URL in the browser
                        const url = 'https://www.linkedin.com/company/mboalab/';
                        final Uri uri = Uri.parse(url);
                        await launchUrl(uri);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Join the Community'),
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
      width: 280,
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
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Join the network and make a global impact in Healthcare!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                    ),
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
