import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/notifications/delete_notification_provider.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:provider/provider.dart';

class NotificationDetails extends StatefulWidget {
  const NotificationDetails(
      {Key? key, required this.id, required this.title, required this.content})
      : super(key: key);
  final String id;
  final String content;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.content,
                style: GoogleFonts.quicksand(
                    //color: AppColors.buttonColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              IconButton(
                  onPressed: () {
                    _showDialog(context, widget.id);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.deleteColor,
                    size: 24,
                  ))
            ],
          )
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 40),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 50),
          title: const Text(
            textAlign: TextAlign.center,
            "Delete Notification",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const Text(
            textAlign: TextAlign.center,
            "Are you sure you want to delete Notification?",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Consumer<DeleteNotificationProvider>(
                      builder: (context, notification, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (notification.reqMessage != '') {}
                      notification.clear();
                    });
                    return notification.isLoading
                        ? const SpinKitThreeBounce(
                            color: AppColors.cardbg,
                          )
                        : TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.cardbg),
                            ),
                            onPressed: () {
                              print(id);
                              notification.deleteTheNotification(
                                  notificationId: id.toString(),
                                  context: context);
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ));
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
