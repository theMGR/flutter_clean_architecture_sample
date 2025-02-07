import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flearn/main_source/common_src/constants/string_constant.dart';
import 'package:flearn/main_source/common_src/flavor/flavor.dart';
import 'package:flearn/main_source/common_src/flavor/flavors_type.dart';
import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';
import 'package:flearn/main_source/configuration/config/config.dart';
import 'package:flearn/main_source/configuration/services/geofence/geofence_service.dart';
import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/data/dto/user_status_dto.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flearn/main_source/domain/usecase/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:rxdart/rxdart.dart';

import 'local_data_sync_up_process.dart';

class LocationTrackByTransistor {
  final _locationStatusBehaviorSubject = BehaviorSubject<LocationStatusDto>();

  Stream<LocationStatusDto> get locationStatusStream => _locationStatusBehaviorSubject.stream;

  final GeofenceService geofenceService;
  final Prefs prefs;
  final UserStatusUpdateUseCase userStatusUpdateUseCase;
  final LocalDataSyncUpProcess localDataSyncUpProcess;

  // distanceFilter: 100 meters, stopTimeout: 5min

  bg.Config config = bg.Config(
      preventSuspend: true,
      enableHeadless: true,
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 100,
      disableElasticity: false,
      elasticityMultiplier: 4.0,
      stopOnTerminate: false,
      stationaryRadius: 10.0,
      startOnBoot: true,
      debug: false,
      stopOnStationary: false,
      stopTimeout: 5,
      disableStopDetection: Platform.isIOS ? true : false,
      pausesLocationUpdatesAutomatically: false,
      heartbeatInterval: (Flavor.isPlus() ? 60 : (Flavor.isLite() ? 90 : 120)),
      logLevel: (Flavor.get() == FlavorsType.plus || Flavor.get() == FlavorsType.lite || Flavor.get() == FlavorsType.free) ? bg.Config.LOG_LEVEL_INFO : bg.Config.LOG_LEVEL_VERBOSE,
      notification: bg.Notification(channelName: AppStrings.get().locBgNotificationChannelName(), title: AppStrings.get().liveLocationTitle(), text: StringConstant.trackingNotifyBody, priority: bg.Config.NOTIFICATION_PRIORITY_HIGH, sticky: true),
      geofenceModeHighAccuracy: true,
      showsBackgroundLocationIndicator: true);

  LocationTrackByTransistor({required this.geofenceService, required this.prefs, required this.userStatusUpdateUseCase, required this.localDataSyncUpProcess});

