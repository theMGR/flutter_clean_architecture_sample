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
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import 'local_data_service.dart';

class LocationTrackByTransistor {
  final _locationStatusBehaviorSubject = BehaviorSubject<LocationStatusDto>();

  Stream<LocationStatusDto> get locationStatusStream => _locationStatusBehaviorSubject.stream;

  final GeofenceService geofenceService;
  final Prefs prefs;

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

  LocationTrackByTransistor(this.geofenceService, this.prefs);

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
            location.coords.latitude,
            location.coords.longitude,
            location.isMoving,
            location.activity.type,
            location.battery.isCharging,
            location.battery.level.toString(),
            location.coords.speed.toString(),
            location.event,
            'Connectivity Change Foreground',
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
          heartbeatEvent.location!.coords.latitude,
          heartbeatEvent.location!.coords.longitude,
          heartbeatEvent.location!.isMoving,
          heartbeatEvent.location!.activity.type,
          heartbeatEvent.location!.battery.isCharging,
          heartbeatEvent.location!.battery.level.toString(),
          heartbeatEvent.location!.coords.speed.toString(),
          heartbeatEvent.location!.event,
          'Foreground',
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
          location.coords.latitude,
          location.coords.longitude,
          location.isMoving,
          location.activity.type,
          location.battery.isCharging,
          location.battery.level.toString(),
          location.coords.speed.toString(),
          location.event.isNotEmpty ? location.event : 'location',
          'Foreground',
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

  Future<void> updateDriverStatusByTransistor(double? lat, double? long, bool? isMoving, String? activitytype, bool? isCharging, String? battery, String? speed, String? event, String? mobileMode) async {
    KiwiContainer container = KiwiContainer();
    GeofenceService geofenceService = new GeofenceService();
    //var customLocationUpdates = container<CustomLocationUpdates>();
    CustomSharedPrefs customSharedPrefs = CustomSharedPrefs();
    var customLocationUpdates = new CustomLocationUpdates(customSharedPrefs);
    var driverStatusModel = new DriverStatusModel();
    var appVersion = await Utils.getApplicationInfo();
    if (customLocationUpdates == null) {
      customLocationUpdates = new CustomLocationUpdates(customSharedPrefs);
    }
    try {
      container.clear();
    } on Exception catch (e) {
      debugPrint('==KIWI_ERROR==$e');
    }
    await diConfig(null, baseUrl: AppStrings.get()!.baseUrl, webSocketUrl: AppStrings.get()!.webSocketUrl, s3ImgUploadUrl: AppStrings.get()!.s3ImgUploadUrl, vahanApiUrl: AppStrings.get()!.vahanApiUrl);
    container.silent = true;
    await customSharedPrefs.getRefresh();

    if (await hasInternetConnection() == true && await getCurrentPosition() != null) {
      driverStatusModel.longitude = double.parse(long!.toStringAsFixed(7));
      driverStatusModel.latitude = double.parse(lat!.toStringAsFixed(7));
      driverStatusModel.tblStatusTypesId = StringConstant.DRIVER_ACTIVE;
      driverStatusModel.driverId = await customSharedPrefs.getUserId();
      driverStatusModel.isMoving = isMoving;
      driverStatusModel.activitytype = activitytype;
      driverStatusModel.isCharging = isCharging;
      driverStatusModel.battery = battery;
      driverStatusModel.speed = '$speed # v${appVersion.version}';
      driverStatusModel.event = event;
      driverStatusModel.mobileMode = mobileMode;
      Get.lazyPut(() => UpdateDriverStatusUseCase());
      var result = await Get.find<UpdateDriverStatusUseCase>().execute(driverStatusModel).catchError((e) {
        debugPrint("=====CATCH_ERROR====$e");
      });

      if (result != null && result.status == 1) {
        if (!driverInfo.isClosed) driverInfo.sink.add(result);

        if (_locationStatusBehaviorSubject.isClosed == false) {
          _locationStatusBehaviorSubject.sink.add(result);
        }
        customSharedPrefs.saveDriverLastLocation(result.latitude, result.longitude, result.latLongInsertUpdateTime);
        debugPrint('===LOCATION UPDATE SUCCESS===');
      } else {
        debugPrint('===LOCATION UPDATE FAILURE===');
      }

      await customSharedPrefs.getRefresh();
      if (await customSharedPrefs.getSyncUpStatus() != true) {
        syncLocalData(customSharedPrefs, container);
      }
    } else {
      debugPrint("=====USER OFFLINE====");
    }
  }

  void dispose() {
    _locationStatusBehaviorSubject.close();
  }

  syncLocalData() async {
    if (GetIt.I.isRegistered<MySharedPref>() == true && GetIt.I.isRegistered<LocalDataService>() == true) {
      await GetIt.I<MySharedPref>().reload();

      await GetIt.I<LocalDataService>().getNotSyncedSavedData().then((value) async {
        GetIt.I<LocalDataService>().pushAllSavedData();
      });
    }
  }

  bgFetch(String taskId) async {
    try {
      GeofenceService geofenceService = new GeofenceService();
      var location = await bg.BackgroundGeolocation.getCurrentPosition(samples: 1, extras: {"event": "background-fetch", "headless": true});
      debugPrint("+++[Headless] ${location.coords.latitude}${location.coords.longitude}${DateTime.now().toIso8601String()}");
      //Every one min Toast showing with LatLng
      //CustomAlerts.CustomToast("+++[location] ${location.coords.latitude}${location.coords.longitude}${DateTime.now().toIso8601String()}",Get.overlayContext,duration: 5);
      //debugPrint("CurrentLocation${location.coords.latitude}${location.coords.longitude}${DateTime.now().toIso8601String()}");
      if (location != null) {
        if (!Flavor.isCA()) {
          geofenceService.geofence(
            location.coords.latitude,
            location.coords.longitude,
          );
        }
      }
    } catch (error) {
      debugPrint("[location] ERROR: $error");
    }
    BackgroundFetch.finish(taskId);
  }
}
