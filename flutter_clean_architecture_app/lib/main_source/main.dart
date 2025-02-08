import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';

import 'main_common.dart';

void main() {

  mainCommon();
  // Register your headlessTask:
  bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);

  /// Register BackgroundFetch headless-task.
  if (!Flavor.isCA()) {
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }
}



void headlessTask(bg.HeadlessEvent headlessEvent) async {
  debugPrint('===HEADLESS TASK===: $headlessEvent');
  switch(headlessEvent.name) {
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
      if(event.location!=null){
        event.location!.sample=true;
        await LocationTrackByTransistor.updateDriverStatusByTransistor(event.location!.coords.latitude,
            event.location!.coords.longitude,event.location!.isMoving,event.location!.activity.type,event.location!.battery.isCharging,
            event.location!.battery.level.toString(),event.location!.coords.speed.toString(),event.location!.event,'Background-Kill State');
      } else{
        debugPrint('===BACKGROUND_HEART_BEAT_LOCATION_NULL===');
        bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1,
        ).then((Location location) async{
          debugPrint('===GET_CURRENT_LOCATION_BACKGROUND===${location}');
        });
      }
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      debugPrint('===LOCATION_FROM_BACKGROUND===$location');
      location.sample=true;
      if(location.activity.type != StringConstant.BG_STILL){
        await LocationTrackByTransistor.updateDriverStatusByTransistor(location.coords.latitude, location.coords.longitude,
            location.isMoving,location.activity.type,location.battery.isCharging,
            location.battery.level.toString(),location.coords.speed.toString(),location.event.isNotEmpty?location.event:'location','Background-Kill State');
      }
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      location.sample=true;
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
      if(event.connected){
        bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1,
        ).then((Location location) async{
          debugPrint('===GET_CURRENT_LOCATION_FOREGROUND===${location}');
          await LocationTrackByTransistor.updateDriverStatusByTransistor(location.coords.latitude, location.coords.longitude,location.isMoving,location.activity.type,location.battery.isCharging,
              location.battery.level.toString(),location.coords.speed.toString(),location.event,'Connectivity Change Background-Kill State');
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
