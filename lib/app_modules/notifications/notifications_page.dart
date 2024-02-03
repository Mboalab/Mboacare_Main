import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/app_modules/notifications/delete_notification_provider.dart';
import 'package:mboacare/app_modules/notifications/notification_details.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/appService.dart';
import 'package:mboacare/widgets/notification_card.dart';
import 'package:mboacare/widgets/shimmer_effect.dart';
import 'package:mboacare/widgets/shimmer_top.dart';
import 'package:provider/provider.dart';

import '../../model/notification_data.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({this.id, Key? key}) : super(key: key);
  final String? id;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.registerCard,
        leading: IconButton(
            color: AppColors.secondaryTextColor,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: AppTextStyles.bodyOne.copyWith(
              fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: FutureBuilder<List<Notify>>(
        future: ApiServices().fetchNotifications(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: ShimmerTop());
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Notification Available!',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text(
                'No Internet Connection!',
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                ),
              ),
            );
          }
          final data = snapshot.data;
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: data?.length,
              itemBuilder: (context, index) {
                final notification = data![index];
                return NotificationCard(
                  onLongPress: () {
                    _showDialog(context);
                  },
                  tap: () {
                    Get.to(
                        () => NotificationDetails(
                            content: notification.content,
                            title: notification.title.toString()),
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                        curve: Curves.easeInCirc,
                        transition: Transition.fadeIn);
                  },
                  content: notification.content,
                  title: notification.title,
                  pubDate: notification.pubDate,
                );
              });
        }),
      ),
    );
  }

  void _showDialog(BuildContext context) {
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
                              print(widget.id);
                              notification.deleteTheNotification(
                                  notificationId: widget.id.toString(),
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
