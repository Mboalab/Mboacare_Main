import 'package:flutter/material.dart';
import 'package:mboacare/notifications/notification_card.dart';

import 'notification_data.dart';
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
  centerTitle: true,
  title: const Text('Notifications'),
),
      body:  Column(
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
