import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/model/hospital_model/hospital_model.dart';
import 'package:mboacare/services/map_services/map_provider.dart';
import 'package:mboacare/widgets/chip_widget.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/model/hospital_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'dart:developer' as devtools show log;

class HospitalDetailsPage extends StatefulWidget {
  final HospitalModel hospital;
  const HospitalDetailsPage({super.key, required this.hospital});

  @override
  State<HospitalDetailsPage> createState() => _HospitalDetailsPageState();
}

class _HospitalDetailsPageState extends State<HospitalDetailsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          MapsLauncher.launchCoordinates(
              widget.hospital.latitude as double,
              widget.hospital.longitude as double,
              widget.hospital.placeAddress);
        },
        label: const Text('Locate Hospital!'),
        icon: const Icon(Icons.location_on_outlined),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: widget.hospital.hospitalImage != ''
                              ? DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black45, BlendMode.darken),
                                  opacity: 1.0,
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
                      left: MediaQuery.sizeOf(context).width * .1,
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
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Email',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                      hintText: email,
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Phone',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                      hintText: phone,
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Address',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                    hintText: address,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.hospital.latitude as double,
                          widget.hospital.longitude as double),
                      zoom: 18.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
                  child: Text(
                    'Services And Facilities',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryTextColor,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    'Services Offered : ',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: specalities.map((item) {
                      return Align(
                          alignment: Alignment.centerLeft,
                          child: ChipWidget(item));
                    }).toList()),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    'Facilities : ',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: facilities.isNotEmpty
                      ? Wrap(
                          runSpacing: 5,
                          spacing: 5,
                          children: facilities.map((item) {
                            return Align(
                                alignment: Alignment.centerLeft,
                                child: ChipWidget(item));
                          }).toList())
                      : Container()),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text(
                    'Emergency Services : ',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    'Bed Capacity : ',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: ChipWidget(bedCapacity ?? '')),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
