import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/widgets/notification_card.dart';

import '../../model/notification_data.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Notify> notifications = [];
  @override
  void initState() {
    super.initState();
    _fetchBlogData();
  }

  Future<void> _fetchBlogData() async {
    List<Notify> data = await fetchNotifications();
    setState(() {
      notifications = data;
    });
  }

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationCard(
                      content: notifications[index].content,
                      title: notifications[index].title,
                      pubDate: notifications[index].pubDate,
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
