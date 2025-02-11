import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flearn/main_source/configuration/handler/notification_handler.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteMessage remoteMessage = message;
  await Firebase.initializeApp();
  if(message.notification == null) {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if(message != null) {
        remoteMessage = message;
      }
    });
  }

  await _setupFlutterNotifications();
  _showFlutterNotification(remoteMessage);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${remoteMessage.messageId}');
}

Future<void> _setupFlutterNotifications() async {

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void _showFlutterNotification(RemoteMessage message) {
  NotificationHandler.showNotification(message);
}

Future<void> initializeFirebaseMessaging() async{
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}