  Future<LocationTrackByTransistor> backgroundFetchConfig() async {
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: Platform.isIOS ? 15 : 1,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          forceAlarmManager: true,
          startOnBoot: true,
          requiredNetworkType: NetworkType.NONE,
        ),
        bgFetch);

    debugPrint('BackgroundFetch.configure status: $status');

    return this;
  }

  Future<void> registerEventListeners() async {
    // await bg.BackgroundGeolocation.removeListeners().then((value) async => await startEventListeners());
    bg.State state = await bg.BackgroundGeolocation.state;
    if (state.enabled) {
      debugPrint("===========REMOVE LISTENERS============");
      await bg.BackgroundGeolocation.removeListeners().whenComplete(() async => await startEventListeners());
    } else {
      await startEventListeners();
    }
  }

  Future<void> startEventListeners() async {
    debugPrint("===========START LISTENERS============");

    bg.BackgroundGeolocation.onActivityChange((p0) async {
      debugPrint('===ON_ACTIVITY_CHANGE_FOREGROUND===$p0');
    });
    bg.BackgroundGeolocation.onConnectivityChange((p0) async {
      debugPrint('===ON_CONNECTIVITY_CHANGE_FOREGROUND===$p0');
      if (p0.connected) {
        bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1,
        ).then((Location location) async {
          debugPrint('===GET_CURRENT_LOCATION_FOREGROUND===$location');
          await updateDriverStatusByTransistor(
            latitude: location.coords.latitude,
            longitude: location.coords.longitude,
            isMoving: location.isMoving,
            locationActivityType: location.activity.type,
            isCharging: location.battery.isCharging,
            battery: location.battery.level.toString(),
            speed: location.coords.speed.toString(),
            event: location.event,
            mobileMode: 'Connectivity Change Foreground',
          );
        });
      }
    });
    bg.BackgroundGeolocation.onEnabledChange((p0) {
      debugPrint('===ON_ENABLED_CHANGE_FOREGROUND===$p0');
    });

    bg.BackgroundGeolocation.onPowerSaveChange((p0) {
      debugPrint('===ON_POWER_CHANGE_FOREGROUND===$p0');
    });

    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      debugPrint('===ON_PROVIDER_CHANGE_FOREGROUND===$event');
    });

    bg.BackgroundGeolocation.onHeartbeat((bg.HeartbeatEvent heartbeatEvent) async {
      debugPrint('===ON_HEART_BEAT__FOREGROUND===$heartbeatEvent');
      if (heartbeatEvent.location != null) {
        heartbeatEvent.location!.sample = true;
        await updateDriverStatusByTransistor(
          latitude: heartbeatEvent.location!.coords.latitude,
          longitude: heartbeatEvent.location!.coords.longitude,
          isMoving: heartbeatEvent.location!.isMoving,
          locationActivityType: heartbeatEvent.location!.activity.type,
          isCharging: heartbeatEvent.location!.battery.isCharging,
          battery: heartbeatEvent.location!.battery.level.toString(),
          speed: heartbeatEvent.location!.coords.speed.toString(),
          event: heartbeatEvent.location!.event,
          mobileMode: 'Foreground',
        );
      } else {
        debugPrint('===FOREGROUND_HEARTBEAT_LOCATION_NULL===');
        bg.BackgroundGeolocation.getCurrentPosition(
          samples: 1,
        ).then((Location location) async {
          debugPrint('===GET_CURRENT_LOCATION_FOREGROUND===$location');
        });
      }
    });

    bg.BackgroundGeolocation.onLocation((bg.Location location) async {
      location.sample = true;
      debugPrint('==LOCATION_FOREGROUND==$location');
      if (location.activity.type != StringConstant.bgStill) {
        await updateDriverStatusByTransistor(
          latitude: location.coords.latitude,
          longitude: location.coords.longitude,
          isMoving: location.isMoving,
          locationActivityType: location.activity.type,
          isCharging: location.battery.isCharging,
          battery: location.battery.level.toString(),
          speed: location.coords.speed.toString(),
          event: location.event.isNotEmpty ? location.event : 'location',
          mobileMode: 'Foreground',
        );
      }
    });

    bg.BackgroundGeolocation.onMotionChange((bg.Location location) async {
      location.sample = true;
      debugPrint('===ON_MOTION_CHANGE_FOREGROUND===$location');
    });
  }

  Future<void> startLocationTrack() async {
    bg.BackgroundGeolocation.ready(config).then((bg.State state) {
      if (!state.enabled) {
        debugPrint('===BACKGROUND LOCATION GOING TO START===');
        bg.BackgroundGeolocation.start();
      } else {
        debugPrint('===BACKGROUND LOCATION ALREADY STARTED===');
      }
    });
  }

  Future<void> stopLocationTrack() async {
    bg.State state = await bg.BackgroundGeolocation.state;
    debugPrint('===BACKGROUND LOCATION STOPPED=== ${state.enabled}');
    if (state.enabled) {
      debugPrint('===BACKGROUND LOCATION STOPPED===');
      await bg.BackgroundGeolocation.stop().whenComplete(() async {
        await bg.BackgroundGeolocation.removeListeners();
      });
    }
  }

  Future<void> resetLocationTrack() async {
    debugPrint('===BACKGROUND LOCATION RESET===');
    bg.BackgroundGeolocation.reset(config);
  }

  Future<void> updateDriverStatusByTransistor({double? latitude, double? longitude, bool? isMoving, String? locationActivityType, bool? isCharging, String? battery, String? speed, String? event, String? mobileMode, String activeStatusTypeId = StringConstant.userActive}) async {
    if (await hasInternetConnection() == true && await getCurrentPosition() != null) {
      var userStatusDto = UserStatusDto();
      userStatusDto.longitude = double.parse(longitude!.toStringAsFixed(7));
      userStatusDto.latitude = double.parse(latitude!.toStringAsFixed(7));
      userStatusDto.activeStatusTypeId = activeStatusTypeId;
      userStatusDto.driverId = prefs.getUserId();
      userStatusDto.isMoving = isMoving;
      userStatusDto.locationActivityType = locationActivityType;
      userStatusDto.isCharging = isCharging;
      userStatusDto.battery = battery;
      userStatusDto.speed = '$speed # v${(await getApplicationInfo()).version}';
      userStatusDto.event = event;
      userStatusDto.mobileMode = mobileMode;

      userStatusUpdateUseCase.call(userStatusDto).then((result) async{
        if (result != null && result.status == 1) {
          if (_locationStatusBehaviorSubject.isClosed == false) {
            _locationStatusBehaviorSubject.sink.add(result);
          }
          await prefs.save(latitude: result.latitude, longitude: result.longitude, latLongInsertUpdateTime: result.latLongInsertUpdateTime);
          debugPrint('===LOCATION UPDATE SUCCESS===');
        } else {
          debugPrint('===LOCATION UPDATE FAILURE===');
        }
      }).catchError((e) {
        debugPrint("=====CATCH_ERROR==== $e");
      });

      if (prefs.getSyncUpStatus() != true) {
        syncLocalData();
      }
    } else {
      debugPrint("=====USER OFFLINE====");
    }
  }

  void dispose() {
    _locationStatusBehaviorSubject.close();
  }

  Future<void> syncLocalData() async {
    await localDataSyncUpProcess.getNotSyncedSavedData().then((value) async {
      localDataSyncUpProcess.pushAllSavedData();
    });
  }

  bgFetch(String taskId) async {
    try {
      var location = await bg.BackgroundGeolocation.getCurrentPosition(samples: 1, extras: {"event": "background-fetch", "headless": true});
      debugPrint("+++[Headless] ${location.coords.latitude}${location.coords.longitude}${DateTime.now().toIso8601String()}");
      //Every one min Toast showing with LatLng
      //CustomAlerts.CustomToast("+++[location] ${location.coords.latitude}${location.coords.longitude}${DateTime.now().toIso8601String()}",Get.overlayContext,duration: 5);
      //debugPrint("CurrentLocation${location.coords.latitude}${location.coords.longitude}${DateTime.now().toIso8601String()}");
      geofenceService.geofence(
        location.coords.latitude,
        location.coords.longitude,
      );
    } catch (error) {
      debugPrint("[location] ERROR: $error");
    }
    BackgroundFetch.finish(taskId);
  }
}
