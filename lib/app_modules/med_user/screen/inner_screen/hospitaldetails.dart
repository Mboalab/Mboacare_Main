import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/model/hospital_model/hospital_model.dart';
import 'package:mboacare/widgets/chip_widget.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/hospital_data.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'dart:developer' as devtools show log;

class HospitalDetailsPage extends StatefulWidget {
  final HospitalModel hospital;
  const HospitalDetailsPage({super.key, required this.hospital});

  @override
  State<HospitalDetailsPage> createState() => _HospitalDetailsPageState();
}

class _HospitalDetailsPageState extends State<HospitalDetailsPage> {
  String email = 'Email';

  String phone = 'Phone';

  String address = 'Address';

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
    address = widget.hospital.placeAddress!;
    email = widget.hospital.userEmail ?? '';
    phone = widget.hospital.phoneNumber ?? '';
    final specalities =
        (widget.hospital.serviceType ?? []).map((item) => item.trim()).toList();
    final facilities = (widget.hospital.facilitiesType ?? [])
        .map((item) => item.trim())
        .toList();

    final bedCapacity = widget.hospital.hospitalSize;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.navbar,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.secondaryTextColor,
              size: 25.0,
            ),
          ),
          titleSpacing: 0.0,
          title: Text(
            'Hospital Details',
            style: AppTextStyles.bodyFour
                .copyWith(fontSize: 18, color: AppColors.secondaryTextColor),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: widget.hospital.hospitalImage != ''
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.hospital.hospitalImage!,
                                  ),
                                )
                              : const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'lib/assests/images/placeholder_image.png',
                                  ),
                                )),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: MediaQuery.sizeOf(context).width * .3,
                      child: widget.hospital.website != ''
                          ? InkWell(
                              onTap: () {
                                _launchURL(widget.hospital.website!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primaryColor,
                                ),
                                padding: const EdgeInsets.all(3),
                                height: 40,
                                width: 150,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Visit Website',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.hospital.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text),
                    ),
                  )),
              const SizedBox(height: 10),
              // Email Box
              InkWell(
                onTap: () {
                  final Uri mail = Uri(path: email, scheme: 'mailto');
                  url_launcher.launchUrl(mail);
                },
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      prefixIconColor: AppColors.text,
                      hintText: email,
                      hintStyle: const TextStyle(color: AppColors.text),
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text),
                    ),
                  )),
              const SizedBox(height: 10),
              // Phone Box
              InkWell(
                onTap: () async {
                  final Uri tel = Uri(scheme: 'tel', path: phone);
                  if (await url_launcher.canLaunchUrl(tel)) {
                    await url_launcher.launchUrl(tel);
                  }
                },
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor: AppColors.text,
                      hintText: phone,
                      hintStyle: const TextStyle(color: AppColors.text),
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text),
                    ),
                  )),
              const SizedBox(height: 10),
              // Address Box
              InkWell(
                onTap: () async {
                  String query = Uri.encodeComponent(address);
                  final Uri mapAddress = Uri.parse(
                      "https://www.google.com/maps/search/?api=1&query=$query");
                  if (await url_launcher.canLaunchUrl(mapAddress)) {
                    await url_launcher.launchUrl(mapAddress);
                  }
                },
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      prefixIconColor: AppColors.text,
                      hintText: address,
                      hintStyle: const TextStyle(color: AppColors.text),
                      labelStyle:
                          const TextStyle(color: AppColors.primaryColor),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  child: Text(
                    'Services And Facilities',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  child: Text(
                    'Services Offered : ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.text,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: specalities.map((item) {
                      return ChipWidget(item);
                    }).toList()),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  child: Text(
                    'Facilities : ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.text,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: facilities.isNotEmpty
                      ? Wrap(
                          runSpacing: 5,
                          spacing: 5,
                          children: facilities.map((item) {
                            return ChipWidget(item);
                          }).toList())
                      : Container()),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  child: Text(
                    'Emergency Services : ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.text,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: emergency!.isNotEmpty
              //         ? Wrap(
              //             runSpacing: 5,
              //             spacing: 5,
              //             children: emergency.map((item) {
              //               return ChipWidget(item);
              //             }).toList())
              //         : Container()),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  child: Text(
                    'Bed Capacity : ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.text,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: ChipWidget(bedCapacity ?? '')),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
