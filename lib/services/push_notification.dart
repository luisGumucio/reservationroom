import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging _fcm;

  Future initialise() async {
    _fcm = FirebaseMessaging.instance;
    _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    _listenFirebase();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('A bg message just showed up :  ${message.messageId}');
  }

  sendNotification(String message, String tokenUser) {
    Map<String, String> data = Map();
    data['message'] = message;
    _fcm.sendMessage(to: tokenUser, data: data).then((value) {
      print('good');
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  _listenFirebase() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
  }
}
