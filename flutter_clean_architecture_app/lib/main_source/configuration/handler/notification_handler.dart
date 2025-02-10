import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flearn/main_source/common_src/utils/notification_utils.dart';
import 'package:flearn/main_source/common_src/utils/validation_utils.dart';
import 'package:flutter/foundation.dart';

class NotificationHandler {
  static void showNotification(RemoteMessage message) {
    debugPrint("Background Notification received ");
    debugPrint('Msg DATA: ${message.data}');
    debugPrint('Msg Notification: ${message.notification?.body}');
    debugPrint('*****************************************');

    String orderId = message.data['orderId'];
    String orderGroupId = message.data['orderGroupId'];
    String notificationType = message.data['notificationType'];
    String message_ = message.data['message'];
    String title = message.data['title'];
    String imageUrl = Platform.isAndroid
        ? message.notification?.android?.imageUrl ?? ''
        : Platform.isIOS
            ? message.notification?.apple?.imageUrl ?? ''
            : '';

    debugPrint("RDX=====> _firebaseOnMessage $message_ ::: OrderID: $orderId - orderGroupId: $orderGroupId ");

    String singleOrGroupOrderId = !ValidationUtils.isEmpty(message.data['orderGroupId']) ? '${message.data['orderGroupId']}' : '${message.data['orderId']}';
    String payload = '{"NotificationType":"$notificationType","orderId":"$singleOrGroupOrderId","title":"$title","description":"${message_.replaceAll('"', '\\"')}","image":"$imageUrl"}';

    NotificationUtils.showNotification(notificationType: notificationType, id: Random().nextInt(1000), title: title, body: message_, payload: payload);
  }
}
