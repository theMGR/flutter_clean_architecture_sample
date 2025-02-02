import 'dart:math';

import 'package:background_fetch/background_fetch.dart';

//import 'package:courier_alliance/common/lang/translation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import 'configuration/app_config.dart';
import '../main_config/di/di_injector.dart';
import '../main_config/services/location_track_transistor.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}


void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDi();

  await Firebase.initializeApp();





  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
    var aUserID = await CustomSharedPrefs().getUserId() ?? '';
    FirebaseCrashlytics.instance.setUserIdentifier(aUserID);
  }

  //final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('RDX=====> notification payload: $payload');
    }
    selectNotificationSubject.add(payload);
  });

  try {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    runApp(CourierAlliance(config));
    print('Working BG Task ------------------------------------>');
  } catch (e) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    print('Exception ---------------------------------------->' + e.toString());
    //await customSharedPrefs.setIsBackgroundSyncUpdateIsRunning(false);
    //LocationPlusSyncUpService.startLocationService(config, true);
  }

  // WDSILocationService.init(config);

  CustomSharedPrefs customSharedPrefsL = CustomSharedPrefs();
  CustomLocationUpdates? locationUpdates = new CustomLocationUpdates(customSharedPrefsL);
  print("===LOCATION BACKGROUND RUN SERVICE FROM MAIN COMMON====");
  await locationUpdates.startLocationUpdates('from Re-Enter to App');
  if (!Flavor.isCA() && await BackgroundFetch.status != BackgroundFetch.STATUS_AVAILABLE) {
    BackgroundFetch.start();
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint('RDX=====> remote message data ${message.data.toString()}');

  await Firebase.initializeApp();
  print("================BACKGROUND NOTIFICATION======================");
  if (message.notification != null) {
    print('*****************************************');
    print("Background Notification received ");
    print('Msg DATA: ${message.data}');
    print('Msg Notification: ${message.notification!.body}');
    print('*****************************************');
    String orderId = message.data['orderId'];
    String orderGroupId = message.data['orderId'];

    if (message.data['notificationType'].toString() == '12') {
      CustomSharedPrefs customSharedPrefs = CustomSharedPrefs();
      CustomLocationUpdates? locationUpdatesNotification = new CustomLocationUpdates(customSharedPrefs);
      locationUpdatesNotification.startLocationUpdates('from Background Notification');
    } else if (message.data['notificationType'].toString() == '27') {
      var orderDetails = await CustomAppbarState.getOrderStatus(orderId, orderGroupId);
      if (orderDetails != null && orderDetails.orderId != null && orderDetails.isWaitAndReturn != 1 && orderDetails.orderStatus == StringConstant.POD && Utils.isEmpty(orderGroupId)) {
        await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderId: orderDetails.orderId);
      } else if (orderDetails != null && orderDetails.isWaitAndReturn == 1 && (orderDetails.orderStatus == StringConstant.RPOD || orderDetails.orderStatus == StringConstant.RNTC)) {
        await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderId: orderDetails.orderId);
      } else {
        if (orderDetails != null && orderDetails.orderId == null) {
          await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderGroupId: orderGroupId);
        }
      }
    }
    //No need for showing Notification manually.
    //For BackgroundMessages: Firebase automatically sends a Notification.
    //If you call the flutterLocalNotificationsPlugin.show()-Methode for
    //example the Notification will be displayed twice.
  } else {
    SaveOrdersDetailsDAO? saveOrdersDetailsDAO;
    OrdersMasterDAO ordersMasterDAO;
    var container = KiwiContainer();
    saveOrdersDetailsDAO = container<SaveOrdersDetailsDAO>();
    ordersMasterDAO = container<OrdersMasterDAO>();
    container.silent = true;
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('*****************************************');
        print("Background Message called when terminated");
        print('*****************************************');
        String aNotificationType = message.data['notificationType'].toString();
        //String orderID = message.data['orderId'].toString();
        //String orderGroupId = message.data['orderGroupId'];

        String singleOrGroupOrderId = !Utils.isEmpty(message.data['orderGroupId']) ? '${message.data['orderGroupId']}' : '${message.data['orderId']}';
        selectNotificationSubject.add('$aNotificationType,$singleOrGroupOrderId');
      }
    });
    AndroidInitializationSettings android = new AndroidInitializationSettings('@mipmap/ic_launcher'); //@mipmap/ic_launcher
    IOSInitializationSettings ios = new IOSInitializationSettings(
      // onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    var initSettings = new InitializationSettings(android: android, iOS: ios);
    var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initSettings);

    String? val = '';
    String? aNotificationType = '';
    String? orderID = '';
    String? mTitle = '';
    String? orderGroupId = '';

    val = message.data['message'];
    aNotificationType = message.data['notificationType'];
    orderID = message.data['orderId'];
    orderGroupId = message.data['orderGroupId'];
    mTitle = message.data['title'];

    print("================BACKGROUND NOTIFICATION======================");
    print('**************************************');
    print("Notification Message:" + val.toString());
    print("Notification OrderID:" + orderID.toString());
    print("Notification Type BG:" + aNotificationType!);
    print('**************************************');

    CustomSharedPrefs customSharedPrefs = CustomSharedPrefs();
    //bool isTrackingEnabled = await customSharedPrefs.getTrackUser();
    CustomLocationUpdates? locationUpdatesNotification = new CustomLocationUpdates(customSharedPrefs);

    if (aNotificationType == '8' || aNotificationType == '9') {
      int aCount = await customSharedPrefs.getNotificationCount();
      aCount++;
      customSharedPrefs.setNoticationCount(aCount);
    } else if (aNotificationType == '12') {
      //Non Trackable Notification
      locationUpdatesNotification.startLocationUpdates('from Background Notification');
    }

    var androidPlatformChannelSpecifies = new AndroidNotificationDetails(Utils.getChannelID(aNotificationType), Utils.getChannelName(aNotificationType),
        channelDescription: Utils.getChannelDesc(aNotificationType),
        importance: Importance.max,
        groupKey: Flavor.isCA() ? 'ca' : 'iex',
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
        sound: Utils.getSound(aNotificationType));
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentAlert: true, presentSound: true, presentBadge: true);
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifies, iOS: iOSPlatformChannelSpecifics);
    int random = new Random().nextInt(1000);
    List<PobPodDetailsModel> completedPob = await saveOrdersDetailsDAO.getSavedOrderDetails(orderID, StringConstant.POB);
    List<PobPodDetailsModel> completedPod = await saveOrdersDetailsDAO.getSavedOrderDetails(orderID, StringConstant.POD);

    //if(Platform.isAndroid){
    /*await flutterLocalNotificationsPlugin.show(
           count!, mTitle, val, platformChannelSpecifics,
           payload: '$aNotificationType,$OrderID');
       // Need to pass the notification type in payload while working for foreground click
       print('Displayed :${DateTime.now().millisecond}');*/
    if (Flavor.isCA() && completedPob.isNotEmpty && aNotificationType == '28') {
    } else if (Flavor.isCA() && completedPod.isNotEmpty && aNotificationType == '29') {
    } else if (aNotificationType == '27') {
      // notificationType -> 27 is for hand carry orders

      if (!Utils.isEmpty(orderGroupId) && await OrdersCheckController.get().isOrderAvailableInLocalFromNotification(orderId: orderID, orderGroupId: orderGroupId)) {
        await flutterLocalNotificationsPlugin.show(random, mTitle, val, platformChannelSpecifics, payload: '$aNotificationType,${orderGroupId == null ? orderID : orderGroupId}');
      } else if (!Utils.isEmpty(orderID) && Utils.isEmpty(orderGroupId)) {
        await flutterLocalNotificationsPlugin.show(random, mTitle, val, platformChannelSpecifics, payload: '$aNotificationType,${orderGroupId == null ? orderID : orderGroupId}');
      }

      if (await OrdersCheckController.get().isOrderAvailableInLocalFromNotification(orderId: orderID, orderGroupId: orderGroupId)) {
        var orderDetails = await CustomAppbarState.getOrderStatus(orderID!, orderGroupId ?? '');
        var orderMasterDTO = await ordersMasterDAO.getOrderDetails(orderGroupId, orderID);
        if (orderDetails != null && orderDetails.orderId != null && orderMasterDTO?.waitReturnOrder == false && orderDetails.orderStatus == StringConstant.POD && Utils.isEmpty(orderGroupId)) {
          await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderId: orderDetails.orderId);
        } else if (orderDetails != null && orderMasterDTO?.waitReturnOrder == true && (orderDetails.orderStatus == StringConstant.RPOD || orderDetails.orderStatus == StringConstant.RNTC)) {
          await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderId: orderDetails.orderId);
        } else if (orderDetails != null && orderDetails.orderId != null && orderDetails.orderStatus == StringConstant.NTC) {
          // delete NTC orders
          await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderId: orderDetails.orderId);
        } else if (orderGroupId != null) {
          // delete  group order -> hand carry for group order should be deleted : reason -> hand carry for group order not implemented in mobile
          await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderGroupId: orderGroupId);
          print("#### 563");
        } else {
          if (orderDetails != null && orderDetails.orderId == null) {
            await OrdersCheckController.get().deleteOrder(showNoOrderAlert: false, orderGroupId: orderGroupId);
          }
        }
      }
    } else {
      await flutterLocalNotificationsPlugin.show(random, mTitle, val, platformChannelSpecifics, payload: '$aNotificationType,${orderGroupId == null ? orderID : orderGroupId}');
    }
    /*if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.show(
        random, mTitle, val, platformChannelSpecifics,
        payload: '$aNotificationType,$OrderID');
  }*/
  }
  return;
}

