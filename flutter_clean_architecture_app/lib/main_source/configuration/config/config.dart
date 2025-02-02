import 'package:dio/dio.dart';
import 'package:flearn/main_source/common_src/constants/value_constant.dart';
import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';
import 'package:flearn/main_source/configuration/app_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

var appConfiguration = AppConfiguration(
  appDisplayName: AppStrings.get().appName(),
  baseUrl: AppStrings.get().baseUrl(),
  webSocketUrl: AppStrings.get().webSocketUrl(),
  s3ImgUploadsUrl: AppStrings.get().imageUploadUrl(),
);

Future<bool> hasInternetConnection() async {
  return await InternetConnectionChecker.createInstance().hasConnection;
}

Future<Position?> getCurrentPosition() async {
  return await isLocationEnabled() == true ? await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.bestForNavigation)) : null;
}

Future<bool> isLocationEnabled() async {
  return (await Permission.location.isGranted == true || await Permission.locationWhenInUse.isGranted == true || await Permission.locationAlways.isGranted == true) && await Geolocator.isLocationServiceEnabled() ? true : false;
}

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 110,
  ),
);

Dio getDio({required String baseUrl, String? bearerToken}) => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (bearerToken != null) ...{
            ValueConstant.authorization: ValueConstant.onGetBearerToken(bearerToken),
          },
        },
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        validateStatus: (int? status) {
          return status! > 0;
        },
      ),
    );
