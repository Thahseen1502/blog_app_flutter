import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffB81736),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          text: const TextSpan(
            text: 'Blog',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff2B1836),
            ),
            children: [
              TextSpan(
                text: 'Spot',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear_all,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement clear all notifications
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(notification: notification);
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: notification.isRead
          ? Colors.white
          : Color(0xFFFFF5E1), // Unread notifications have a light color
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFAA61A), // Same accent color
          child: Icon(notification.icon, color: Colors.white),
        ),
        title: Text(
          notification.message,
          style: TextStyle(
            fontWeight:
                notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(notification.timestamp),
        trailing: notification.isRead
            ? null
            : Icon(Icons.fiber_new,
                color: Color(0xFFFAA61A)), // New notification indicator
        onTap: () {
          // Handle notification click, mark as read, etc.
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String message;
  final String timestamp;
  final bool isRead;

  NotificationItem({
    required this.icon,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });
}

// Sample notifications list
final List<NotificationItem> notifications = [
  NotificationItem(
    icon: Icons.comment,
    message: "John commented on your blog post",
    timestamp: "2h ago",
    isRead: false,
  ),
  NotificationItem(
    icon: Icons.thumb_up,
    message: "Alice liked your blog post",
    timestamp: "4h ago",
    isRead: true,
  ),
  NotificationItem(
    icon: Icons.person_add,
    message: "You have a new follower",
    timestamp: "1d ago",
    isRead: false,
  ),
];
