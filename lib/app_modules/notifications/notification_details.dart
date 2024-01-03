import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/global/styles/colors.dart';

class NotificationDetails extends StatefulWidget {
  const NotificationDetails(
      {Key? key, required this.title, required this.content})
      : super(key: key);
  final content;
  final String title;
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.buttonColor),
        backgroundColor: AppColors.registerCard,
        elevation: 0,
        title: Text(
          widget.title,
          style: GoogleFonts.quicksand(
            fontSize: 16,
            color: AppColors.buttonColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.buttonColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        children: [
          Text(
            widget.content,
            style: GoogleFonts.quicksand(
                //color: AppColors.buttonColor,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
