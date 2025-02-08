import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flearn/main_source/common_src/constants/string_constant.dart';
import 'package:flearn/main_source/configuration/config/config.dart';
import 'package:flearn/main_source/configuration/di/initialize_di.dart';
import 'package:flearn/main_source/configuration/services/location_track_transistor.dart';
import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/data/dto/user_status_dto.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flearn/main_source/domain/usecase/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationUpdateService {
  Prefs prefs;
  LocationTrackByTransistor locationTrackByTransistor;
  LocationUpdateUseCase locationUpdateUseCase;

  LocationUpdateService({required this.prefs, required this.locationTrackByTransistor, required this.locationUpdateUseCase});

  Future<void> startLocationUpdates([bool isFromNotification = false]) async {
    if (await isLocationEnabled() == false) {
      debugPrint("====GPS NOT ENABLED====");
    } else if (!await Permission.location.isGranted) {
      debugPrint("===PERMISSION NOT ENABLED====");
    } else if (Platform.isAndroid && !await Permission.locationAlways.isGranted) {
      debugPrint("===PERMISSION ALWAYS NOT ENABLED====");
    } else if (Platform.isAndroid && !await Permission.activityRecognition.isGranted) {
      debugPrint("===ACTIVITY PERMISSION ALWAYS NOT ENABLED====");
    } else if (Platform.isAndroid /*&& !await ConfigureBatteryOptimizationController.isIgnoringBatteryOptimisation()*/) {
      debugPrint("===BATTERY OPTIMISATION ENABLED====");
    } else if (await prefs.isTracking() != true) {
      debugPrint("===USER IN OFFLINE====");
    } else {
      await prefs.save(trackLocation: true);
      updateDriverStatus(true, isFromNotification);
      bg.State state = await bg.BackgroundGeolocation.state;
      debugPrint('=====STATE===========$state');
      if (!state.enabled || isFromNotification == true) {
        await locationTrackByTransistor.registerEventListeners().then((value) async => await locationTrackByTransistor.startLocationTrack());
      }
    }
  }

  Future<void> stopLocationUpdates() async {
    await prefs.save(trackLocation: false);
    await updateDriverStatus(false);
    await locationTrackByTransistor.stopLocationTrack();
  }

  Future<void> updateDriverStatus(bool isActive, [bool isFromNotification = false]) async {
    Position? position = await getCurrentPosition();
    if (position != null) {
      if (isFromNotification == true) {
        GetIt.I.reset();
        Get.deleteAll();
        await initializeDi();
      }

      locationTrackByTransistor.updateDriverStatusByTransistor(
        latitude: position.latitude,
        longitude: position.longitude,
        activeStatusTypeId: isActive ? StringConstant.userActive : StringConstant.userInActive,
        locationActivityType: 'Force update $isFromNotification',
      );
    }
  }

  Future<bool> changeDriverStatus() async {
    if (prefs.isTracking() == true) {
      await stopLocationUpdates();
    }
    var data = await Get.find<LoginRepository>().changeDriverStatus(ValueConstant.LOGIN_STATUS_VALID);
    debugPrint('Success: ${data}');
    return Future.value(data);
  }
}
