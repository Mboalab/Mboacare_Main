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
  const NotificationsPage({Key? key}) : super(key: key);

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
                Notify notification = data![index];
                return NotificationCard(
                  // onLongPress: () {
                  //   _showDialog(context, notification.id);

                  tap: () {
                    Get.to(
                        () => NotificationDetails(
                            id: notification.id,
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
}
