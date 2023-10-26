import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mboacare/colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
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
                              onPressed: null,
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.navbar),
                                child: SvgPicture.asset(
                                    'lib/assests/icons/whatsapp.svg'),
                              )),
                          IconButton(
                              onPressed: null,
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.navbar),
                                child: SvgPicture.asset(
                                    'lib/assests/icons/gmail.svg'),
                              )),
                          IconButton(
                              onPressed: null,
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.navbar),
                                child: SvgPicture.asset(
                                    'lib/assests/icons/instagram.svg'),
                              )),
                          IconButton(
                              onPressed: null,
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.navbar),
                                child: SvgPicture.asset(
                                  'lib/assests/icons/linkedin.svg',
                                ),
                              )),
                        ],
                      )
                    ]))));
  }
}
