import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mboacare/global/styles/assets_string.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'dart:developer' as devtools show log;

import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Future<void> _launchURL(String url) async {
    devtools.log('Launching URL: $url');

    if (url == null || url.isEmpty) {
      devtools.log('URL is empty or null.');
      return;
    }

    // Check if the URL has the required prefix, if not, add it
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'http://$url';
    }

    try {
      final Uri uri = Uri.parse(url);
      await url_launcher.launchUrl(uri);
    } catch (e) {
      devtools.log('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                      ),
                    ),
                    const Text(
                      'About Us',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Text(
                    'Mboacare brings the world\'s best medical facilities to your \nfingertips.',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor2),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Text(
                    'Add and connect to hospitals efforetlessly and improve healthcare '
                    'outcomes. Join now and revolutionise the way medical professionals'
                    'connect and deliver care',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor2),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Have any questions?',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor2),
                    //textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await url_launcher.launchUrl(
                            Uri.parse('https://wa.me/+237696766481'),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.navbar),
                          child: SvgPicture.asset(ImageAssets.whatApp),
                        )),
                    IconButton(
                        onPressed: () {
                          final Uri mail = Uri(
                              path: 'mboacare237@gmail.com', scheme: 'mailto');
                          url_launcher.launchUrl(mail);
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.navbar),
                          child: SvgPicture.asset(ImageAssets.gmail),
                        )),
                    IconButton(
                        onPressed: () async {
                          const url = 'https://twitter.com/LabMboa';
                          final Uri uri = Uri.parse(url);
                          await url_launcher.launchUrl(uri);
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.navbar),
                          child: SvgPicture.asset(ImageAssets.instagram),
                        )),
                    IconButton(
                        onPressed: () async {
                          const url =
                              'https://www.linkedin.com/company/mboalab/';
                          final Uri uri = Uri.parse(url);
                          await url_launcher.launchUrl(uri);
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.navbar),
                          child: SvgPicture.asset(
                            ImageAssets.linkedin,
                          ),
                        )),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
