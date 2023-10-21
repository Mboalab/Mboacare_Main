import 'package:flutter/material.dart';
import 'package:mboacare/chip_widget.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/hospital_model.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'dart:developer' as devtools show log;

class HospitalDetailsPage extends StatefulWidget {
  final HospitalData hospital;
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

    if (url.isNotEmpty &&
        (url.startsWith('http://') || url.startsWith('https://'))) {
      try {
        final Uri uri = Uri.parse(url);
        // if (Uri) {
        await url_launcher.launchUrl(uri);
        // } else {
        //   print('Could not launch $url');
        // }
      } catch (e) {
        devtools.log('Error launching URL: $e');
      }
    } else {
      devtools.log('Invalid URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    address = widget.hospital.hospitalAddress;
    email = widget.hospital.hospitalEmail ?? '';
    phone = widget.hospital.hospitalPhone ?? '';
    final specalities = widget.hospital.hospitalSpecialities
        .split(',')
        .map((item) => item.trim())
        .toList();
    final facilities = widget.hospital.hospitalFacilities
        .split(',')
        .map((item) => item.trim())
        .toList();
    final emergency = widget.hospital.hospitalEmergencyServices
        ?.split(',')
        .map((item) => item.trim())
        .toList();
    final bedCapacity = widget.hospital.hospitalBedCapacity;
    return Scaffold(
      appBar: AppBar(title: const Text("Hospital Details")),
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
                          image: widget.hospital.hospitalImageUrl != ''
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.hospital.hospitalImageUrl,
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
                    child: GestureDetector(
                        onTap: () => _launchURL(widget.hospital.hospitalWebsite!),
                        child: widget.hospital.hospitalWebsite != ''
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.text,
                                ),
                                padding: const EdgeInsets.all(3),
                                height: 40,
                                width: 150,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   Icons.language_outlined,
                                    //   color: Colors.white,
                                    // ),
                                    // SizedBox(
                                    //   width: 10,
                                    // ),
                                    Text(
                                      'Visit Website',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container()),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.hospital.hospitalName,
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
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    prefixIconColor: AppColors.text,
                    hintText: email,
                    hintStyle: const TextStyle(color: AppColors.text),
                    labelStyle: const TextStyle(color: AppColors.primaryColor),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
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
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    prefixIconColor: AppColors.text,
                    hintText: phone,
                    hintStyle: const TextStyle(color: AppColors.text),
                    labelStyle: const TextStyle(color: AppColors.primaryColor),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
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
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    prefixIconColor: AppColors.text,
                    hintText: address,
                    hintStyle: const TextStyle(color: AppColors.text),
                    labelStyle: const TextStyle(color: AppColors.primaryColor),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
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
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: emergency!.isNotEmpty
                      ? Wrap(
                          runSpacing: 5,
                          spacing: 5,
                          children: emergency.map((item) {
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
