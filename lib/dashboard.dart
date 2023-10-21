import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mboacare/login.dart';
import 'package:mboacare/sign_up_page.dart';
import 'package:mboacare/settingsPage/language.dart';
import 'colors.dart';
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
      const HospitalDashboard(),
      SettingsPage(context: context),
      SettingsPage(context: context),
    ];
  }

  final List<String> _screenTitles = [
    'Home',
    'Hospital Dashbord',
    'Settings',
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
      appBar: AppBar(
        title: Text(_screenTitles[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: AppColors.navbar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospital Dashbord',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
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
