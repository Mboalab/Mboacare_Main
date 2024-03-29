import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mboacare/app_modules/user/screens/dashboard/hospital.dart';

import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/apis.dart';
import 'package:mboacare/utils/router.dart';
import 'package:mboacare/widgets/home_navigation_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/sign_up_page.dart';
import '../../../user/screens/dashboard/blog_page.dart';
import 'hospital/add_hopital.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
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
                      iconImage: ImageAssets.hospital,
                      onTap: () {
                        PageNavigator(ctx: context).nextPageOnly(
                            page: AddHospitalPage(
                          placeName: '',
                          lat: 0.0,
                          lng: 0.0,
                        ));
                        //Get.to(() => const SignUpPage());
                      },
                    ),
                    HomeNavigationItems(
                      title: 'Facilities',
                      subtitle: 'Browse through facilities',
                      iconImage: ImageAssets.hospital,
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPageOnly(page: const HospitalDashboard());
                      },
                    ),
                    HomeNavigationItems(
                      title: 'Blog',
                      subtitle: 'Read blog posts',
                      iconImage: ImageAssets.blog,
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPageOnly(page: const BlogPage());
                      },
                    ),
                    HomeNavigationItems(
                      title: 'Community',
                      subtitle: 'Join the Mboacare Community',
                      iconImage: ImageAssets.location,
                      onTap: () async {
                        // Open the LinkedIn URL in the browser
                        const url = Apis.linkIn;
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
                  ImageAssets.doctor,
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