class CourierAlliance extends StatelessWidget with WidgetsBindingObserver implements FontListener {
  final AppConfiguration config;
  static const snackBarDuration = Duration(seconds: 2);
  ValueNotifier<double> fontSize = ValueNotifier(1.0);
  DateTime? backButtonPressTime;
  CustomSharedPrefs? customSharedPrefs;
  var controller = TextEditingController();

  //Locale? _locale; //TMS

  CourierAlliance(this.config) {
    var container = KiwiContainer();
    customSharedPrefs = container<CustomSharedPrefs>();
    init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      WebSocketServer.disconnect();
    }
  }

  init() async {
    FontSizeView.init(this);
    WidgetsBinding.instance!.addObserver(this);
    var font = await customSharedPrefs!.getFontSize();
    fontSize.value = font ?? 1.0;
    //initStartUpWidget();
    //_locale = await TranslationService.getLocale(); //TMS
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: config.appDisplayName!,
          theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashView(),
          initialBinding: InitBinding(),
          getPages: AppPages.pagesList,
          /* uncomment to enable multilingual
          locale: _locale, //TMS
          supportedLocales: TranslationService.supportedLocales, //TMS
          fallbackLocale: TranslationService.fallbackLocale, //TMS
          localizationsDelegates: [ //TMS
            GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          translations: TranslationService(), //TMS
          */
          builder: (context, wid) {
            final data = MediaQuery.of(context);
            // Take the textScaleFactor from system and make
            // sure that it's no less than 1.0, but no more
            // than 1.5.
            num scale = data.textScaleFactor.clamp(1.0, 1.35);
            print('Device Size :${data.devicePixelRatio}');
            print('Size :${data.size}');
            print('Text Size :${data.textScaleFactor}');
            print('Scale :$scale');
            //todo revert 1.2 to 1.1,incase failure
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: data.textScaleFactor < 1.0 ? 1.0 : 1.2),
              child: wid!,
            );
          },
          onDispose: () {
            WebSocketServer.disconnect();
          },
        ),
        onWillPop: () => handleWillPop(context));
  }

  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed = backButtonPressTime == null || now.difference(backButtonPressTime!) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      CustomAlerts.CustomToast('Press again to exit the app', context, duration: 5);
      return false;
    }
    return true;
  }

  @override
  void setFontSize(double value) async {
    print('===================>' + value.toString());
    fontSize.value = value;
  }
}
