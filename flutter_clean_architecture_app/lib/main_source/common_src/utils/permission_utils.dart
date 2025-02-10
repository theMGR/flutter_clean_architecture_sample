import 'package:flearn/main_source/common_src/constants/keys_constant.dart';
import 'package:flearn/main_source/common_src/constants/release_constant.dart';
import 'package:flearn/main_source/common_src/constants/string_constant.dart';
import 'package:flearn/main_source/common_src/constants/value_constant.dart';
import 'package:flearn/main_source/common_src/widget_utils/ui_config.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'print_utils.dart';

class PermissionUtils {

  static void checkPermission() async{

    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Map<Permission, PermissionStatus>? appPermissions = await PermissionUtils.requestAppPermission();
      if (appPermissions != null) {
        appPermissions.forEach((Permission key, PermissionStatus value) {
          Print.info("Permission $key : $value");
          if (value == PermissionStatus.granted) {
            // do nothing
          } else {
            showOpenSettingsDialog();
          }
        });
      }
    }

  }

  static Future<bool> getAllPermissionStatusForMobile() async{

    int grantedPermission = 0;
    int totalPermission = 0;

    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Map<Permission, PermissionStatus>? appPermissions = await PermissionUtils.requestAppPermission();
      if (appPermissions != null) {
        totalPermission = appPermissions.length;
        appPermissions.forEach((Permission key, PermissionStatus value) {
          Print.info("Permission $key : $value");
          if (value == PermissionStatus.granted) {
            ++ grantedPermission;
          }
        });
      }
    }

    return totalPermission == grantedPermission;

  }

  static Future<Map<Permission, PermissionStatus>?> requestAppPermission() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      List<Permission> permissions = [];
      permissions.add(Permission.camera);
      //permissions.add(Permission.location);
      //permissions.add(Permission.locationAlways);
      //permissions.add(Permission.locationWhenInUse);
      permissions.add(Permission.mediaLibrary);
      permissions.add(Permission.phone);
      permissions.add(Permission.photos);
      permissions.add(Permission.storage);
      //permissions.add(Permission.ignoreBatteryOptimizations);
      //permissions.add(Permission.notification);
      //permissions.add(Permission.manageExternalStorage);

      for(Permission permission in permissions) {
        await permission.request();
      }

      Map<Permission, PermissionStatus> statuses = await permissions.request();

      bool? isDenied;
      statuses.forEach((Permission key, PermissionStatus value) {
        if (value == PermissionStatus.granted) {
          // do nothing
        } else {
          isDenied = true;
        }
      });

      return statuses;
    }
  }

  static void showOpenSettingsDialog() {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      String ok = "Ok";
      String cancel = "Cancel";
      String title = "Alert";
      String content = "Click \"$ok\" to Open settings to change permission";

/*      showDialog(
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text(ok),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
              TextButton(
                child: Text(cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );*/

      /*showCupertinoDialog(
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: Text(ok),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
              CupertinoDialogAction(
                child: Text(cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );*/

      UIConfig.showBlankDialogOkCancel(message: content, okFunction: () {
        Get.back();
        openAppSettings();
      });
    }
  }


  static Future<Map<Permission, PermissionStatus>?> requestCameraPermission() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      List<Permission> permissions = [];
      permissions.add(Permission.camera);
      //permissions.add(Permission.mediaLibrary);
      //permissions.add(Permission.photos);
      //permissions.add(Permission.storage);
      //permissions.add(Permission.notification);
      //permissions.add(Permission.manageExternalStorage);

      for(Permission permission in permissions) {
        await permission.request();
      }

      Map<Permission, PermissionStatus> statuses = await permissions.request();

      bool? isDenied;
      statuses.forEach((Permission key, PermissionStatus value) {
        if (value == PermissionStatus.granted) {
          // do nothing
        } else {
          isDenied = true;
        }
      });

      return statuses;
    }
  }

  static Future<bool> getStoragePermissionStatusForMobile({bool showOpenSettingsAlert = false}) async{

    int grantedPermission = 0;
    int totalPermission = 0;

    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Map<Permission, PermissionStatus>? appPermissions = await PermissionUtils.requestCameraPermission();
      if (appPermissions != null) {
        totalPermission = appPermissions.length;
        appPermissions.forEach((Permission key, PermissionStatus value) {
          Print.info("Permission $key : $value");
          if (value == PermissionStatus.granted) {
            ++ grantedPermission;
          }
        });
      }
    }

    if(showOpenSettingsAlert == true && totalPermission != grantedPermission) {
      showAlertDialogNotificationPermission(StringConstant.OBTAIN_YOUR_CAMERA_PERMISSION, StringConstant.CONFIGURE_CAMERA_ACCESS, () async {
        Get.back();
        openAppSettings();
      });
    }

    return totalPermission == grantedPermission;

  }

  static void requestNotificationPermission() async {
    if (Platform.isAndroid) {
      const String NOTIFICATION_CHANNEL = "com.tvsscs/notification";
      const MethodChannel notificationMethodChannel = MethodChannel(NOTIFICATION_CHANNEL);
      const String invokeMethodNameNotification = "requestNotificationPermission";

      bool result = await notificationMethodChannel.invokeMethod(invokeMethodNameNotification);

      if (!result) {
        notificationMethodChannel.setMethodCallHandler((call) async {
          switch (call.method) {
            case 'permissionGranted':
              // Handle permission granted
              break;
            case 'permissionDenied':
              showAlertDialogNotificationPermission(StringConstant.OBTAIN_YOUR_NOTIFICATION_PERMISSION_HOME, StringConstant.CONFIGURE_NOTIFICATION_ACCESS, () async {
                Get.back();
                openAppSettings();
              });

              result = await notificationMethodChannel.invokeMethod(invokeMethodNameNotification);

              if (result) {
                Get.back();
              }
              break;
            default:
              //throw PlatformException(code: 'NotImplemented', details: 'Method ${call.method} not implemented');
              break;
          }
        });
      }
    }
  }

  static showAlertDialogNotificationPermission(String message, String buttonText, Function onTap) {
    bool isDialogOpened = Get.isDialogOpen == null || (Get.isDialogOpen != null && !Get.isDialogOpen!) ? false : true;

    if (!isDialogOpened) {
      isDialogOpened = true;
      Get.dialog(
          WillPopScope(
              child: Center(
                child: Card(
                  margin: EdgeInsets.all(30),
                  color: Colors.black26,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: ValueConstant.Montserrat,
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        InkWell(
                          key: ValueKey(KeysConstant.alert_btn_notification_permission),
                          onTap: onTap as void Function()?,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              buttonText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: ValueConstant.Prosto,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onWillPop: () async => false),
          barrierDismissible: false);
    }
  }
}
