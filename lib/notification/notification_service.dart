import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'prolife_service_chanel_id',
    'Prolife Service Channel',
    description: 'This channel is used for ProLife service notifications.',
    importance: Importance.max,
  );

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Fluttertoast.showToast(msg: "Notification permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Fluttertoast.showToast(msg: "️ Provisional permission granted");
    } else {
      Fluttertoast.showToast(msg: "Notification permission denied");
    }
  }

  Future<void> initNotificationHandlers(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground message: ${message.notification?.title}");
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification opened (background): ${message.data}");
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint("App launched by notification: ${initialMessage.data}");
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'prolife_service_chanel_id',
      'Prolife Service Channel',
      channelDescription: 'Used for important service notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformDetails,
    );
  }
}
