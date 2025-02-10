import 'package:background_fetch/background_fetch.dart';
import 'package:flearn/main_source/configuration/di/initialize_di.dart';
import 'package:flearn/main_source/configuration/services/geofence/geofence_service.dart';
import 'package:flearn/main_source/configuration/services/location_track_transistor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:get_it/get_it.dart';

import 'common_src/constants/string_constant.dart';
import 'main_common.dart';

void main() {
  mainCommon();
  // Register your headlessTask:
  bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);

  /// Register BackgroundFetch headless-task.
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

void headlessTask(bg.HeadlessEvent headlessEvent) async {
  if (GetIt.I.isRegistered<LocationTrackByTransistor>() == true) {
    await initializeDi();
  }

  if (GetIt.I.isRegistered<LocationTrackByTransistor>() != true) {
    LocationTrackByTransistor locationTrackByTransistor = GetIt.I.get<LocationTrackByTransistor>();

    debugPrint('===HEADLESS TASK===: $headlessEvent');
    switch (headlessEvent.name) {
      case bg.Event.BOOT:
        bg.State state = await bg.BackgroundGeolocation.state;
        debugPrint("📬 didDeviceReboot: ${state.didDeviceReboot}");
        break;
      case bg.Event.TERMINATE:
        // try {
        //   bg.Location location =
        //   await bg.BackgroundGeolocation.getCurrentPosition(samples: 1);
        //   debugPrint("[getCurrentPosition] Headless: $location");
        // } catch (error) {
        //   debugPrint("[getCurrentPosition] Headless ERROR: $error");
        // }
        break;
      case bg.Event.HEARTBEAT:
        bg.HeartbeatEvent event = headlessEvent.event;
        debugPrint('===HEARTBEAT_FROM_BACKGROUND===$event');
        if (event.location != null) {
          event.location!.sample = true;
          await locationTrackByTransistor.updateDriverStatusByTransistor(
              latitude: event.location!.coords.latitude,
              longitude: event.location!.coords.longitude,
              isMoving: event.location!.isMoving,
              locationActivityType: event.location!.activity.type,
              isCharging: event.location!.battery.isCharging,
              battery: event.location!.battery.level.toString(),
              speed: event.location!.coords.speed.toString(),
              event: event.location!.event,
              mobileMode: 'Background-Kill State');
        } else {
          debugPrint('===BACKGROUND_HEART_BEAT_LOCATION_NULL===');
          bg.BackgroundGeolocation.getCurrentPosition(
            samples: 1,
          ).then((Location location) async {
            debugPrint('===GET_CURRENT_LOCATION_BACKGROUND===${location}');
          });
        }
        break;
      case bg.Event.LOCATION:
        bg.Location location = headlessEvent.event;
        debugPrint('===LOCATION_FROM_BACKGROUND===$location');
        location.sample = true;
        if (location.activity.type != StringConstant.bgStill) {
          await locationTrackByTransistor.updateDriverStatusByTransistor(
              latitude: location.coords.latitude,
              longitude: location.coords.longitude,
              isMoving: location.isMoving,
              locationActivityType: location.activity.type,
              isCharging: location.battery.isCharging,
              battery: location.battery.level.toString(),
              speed: location.coords.speed.toString(),
              event: location.event.isNotEmpty ? location.event : 'location',
              mobileMode: 'Background-Kill State');
        }
        break;
      case bg.Event.MOTIONCHANGE:
        bg.Location location = headlessEvent.event;
        location.sample = true;
        debugPrint('===ON_MOTION_CHANGE_BACKGROUND===$location');
        break;
      case bg.Event.ACTIVITYCHANGE:
        bg.ActivityChangeEvent event = headlessEvent.event;
        debugPrint('===ON_ACTIVITY_CHANGE_BACKGROUND===$event');
        break;
      case bg.Event.POWERSAVECHANGE:
        bool enabled = headlessEvent.event;
        debugPrint('===ON_POWER_CHANGE_BACKGROUND=== $enabled');
        break;
      case bg.Event.CONNECTIVITYCHANGE:
        bg.ConnectivityChangeEvent event = headlessEvent.event;
        debugPrint('===ON_CONNECTIVITY_CHANGE_BACKGROUND===$event');
        if (event.connected) {
          bg.BackgroundGeolocation.getCurrentPosition(
            samples: 1,
          ).then((Location location) async {
            debugPrint('===GET_CURRENT_LOCATION_FOREGROUND===${location}');
            await locationTrackByTransistor.updateDriverStatusByTransistor(
              latitude: location.coords.latitude,
              longitude: location.coords.longitude,
              isMoving: location.isMoving,
              locationActivityType: location.activity.type,
              isCharging: location.battery.isCharging,
              battery: location.battery.level.toString(),
              speed: location.coords.speed.toString(),
              event: location.event,
              mobileMode: 'Connectivity Change Background-Kill State',
            );
          });
        }
        break;
      case bg.Event.ENABLEDCHANGE:
        bool enabled = headlessEvent.event;
        debugPrint('===ON_ENABLED_CHANGE_BACKGROUND===$enabled');
        break;
      case bg.Event.PROVIDERCHANGE:
        bg.ProviderChangeEvent event = headlessEvent.event;
        debugPrint('===ON_PROVIDER_CHANGE_FOREGROUND===$event');
        break;
    }
  }
}

Future<void> backgroundFetchHeadlessTask(HeadlessTask task) async {
  if (GetIt.I.isRegistered<GeofenceService>() != true) {
    await initializeDi();
  }

  if (GetIt.I.isRegistered<GeofenceService>() == true) {
    GeofenceService geofenceService = GetIt.I.get<GeofenceService>();
    String taskId = task.taskId;
    // Is this a background_fetch timeout event?  If so, simply #finish and bail-out.
    if (task.timeout) {
      print("[BackgroundFetch] HeadlessTask TIMEOUT: $taskId");
      BackgroundFetch.finish(taskId);
      return;
    }

    debugPrint("[BackgroundFetch] HeadlessTask: $taskId");

    try {
      var location = await bg.BackgroundGeolocation.getCurrentPosition(samples: 1, extras: {"event": "background-fetch", "headless": true});
      debugPrint("+++[MainConfig-background-fetch] $location");
      geofenceService.geofence(
        location.coords.latitude,
        location.coords.longitude,
      );
    } catch (error) {
      debugPrint("[location] ERROR: $error");
    }

    /*SharedPreferences prefs = await SharedPreferences.getInstance();
  int count = 0;
  if (prefs.get("fetch-count") != null) {
    count = prefs.getInt("fetch-count")!;
  }
  prefs.setInt("fetch-count", ++count);
  print('[BackgroundFetch] count: $count');*/

    BackgroundFetch.finish(taskId);
  }
}
