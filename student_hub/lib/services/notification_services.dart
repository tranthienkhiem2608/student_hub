import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(Map<String, dynamic> data) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'student_hub', 'Show Notification from student hub',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await _notificationsPlugin.show(
        0, // Notification ID
        data['title'], // Notification Title
        data['content'], // Notification Body
        platformChannelSpecifics,
        payload: 'Default_Sound');
  }
}
