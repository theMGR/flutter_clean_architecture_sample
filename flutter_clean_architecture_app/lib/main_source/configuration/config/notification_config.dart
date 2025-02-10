import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flearn/main_source/common_src/flavor/flavor.dart';
import 'package:flearn/main_source/common_src/utils/notification_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;
import 'package:timezone/timezone.dart' as tz;
import 'package:path_provider/path_provider.dart';

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

//class ReceivedNotification {ReceivedNotification({required this.id, required this.title, required this.body, required this.payload,});final int id;final String? title;final String? body;final String? payload;}

String? selectedNotificationPayload;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> initializeFlutterLocalNotification() async {
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux ? null : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = HomePage.routeName; // todo
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = SecondPage.routeName; // todo
  }

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    //notificationCategories: getDarwinNotificationCategories(),
  );
  final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}

List<DarwinNotificationCategory> getDarwinNotificationCategories() {
  /// A notification action which triggers a App navigation event
  const String navigationActionId = 'id_3';

  /// Defines a iOS/MacOS notification category for text input actions.
  const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  const String darwinNotificationCategoryPlain = 'plainCategory';

  final List<DarwinNotificationCategory> darwinNotificationCategories = <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];
  return darwinNotificationCategories;
}

Future<bool> isNotificationPermissionGranted() async {
  bool isEnabled = false;
  if (Platform.isAndroid) {
    bool? granted = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();
    isEnabled = granted ?? false;
  } else if (Platform.isIOS) {
    NotificationsEnabledOptions? o = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.checkPermissions();

    if (o?.isAlertEnabled == true && o?.isBadgeEnabled == true && o?.isSoundEnabled == true) {
      isEnabled = true;
    }
  } else if (Platform.isMacOS) {
    NotificationsEnabledOptions? o = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.checkPermissions();

    if (o?.isAlertEnabled == true && o?.isBadgeEnabled == true && o?.isSoundEnabled == true) {
      isEnabled = true;
    }
  }
  return isEnabled;
}

Future<bool> requestNotificationPermissions() async {
  bool isEnabled = false;
  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    final bool? grantedNotificationPermission = await androidImplementation?.requestNotificationsPermission();
    isEnabled = grantedNotificationPermission ?? false;
  } else if (Platform.isIOS) {
    final bool? grantedNotificationPermission = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    isEnabled = grantedNotificationPermission ?? false;
  } else if (Platform.isMacOS) {
    final bool? grantedNotificationPermission = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    isEnabled = grantedNotificationPermission ?? false;
  }
  return isEnabled;
}

NotificationDetails getNotificationDetails({required String channelId, required String channelName, String? channelDescription, AndroidNotificationSound? androidSound, String? iosSound}) {
  var androidPlatformChannelSpecifies = AndroidNotificationDetails(channelId, channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      groupKey: Flavor.isPlus()
          ? 'plus'
          : Flavor.isLite()
              ? 'lite'
              : 'free',
      groupAlertBehavior: GroupAlertBehavior.all,
      priority: Priority.max,
      visibility: NotificationVisibility.public,
      color: Colors.blue,
      channelShowBadge: true,
      autoCancel: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      playSound: true,
      sound: androidSound);
  var iOSPlatformChannelSpecifics = DarwinNotificationDetails(presentAlert: true, presentSound: true, presentBadge: true, sound: iosSound);
  var notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifies, iOS: iOSPlatformChannelSpecifics);

  return notificationDetails;
}

void showFlutterLocalNotification({
  required String channelId,
  required String channelName,
  String? channelDescription,
  AndroidNotificationSound? androidSound,
  String? iosSound,
  required int id,
  String? title,
  String? body,
  String? payload,
}) {
  flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    getNotificationDetails(channelId: channelId, channelName: channelName, channelDescription: channelDescription, androidSound: androidSound, iosSound: iosSound),
  );
}

