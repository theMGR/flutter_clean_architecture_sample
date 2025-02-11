import 'package:background_fetch/background_fetch.dart';
//import 'package:courier_alliance/common/lang/translation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flearn/main_source/configuration/config/firebase_messaging_config.dart';
import 'package:flearn/main_source/configuration/config/notification_config.dart';
import 'package:flearn/main_source/configuration/services/location_update_service.dart';
import 'package:flearn/main_source/main_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'configuration/di/initialize_di.dart';
import 'data/source/local/prefs.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initializeDi();

    await Firebase.initializeApp();

    await initializeFlutterLocalNotification();
    await initializeFirebaseMessaging();

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }

    if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled && GetIt.I.isRegistered<Prefs>() == true && GetIt.I.get<Prefs>().getUserId() != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(GetIt.I.get<Prefs>().getUserId() ?? '');
    }

    if (GetIt.I.isRegistered<LocationUpdateService>() == true) {
      LocationUpdateService locationUpdateService = GetIt.I.get<LocationUpdateService>();
      debugPrint("===LOCATION BACKGROUND RUN SERVICE FROM MAIN COMMON====");
      await locationUpdateService.startLocationUpdates();
      if (await BackgroundFetch.status != BackgroundFetch.STATUS_AVAILABLE) {
        BackgroundFetch.start();
      }
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(MainPage(notificationAppLaunchDetails: await getNotificationAppLaunchDetails()));
  } catch (e) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    debugPrint('Exception ----------------------------------------> $e');
  }
}
