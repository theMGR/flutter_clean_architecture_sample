import 'package:flearn/main_source/configuration/config/notification_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  static void showNotification({int id = 0, String? title, String? body, String? payload, required String notificationType}) {
    showFlutterLocalNotification(
      channelId: getChannelID(notificationType),
      channelName: getChannelName(notificationType),
      channelDescription: getChannelDesc(notificationType),
      androidSound: getSound(notificationType),
      iosSound: getIOSSound(notificationType),
      id: id,
      title: title,
      body: body,
      payload: payload,
    );
  }

  static getChannelID(String notificationType) {
    switch (notificationType) {
      case "1":
        return "CA";
      case "2":
        return "CA_WON";
      default:
        return "LOAD_OFFER_DECLINE";
    }
  }

  static String getChannelName(String notificationType) {
    switch (notificationType) {
      case "1":
        return "New Auction";
      case "2":
        return "Auction Won";
      default:
        return 'CA';
    }
  }

  static String getChannelDesc(String notificationType) {
    switch (notificationType) {
      case "1":
        return "New Auction Alert";
      case "2":
        return "Auction Won";
      default:
        return 'CA';
    }
  }

  static getSound(String notificationType) {
    switch (notificationType) {
      case "1":
        return RawResourceAndroidNotificationSound('new_auction_notification');
      case "2":
        return RawResourceAndroidNotificationSound('auction_won_notification');
      default:
        return RawResourceAndroidNotificationSound('new_auction_notification');
    }
  }

  static String getIOSSound(String notificationType) {
    switch (notificationType) {
      case "1":
        return 'new_auction_notification.m4a';
      case "2":
        return 'auction_won_notification.m4a';
      default:
        return 'new_auction_notification.m4a';
    }
  }
}