/*class NotificationUtils {
  const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

  /// A notification action which triggers a url launch event
  const String urlLaunchActionId = 'id_1';

  /// A notification action which triggers a App navigation event
  const String navigationActionId = 'id_3';

  /// Defines a iOS/MacOS notification category for text input actions.
  const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  const String darwinNotificationCategoryPlain = 'plainCategory';

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithActions() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          urlLaunchActionId,
          'Action 1',
          icon: DrawableResourceAndroidBitmap('food'),
          contextual: true,
        ),
        AndroidNotificationAction(
          'id_2',
          'Action 2',
          titleColor: Color.fromARGB(255, 255, 0, 0),
          icon: DrawableResourceAndroidBitmap('secondary_icon'),
        ),
        AndroidNotificationAction(
          navigationActionId,
          'Action 3',
          icon: DrawableResourceAndroidBitmap('secondary_icon'),
          showsUserInterface: true,
          // By default, Android plugin will dismiss the notification when the
          // user tapped on a action (this mimics the behavior on iOS).
          cancelNotification: false,
        ),
      ],
    );

    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const DarwinNotificationDetails macOSNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const LinuxNotificationDetails linuxNotificationDetails = LinuxNotificationDetails(
      actions: <LinuxNotificationAction>[
        LinuxNotificationAction(
          key: urlLaunchActionId,
          label: 'Action 1',
        ),
        LinuxNotificationAction(
          key: navigationActionId,
          label: 'Action 2',
        ),
      ],
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: macOSNotificationDetails,
      linux: linuxNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item z');
  }

  Future<void> _showNotificationWithTextAction() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'text_id_1',
          'Enter Text',
          icon: DrawableResourceAndroidBitmap('food'),
          inputs: <AndroidNotificationActionInput>[
            AndroidNotificationActionInput(
              label: 'Enter a message',
            ),
          ],
        ),
      ],
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryText,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(id++, 'Text Input Notification', 'Expand to see input action', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithIconAction() async {
    const LinuxNotificationDetails linuxNotificationDetails = LinuxNotificationDetails(
      actions: <LinuxNotificationAction>[
        LinuxNotificationAction(
          key: 'media-eject',
          label: 'Eject',
        ),
      ],
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      linux: linuxNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item z');
  }

  Future<void> _showNotificationWithTextChoice() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'text_id_2',
          'Action 2',
          icon: DrawableResourceAndroidBitmap('food'),
          inputs: <AndroidNotificationActionInput>[
            AndroidNotificationActionInput(
              choices: <String>['ABC', 'DEF'],
              allowFreeFormInput: false,
            ),
          ],
          contextual: true,
        ),
      ],
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryText,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _requestFullScreenIntentPermission() async {
    final bool permissionGranted = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestFullScreenIntentPermission() ?? false;
    // Text('Full screen intent permission granted: $permissionGranted'),
  }

  Future<void> _showFullScreenNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(0, 'scheduled title', 'scheduled body', tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(android: AndroidNotificationDetails('full screen channel id', 'full screen channel name', channelDescription: 'full screen channel description', priority: Priority.high, importance: Importance.high, fullScreenIntent: true)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _showNotificationWithNoBody() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', null, notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithNoTitle() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(id++, null, 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(--id);
  }

  Future<void> _cancelNotificationWithTag() async {
    await flutterLocalNotificationsPlugin.cancel(--id, tag: 'tag');
  }

  Future<void> _showNotificationCustomSound() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      channelDescription: 'your other channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
    );
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      sound: 'slow_spring_board.aiff',
    );
    final LinuxNotificationDetails linuxPlatformChannelSpecifics = LinuxNotificationDetails(
      sound: AssetsLinuxSound('sound/slow_spring_board.mp3'),
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
      linux: linuxPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      'custom sound notification title',
      'custom sound notification body',
      notificationDetails,
    );
  }

  Future<void> _showNotificationCustomVibrationIconLed() async {
    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('other custom channel id', 'other custom channel name',
        channelDescription: 'other custom channel description',
        icon: 'secondary_icon',
        largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);

    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'title of notification with custom vibration pattern, LED and icon', 'body of notification with custom vibration pattern, LED and icon', notificationDetails);
  }

  Future<void> _zonedScheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, 'scheduled title', 'scheduled body', tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), const NotificationDetails(android: AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _zonedScheduleAlarmClockNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        123, 'scheduled alarm clock title', 'scheduled alarm clock body', tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), const NotificationDetails(android: AndroidNotificationDetails('alarm_clock_channel', 'Alarm Clock Channel', channelDescription: 'Alarm Clock Notification')),
        androidScheduleMode: AndroidScheduleMode.alarmClock, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _showNotificationWithNoSound() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('silent channel id', 'silent channel name', channelDescription: 'silent channel description', playSound: false, styleInformation: DefaultStyleInformation(true, true));
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentSound: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  }

  Future<void> _showNotificationSilently() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker', silent: true);
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentSound: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  }

  Future<void> _showSoundUriNotification() async {
    /// this calls a method over a platform channel implemented within the
    /// example app to return the Uri for the default alarm sound and uses
    /// as the notification sound
    final String? alarmUri = await platform.invokeMethod<String>('getAlarmUri');
    final UriAndroidNotificationSound uriSound = UriAndroidNotificationSound(alarmUri!);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('uri channel id', 'uri channel name', channelDescription: 'uri channel description', sound: uriSound, styleInformation: const DefaultStyleInformation(true, true));
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'uri sound title', 'uri sound body', notificationDetails);
  }

  Future<void> _showTimeoutNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('silent channel id', 'silent channel name', channelDescription: 'silent channel description', timeoutAfter: 3000, styleInformation: DefaultStyleInformation(true, true));
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'timeout notification', 'Times out after 3 seconds', notificationDetails);
  }

  Future<void> _showInsistentNotification() async {
    // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
    const int insistentFlag = 4;
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker', additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'insistent title', 'insistent body', notificationDetails, payload: 'item x');
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _showBigPictureNotification() async {
    final String largeIconPath = await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile('https://dummyimage.com/400x800', 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath), largeIcon: FilePathAndroidBitmap(largeIconPath), contentTitle: 'overridden <b>big</b> content title', htmlFormatContentTitle: true, summaryText: 'summary <i>text</i>', htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('big text channel id', 'big text channel name', channelDescription: 'big text channel description', styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'big text title', 'silent body', notificationDetails);
  }

  Future<String> _base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  Future<void> _showBigPictureNotificationBase64() async {
    final String largeIcon = await _base64encodedImage('https://dummyimage.com/48x48');
    final String bigPicture = await _base64encodedImage('https://dummyimage.com/400x800');

    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(bigPicture), //Base64AndroidBitmap(bigPicture),
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('big text channel id', 'big text channel name', channelDescription: 'big text channel description', styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'big text title', 'silent body', notificationDetails);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<void> _showBigPictureNotificationURL() async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(await _getByteArrayFromUrl('https://dummyimage.com/48x48'));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl('https://dummyimage.com/400x800'));

    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(bigPicture, largeIcon: largeIcon, contentTitle: 'overridden <b>big</b> content title', htmlFormatContentTitle: true, summaryText: 'summary <i>text</i>', htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('big text channel id', 'big text channel name', channelDescription: 'big text channel description', styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'big text title', 'silent body', notificationDetails);
  }

  Future<void> _showBigPictureNotificationHiddenLargeIcon() async {
    final String largeIconPath = await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile('https://dummyimage.com/400x800', 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true, contentTitle: 'overridden <b>big</b> content title', htmlFormatContentTitle: true, summaryText: 'summary <i>text</i>', htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('big text channel id', 'big text channel name', channelDescription: 'big text channel description', largeIcon: FilePathAndroidBitmap(largeIconPath), styleInformation: bigPictureStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'big text title', 'silent body', notificationDetails);
  }

  Future<void> _showNotificationMediaStyle() async {
    final String largeIconPath = await _downloadAndSaveFile('https://dummyimage.com/128x128/00FF00/000000', 'largeIcon');
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: const MediaStyleInformation(),
    );
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'notification title', 'notification body', notificationDetails);
  }

  Future<void> _showBigTextNotification() async {
    const BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      htmlFormatBigText: true,
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('big text channel id', 'big text channel name', channelDescription: 'big text channel description', styleInformation: bigTextStyleInformation);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'big text title', 'silent body', notificationDetails);
  }

  Future<void> _showInboxNotification() async {
    final List<String> lines = <String>['line <b>1</b>', 'line <i>2</i>'];
    final InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines, htmlFormatLines: true, contentTitle: 'overridden <b>inbox</b> context title', htmlFormatContentTitle: true, summaryText: 'summary <i>text</i>', htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('inbox channel id', 'inboxchannel name', channelDescription: 'inbox channel description', styleInformation: inboxStyleInformation);
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'inbox title', 'inbox body', notificationDetails);
  }

  Future<void> _showMessagingNotification() async {
    // use a platform channel to resolve an Android drawable resource to a URI.
    // This is NOT part of the notifications plugin. Calls made over this
    /// channel is handled by the app
    final String? imageUri = await platform.invokeMethod('drawableToUri', 'food');

    /// First two person objects will use icons that part of the Android app's
    /// drawable resources
    const Person me = Person(
      name: 'Me',
      key: '1',
      uri: 'tel:1234567890',
      icon: DrawableResourceAndroidIcon('me'),
    );
    const Person coworker = Person(
      name: 'Coworker',
      key: '2',
      uri: 'tel:9876543210',
      icon: FlutterBitmapAssetAndroidIcon('icons/coworker.png'),
    );
    // download the icon that would be use for the lunch bot person
    final String largeIconPath = await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
    // this person object will use an icon that was downloaded
    final Person lunchBot = Person(
      name: 'Lunch bot',
      key: 'bot',
      bot: true,
      icon: BitmapFilePathAndroidIcon(largeIconPath),
    );
    final Person chef = Person(name: 'Master Chef', key: '3', uri: 'tel:111222333444', icon: ByteArrayAndroidIcon.fromBase64String(await _base64encodedImage('https://placekitten.com/48/48')));

    final List<Message> messages = <Message>[
      Message('Hi', DateTime.now(), null),
      Message("What's up?", DateTime.now().add(const Duration(minutes: 5)), coworker),
      Message('Lunch?', DateTime.now().add(const Duration(minutes: 10)), null, dataMimeType: 'image/png', dataUri: imageUri),
      Message('What kind of food would you prefer?', DateTime.now().add(const Duration(minutes: 10)), lunchBot),
      Message('You do not have time eat! Keep working!', DateTime.now().add(const Duration(minutes: 11)), chef),
    ];
    final MessagingStyleInformation messagingStyle = MessagingStyleInformation(me, groupConversation: true, conversationTitle: 'Team lunch', htmlFormatContent: true, htmlFormatTitle: true, messages: messages);
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('message channel id', 'message channel name', channelDescription: 'message channel description', category: AndroidNotificationCategory.message, styleInformation: messagingStyle);
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id, 'message title', 'message body', notificationDetails);

    // wait 10 seconds and add another message to simulate another response
    await Future<void>.delayed(const Duration(seconds: 10), () async {
      messages.add(Message("I'm so sorry!!! But I really like thai food ...", DateTime.now().add(const Duration(minutes: 11)), null));
      await flutterLocalNotificationsPlugin.show(id++, 'message title', 'message body', notificationDetails);
    });
  }

  Future<void> _showGroupedNotifications() async {
    const String groupKey = 'com.android.example.WORK_EMAIL';
    const String groupChannelId = 'grouped channel id';
    const String groupChannelName = 'grouped channel name';
    const String groupChannelDescription = 'grouped channel description';
    // example based on https://developer.android.com/training/notify-user/group.html
    const AndroidNotificationDetails firstNotificationAndroidSpecifics = AndroidNotificationDetails(groupChannelId, groupChannelName, channelDescription: groupChannelDescription, importance: Importance.max, priority: Priority.high, groupKey: groupKey);
    const NotificationDetails firstNotificationPlatformSpecifics = NotificationDetails(android: firstNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'Alex Faarborg', 'You will not believe...', firstNotificationPlatformSpecifics);
    const AndroidNotificationDetails secondNotificationAndroidSpecifics = AndroidNotificationDetails(groupChannelId, groupChannelName, channelDescription: groupChannelDescription, importance: Importance.max, priority: Priority.high, groupKey: groupKey);
    const NotificationDetails secondNotificationPlatformSpecifics = NotificationDetails(android: secondNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'Jeff Chang', 'Please join us to celebrate the...', secondNotificationPlatformSpecifics);

    // Create the summary notification to support older devices that pre-date
    /// Android 7.0 (API level 24).
    ///
    /// Recommended to create this regardless as the behaviour may vary as
    /// mentioned in https://developer.android.com/training/notify-user/group
    const List<String> lines = <String>['Alex Faarborg  Check this out', 'Jeff Chang    Launch Party'];
    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines, contentTitle: '2 messages', summaryText: 'janedoe@example.com');
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(groupChannelId, groupChannelName, channelDescription: groupChannelDescription, styleInformation: inboxStyleInformation, groupKey: groupKey, setAsGroupSummary: true);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'Attention', 'Two messages', notificationDetails);
  }

  Future<void> _showNotificationWithTag() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, tag: 'tag');
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(id++, 'first notification', null, notificationDetails);
  }

  Future<void> _checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    // Text('${pendingNotificationRequests.length} pending notification requests')
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _showOngoingNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ongoing: true, autoCancel: false);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'ongoing notification title', 'ongoing notification body', notificationDetails);
  }

  Future<void> _repeatNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('repeating channel id', 'repeating channel name', channelDescription: 'repeating description');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id++,
      'repeating title',
      'repeating body',
      RepeatInterval.everyMinute,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> _repeatPeriodicallyWithDurationNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('repeating channel id', 'repeating channel name', channelDescription: 'repeating description');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
      id++,
      'repeating period title',
      'repeating period body',
      const Duration(minutes: 5),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> _scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        _nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id', 'daily notification channel name', channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  /// To test we don't validate past dates when using `matchDateTimeComponents`
  Future<void> _scheduleDailyTenAMLastYearNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        _nextInstanceOfTenAMLastYear(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id', 'daily notification channel name', channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> _scheduleWeeklyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'weekly scheduled notification title',
        'weekly scheduled notification body',
        _nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('weekly notification channel id', 'weekly notification channel name', channelDescription: 'weekly notificationdescription'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> _scheduleWeeklyMondayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'weekly scheduled notification title',
        'weekly scheduled notification body',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('weekly notification channel id', 'weekly notification channel name', channelDescription: 'weekly notificationdescription'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> _scheduleMonthlyMondayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'monthly scheduled notification title',
        'monthly scheduled notification body',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('monthly notification channel id', 'monthly notification channel name', channelDescription: 'monthly notificationdescription'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
  }

  Future<void> _scheduleYearlyMondayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'yearly scheduled notification title',
        'yearly scheduled notification body',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('yearly notification channel id', 'yearly notification channel name', channelDescription: 'yearly notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAMLastYear() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(tz.local, now.year - 1, now.month, now.day, 10);
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.monday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _showNotificationWithNoBadge() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('no badge channel', 'no badge name', channelDescription: 'no badge description', channelShowBadge: false, importance: Importance.max, priority: Priority.high, onlyAlertOnce: true);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'no badge title', 'no badge body', notificationDetails, payload: 'item x');
  }

  Future<void> _showProgressNotification() async {
    id++;
    final int progressId = id;
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails('progress channel', 'progress channel', channelDescription: 'progress channel description', channelShowBadge: false, importance: Importance.max, priority: Priority.high, onlyAlertOnce: true, showProgress: true, maxProgress: maxProgress, progress: i);
        final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(progressId, 'progress notification title', 'progress notification body', notificationDetails, payload: 'item x');
      });
    }
  }

  Future<void> _showIndeterminateProgressNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('indeterminate progress channel', 'indeterminate progress channel',
        channelDescription: 'indeterminate progress channel description', channelShowBadge: false, importance: Importance.max, priority: Priority.high, onlyAlertOnce: true, showProgress: true, indeterminate: true);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'indeterminate progress notification title', 'indeterminate progress notification body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationUpdateChannelDescription() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your updated channel description', importance: Importance.max, priority: Priority.high, channelAction: AndroidNotificationChannelAction.update);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'updated notification channel', 'check settings to see updated channel description', notificationDetails, payload: 'item x');
  }

  Future<void> _showPublicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker', visibility: NotificationVisibility.public);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'public notification title', 'public notification body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithSubtitle() async {
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      subtitle: 'the subtitle',
    );
    const NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'title of notification with a subtitle', 'body of notification with a subtitle', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithIconBadge() async {
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(badgeNumber: 1);
    const NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'icon badge title', 'icon badge body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationsWithThreadIdentifier() async {
    NotificationDetails buildNotificationDetailsForThread(
      String threadIdentifier,
    ) {
      final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        threadIdentifier: threadIdentifier,
      );
      return NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    }

    final NotificationDetails thread1PlatformChannelSpecifics = buildNotificationDetailsForThread('thread1');
    final NotificationDetails thread2PlatformChannelSpecifics = buildNotificationDetailsForThread('thread2');

    await flutterLocalNotificationsPlugin.show(id++, 'thread 1', 'first notification', thread1PlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'thread 1', 'second notification', thread1PlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'thread 1', 'third notification', thread1PlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(id++, 'thread 2', 'first notification', thread2PlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'thread 2', 'second notification', thread2PlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'thread 2', 'third notification', thread2PlatformChannelSpecifics);
  }

  Future<void> _showNotificationWithTimeSensitiveInterruptionLevel() async {
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      interruptionLevel: InterruptionLevel.timeSensitive,
    );
    const NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'title of time sensitive notification', 'body of time sensitive notification', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithBannerNotInNotificationCentre() async {
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentBanner: true,
      presentList: false,
    );
    const NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'title of banner notification', 'body of banner notification', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationInNotificationCentreOnly() async {
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentBanner: false,
      presentList: true,
    );
    const NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'title of notification shown only in notification centre', 'body of notification shown only in notification centre', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithoutTimestamp() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, showWhen: false);
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithCustomTimestamp() async {
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
    );
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithCustomSubText() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      subText: 'custom subtext',
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithChronometer() async {
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
      usesChronometer: true,
      chronometerCountDown: true,
    );
    final NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'plain title', 'plain body', notificationDetails, payload: 'item x');
  }

  Future<void> _showNotificationWithAttachment({
    required bool hideThumbnail,
  }) async {
    final String bigPicturePath = await _downloadAndSaveFile('https://dummyimage.com/600x200', 'bigPicture.jpg');
    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      attachments: <DarwinNotificationAttachment>[
        DarwinNotificationAttachment(
          bigPicturePath,
          hideThumbnail: hideThumbnail,
        )
      ],
    );
    final NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'notification with attachment title', 'notification with attachment body', notificationDetails);
  }

  Future<void> _showNotificationWithClippedThumbnailAttachment() async {
    final String bigPicturePath = await _downloadAndSaveFile('https://dummyimage.com/600x200', 'bigPicture.jpg');
    final DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      attachments: <DarwinNotificationAttachment>[
        DarwinNotificationAttachment(
          bigPicturePath,
          thumbnailClippingRect:
              // lower right quadrant of the attachment
              const DarwinNotificationAttachmentThumbnailClippingRect(
            x: 0.5,
            y: 0.5,
            height: 0.5,
            width: 0.5,
          ),
        )
      ],
    );
    final NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id++, 'notification with attachment title', 'notification with attachment body', notificationDetails);
  }

  Future<void> _createNotificationChannelGroup() async {
    const String channelGroupId = 'your channel group id';
    // create the group first
    const AndroidNotificationChannelGroup androidNotificationChannelGroup = AndroidNotificationChannelGroup(channelGroupId, 'your channel group name', description: 'your channel group description');
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.createNotificationChannelGroup(androidNotificationChannelGroup);

    // create channels associated with the group
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(const AndroidNotificationChannel('grouped channel id 1', 'grouped channel name 1', description: 'grouped channel description 1', groupId: channelGroupId));

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(const AndroidNotificationChannel('grouped channel id 2', 'grouped channel name 2', description: 'grouped channel description 2', groupId: channelGroupId));

    // Text('Channel group with name ' '${androidNotificationChannelGroup.name} created')
  }

  Future<void> _deleteNotificationChannelGroup() async {
    const String channelGroupId = 'your channel group id';
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.deleteNotificationChannelGroup(channelGroupId);

    // Text('Channel group with id $channelGroupId deleted')
  }

  Future<void> _startForegroundService() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.startForegroundService(1, 'plain title', 'plain body', notificationDetails: androidNotificationDetails, payload: 'item x');
  }

  Future<void> _startForegroundServiceWithBlueBackgroundNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'color background channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: Colors.blue,
      colorized: true,
    );

    /// only using foreground service can color the background
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.startForegroundService(1, 'colored background text title', 'colored background text body', notificationDetails: androidPlatformChannelSpecifics, payload: 'item x');
  }

  Future<void> _stopForegroundService() async {
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.stopForegroundService();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'your channel id 2',
      'your channel name 2',
      description: 'your channel description 2',
    );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> _deleteNotificationChannel() async {
    const String channelId = 'your channel id 2';
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.deleteNotificationChannel(channelId);

    // Text('Channel with id $channelId deleted'),
  }

  Future<void> _showNotificationWithAudioAttributeAlarm() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your alarm channel id',
      'your alarm channel name',
      channelDescription: 'your alarm channel description',
      importance: Importance.max,
      priority: Priority.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification sound controlled by alarm volume',
      'alarm notification sound body',
      platformChannelSpecifics,
    );
  }
}*/
