import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:flearn/f_praticals/source/constants/color_constants.dart';
import 'package:flearn/f_praticals/source/constants/release_constant.dart';
import 'package:flearn/f_praticals/source/constants/string_constants.dart';
import 'package:flearn/f_praticals/source/core/utils/permission_utils.dart';
import 'package:flearn/f_praticals/source/core/utils/ui_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

//IMAGE -> gallery
enum TYPE { CAMERA, VIDEO, IMAGE, MULTI_IMAGE, PICK_FILE, PICK_FILES, CAMERA_MULTI_IMAGE, CAMERA_IMAGE}

class FilePickerUtils {
  static List<String> IMAGE = ["jpg", "png", "jpeg"];
  static List<String> PDF = ["pdf"];
  static List<String> AUDIO = ["mp3"];
  static List<String> VIDEO = ["mp4", "mpeg"];

  static void pickFiles({required BuildContext context,
    TYPE type = TYPE.PICK_FILE,
    bool allowCompression = false,
    FileType fileType = FileType.any,
    List<String> customExtensions = const [],
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    double? maxWidth = 800,
    double? maxHeight = 800,
    Duration? maxDuration,
    int imageQualityForImageVideoPicker = 80,
    Function(List<File>)? onSelectedFiles,
    Function(List<XFile>?)? onSelectedXFiles,
    bool imageCrop = true}) async {
    //
    bool? isPermissionEnabled = await PermissionUtils.getStoragePermissionStatusForMobile();
    if (isPermissionEnabled) {
      List<File> files = [];
      if (type == TYPE.PICK_FILE || type == TYPE.PICK_FILES) {
        bool allowMultiple = type == TYPE.PICK_FILES ? true : false;
        FilePickerResult? result;
        if (fileType == FileType.custom && customExtensions.isNotEmpty) {
          result = await FilePicker.platform
              .pickFiles(type: fileType, allowCompression: allowCompression, allowMultiple: allowMultiple, allowedExtensions: customExtensions);
        } else {
          result = await FilePicker.platform.pickFiles(type: fileType, allowCompression: allowCompression, allowMultiple: allowMultiple);
        }

        if (result != null && result.files.isNotEmpty) {
          if (allowMultiple) {
            //List<File> _files = result.paths.map((path) => File(path!)).toList();
            List<PlatformFile> _listPlatformFiles = result.files;
            List<File> _files = [];
            for (int i = 0; i < _listPlatformFiles.length; i++) {
              _files.add(File(_listPlatformFiles[i].path!));
            }
            //
            files = [];
            files.addAll(_files);
            //
          } else {
            PlatformFile _platformFile = result.files.first;
            File _file = File(_platformFile.path!);
            //
            files = [];
            files.add(_file);
            //

            // Print.Reference(_platformFile.name);
            // Print.Reference(_platformFile.bytes ?? "");
            // Print.Reference(_platformFile.size);
            // Print.Reference(_platformFile.extension ?? "");
            // Print.Reference(_platformFile.path ?? "");
          }
        }
      } else {
        final ImagePicker imagePicker = ImagePicker();
        List<XFile>? xFiles = [];

        if (type == TYPE.CAMERA) {
          if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
            XFile? xFile = await imagePicker.pickImage(
                source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQualityForImageVideoPicker, maxHeight: maxHeight, maxWidth: maxWidth);

            if (xFile != null) {
              xFiles = [];

              if(imageCrop) {
                CroppedFile? croppedFile = await getCroppedFile(
                    sourcePath: xFile.path,
                    maxHeight: maxHeight.toInt(),
                    maxWidth: maxWidth.toInt(),
                    compressQuality: imageQualityForImageVideoPicker);

                if(croppedFile != null) {
                  xFiles.add(XFile(croppedFile.path));
                }
              } else {
                xFiles.add(xFile);
              }
            }
          } else {
            XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQualityForImageVideoPicker);
            if (xFile != null) {
              xFiles = [];

              if(imageCrop) {
                CroppedFile? croppedFile = await getCroppedFile(
                    sourcePath: xFile.path,
                    maxHeight: maxHeight!.toInt(),
                    maxWidth: maxWidth!.toInt(),
                    compressQuality: imageQualityForImageVideoPicker);
                if (croppedFile != null) {
                  xFiles.add(XFile(croppedFile.path));
                }
              } else {
                xFiles.add(xFile);
              }
            }
          }
        } else if (type == TYPE.VIDEO) {
          if (maxDuration != null && maxDuration.inSeconds > 0) {
            XFile? xFile = await imagePicker.pickVideo(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, maxDuration: maxDuration);
            if (xFile != null) {
              xFiles = [];
              xFiles.add(xFile);
            }
          } else {
            XFile? xFile = await imagePicker.pickVideo(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice);
            if (xFile != null) {
              xFiles = [];
              xFiles.add(xFile);
            }
          }
        } if (type == TYPE.IMAGE) {
          if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
            XFile? xFile = await imagePicker.pickImage(
                source: ImageSource.gallery, imageQuality: imageQualityForImageVideoPicker, maxHeight: maxHeight, maxWidth: maxWidth);

            if (xFile != null) {
              xFiles = [];

              if(imageCrop) {
                CroppedFile? croppedFile = await getCroppedFile(
                    sourcePath: xFile.path,
                    maxHeight: maxHeight.toInt(),
                    maxWidth: maxWidth.toInt(),
                    compressQuality: imageQualityForImageVideoPicker);
                if (croppedFile != null) {
                  xFiles.add(XFile(croppedFile.path));
                }
              } else {
                xFiles.add(xFile);
              }
            }
          } else {
            XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: imageQualityForImageVideoPicker);
            if (xFile != null) {
              xFiles = [];

              if(imageCrop) {
                CroppedFile? croppedFile = await getCroppedFile(
                    sourcePath: xFile.path,
                    maxHeight: maxHeight!.toInt(),
                    maxWidth: maxWidth!.toInt(),
                    compressQuality: imageQualityForImageVideoPicker);
                if (croppedFile != null) {
                  xFiles.add(XFile(croppedFile.path));
                }
              } else {
                xFiles.add(xFile);
              }
            }
          }
        } else if (type == TYPE.MULTI_IMAGE) {
          if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
            xFiles = await imagePicker.pickMultiImage(maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: imageQualityForImageVideoPicker);
          } else {
            xFiles = await imagePicker.pickMultiImage(imageQuality: imageQualityForImageVideoPicker);
          }
        } else if (type == TYPE.CAMERA_MULTI_IMAGE) {
          xFiles = await _showCameraMultiImageDialog(
              xFiles: xFiles,
              context: context,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
              imagePicker: imagePicker,
              imageQualityForImageVideoPicker: imageQualityForImageVideoPicker,
              preferredCameraDevice: preferredCameraDevice);
        }  else if (type == TYPE.CAMERA_IMAGE) {
          xFiles = await _showCameraImageDialog(
              xFiles: xFiles,
              context: context,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
              imagePicker: imagePicker,
              imageQualityForImageVideoPicker: imageQualityForImageVideoPicker,
              preferredCameraDevice: preferredCameraDevice,
              imageCrop: imageCrop);
        }

        if (xFiles != null && xFiles.isNotEmpty) {
          files = [];
          for (int i = 0; i < xFiles.length; i++) {
            File cacheFile = File(xFiles[i].path);

            Uint8List? result = await cacheFile.readAsBytes();
            File? file = await saveFile("file_picker_${DateTime.now()}${type == TYPE.VIDEO ? '.mp4' : '.png'}", result);
            if (file != null) {
              deleteFile(cacheFile.path);
              files.add(file);

              // Print.Reference("path : ${file.path}");
              // Print.Reference("mime type: ${getMimeType(file.path)}");
              // Print.Reference("file size: ${await getFileSizeUsingFile(file: file)}");
            }
          }
        }
        if(onSelectedXFiles != null) {
          onSelectedXFiles(xFiles);
        }
      }
      if(onSelectedFiles != null) {
        onSelectedFiles(files);
      }

    } else {
      PermissionUtils.showAlertDialogNotificationPermission(StringConstant.OBTAIN_YOUR_CAMERA_PERMISSION, StringConstant.CONFIGURE_CAMERA_ACCESS, () async {
        Get.back();
        openAppSettings();
      });
    }
  }

  static Future<CroppedFile?> getCroppedFile({required String sourcePath, int? maxHeight, int? maxWidth, int compressQuality = 90}) async {
    List<CropAspectRatioPreset> aspectRatioPresets = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
    ];

    AndroidUiSettings androidUiSettings = AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: ColorConstant.Btn_color,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false);

    IOSUiSettings iosUiSettings = IOSUiSettings(minimumAspectRatio: 1.0, title: 'Cropper');

    return await ImageCropper().cropImage(
        sourcePath: sourcePath,
        //aspectRatioPresets: aspectRatioPresets,
        uiSettings: [androidUiSettings, iosUiSettings],
        compressFormat: ImageCompressFormat.png,
        maxHeight: maxWidth != null && maxWidth < 800 ? 800 : maxWidth,
        maxWidth: maxWidth != null && maxWidth < 800 ? 800 : maxWidth,
        compressQuality: compressQuality < 80 ? 80 : compressQuality);
  }

  static Future<String> getFileSizeUsingPath({required String filePath, int decimals = 0}) async {
    if (filePath.isNotEmpty && filePath.trim().length > 0) {
      File file = File(filePath);
      int bytes = await file.length();
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1000)).floor();
      return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
    } else {
      return "0 B";
    }
  }

  static Future<String> getFileSizeUsingFile({required File file, int decimals = 0}) async {
    if (file.path.isNotEmpty && file.path.trim().length > 0) {
      int bytes = await file.length();
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1000)).floor();
      return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
    } else {
      return "0 B";
    }
  }

  static Future<String> getFileSizeFromBytes({required int bytes, int decimals = 0}) async {
    if (bytes >= 0) {
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1000)).floor();
      return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
    } else {
      return "0 B";
    }
  }

  static int getDownloadUploadPercentage({int count = 0, int total = 0}) {
    return (100 * count) ~/ total;
  }

  static Future<File?> saveFile(String fileName, List<int> bytes) async {
    /*
    getApplicationDocumentsDirectory():
    Gives path to the directory where Application can place it’s private files, Files only get wiped out when application itself removed.
    iOS – NSDocumentsDirectory API.
    Android – returns AppData directory.

    final directory = await getApplicationDocumentsDirectory();
    */

    Directory? appDocumentsDirectory = await getApplicationDocumentsDirectory(); //await getTemporaryDirectory(); //await getExternalStorageDirectory(); // 1
    try {
      if (appDocumentsDirectory != null) {
        String appDocumentsPath = appDocumentsDirectory.path; // 2
        String filePath = '$appDocumentsPath/$fileName'; // 3

        //Print.Reference("File path $filePath");

        if (await File(filePath).exists()) {
          await deleteFile(filePath);
        }

        File file = File(filePath); // 1
        file.writeAsBytesSync(bytes); // 2
        //Print.Reference("saved file path: ${file.path}");
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<int?> deleteFile(String path) async {
    try {
      File file = File(path);

      await file.delete();
      //Print.Reference("Deleted file path: ${file.path}");
    } catch (e) {
      return 0;
    }
  }

  static Future<File?> getFile(String fileName) async {
    Directory? appDocumentsDirectory = await getApplicationDocumentsDirectory(); //await getTemporaryDirectory(); //await getExternalStorageDirectory(); // 1
    try {
      if (appDocumentsDirectory != null) {
        String appDocumentsPath = appDocumentsDirectory.path; // 2
        String filePath = '$appDocumentsPath/$fileName'; // 3


        File file = File(filePath);
        return file.existsSync() == true ? file : null;
      } else {
        return null;
      }
    } catch (e) {
      print("=> get File error: $e");
      return null;
    }
  }

  static Future<bool> deleteFileByName(String fileName) async {
    Directory? appDocumentsDirectory = await getApplicationDocumentsDirectory(); //await getTemporaryDirectory(); //await getExternalStorageDirectory(); // 1
    try {
      if (appDocumentsDirectory != null) {
        String appDocumentsPath = appDocumentsDirectory.path; // 2
        String filePath = '$appDocumentsPath/$fileName'; // 3


        File file = File(filePath);
        if(file.existsSync() == true) {
          file.deleteSync();
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("=> delete File error: $e");
      return false;
    }
  }

  static String getFileExtension(String fileName) {
    return "." + fileName.split('.').last;
  }

  static String getMimeType(String fileName) {
    return fileName.split('.').last;
  }

  static Future<List<XFile>?> _showCameraMultiImageDialog(
      {required BuildContext context,
        required List<XFile>? xFiles,
      required double? maxWidth,
      required double? maxHeight,
      required int imageQualityForImageVideoPicker,
      required ImagePicker imagePicker,
      required CameraDevice preferredCameraDevice}) async {
    return Get.defaultDialog(
        title: "Choose From",
        //middleText: "Hello world!",
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.all(20),
        titleStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: ReleaseConstant.Montserrat),
        middleTextStyle: TextStyle(color: Colors.black54),
        //textConfirm: "Confirm",
        //textCancel: "Cancel",
        cancelTextColor: Colors.red,
        confirmTextColor: Colors.green,
        //buttonColor: Colors.red,
        barrierDismissible: false,
        radius: 5,
        content: Column(
          children: [
            UIUtils.buttonWidthSize(
                uiKey: "buttonCamera_multi_image",
                width: 160,
                fillColor: ColorConstant.Btn_color,
                textColor: Colors.white,
                title: "Camera",
                fontFamily: ReleaseConstant.Montserrat,
                fontSize: 14,
                onTap: () async{
                  if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
                    XFile? xFile = await imagePicker.pickImage(
                        source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQualityForImageVideoPicker, maxHeight: maxHeight, maxWidth: maxWidth);

                    if (xFile != null) {
                      xFiles = [];
                      xFiles!.add(xFile);
                    }
                  } else {
                    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQualityForImageVideoPicker);
                    if (xFile != null) {
                      xFiles = [];
                      xFiles!.add(xFile);
                    }
                  }
                  Get.back(result: xFiles);
                }),
            SizedBox(height: 15),
            UIUtils.buttonWidthSize(
                uiKey: "buttonGallery_multi_image",
                width: 160,
                fillColor: ColorConstant.Btn_color,
                textColor: Colors.white,
                title: "Gallery",
                fontFamily: ReleaseConstant.Montserrat,
                fontSize: 14,
                onTap: () async{
                  if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
                    xFiles = await imagePicker.pickMultiImage(maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: imageQualityForImageVideoPicker);
                  } else {
                    xFiles = await imagePicker.pickMultiImage(imageQuality: imageQualityForImageVideoPicker);
                  }
                  Get.back(result: xFiles);
                }),
            SizedBox(height: 40),
            UIUtils.buttonWidthSize(
                uiKey: "buttonCancel_multi_image",
                width: 160,
                fillColor: Colors.red,
                textColor: Colors.white,
                title: "CANCEL",
                onTap: () async{
                  Get.back();
                })
          ],
        ));
  }

  static Future<List<XFile>?> _showCameraImageDialog(
      {required BuildContext context,
        required List<XFile>? xFiles,
        required double? maxWidth,
        required double? maxHeight,
        required int imageQualityForImageVideoPicker,
        required ImagePicker imagePicker,
        required CameraDevice preferredCameraDevice,
        required bool imageCrop}) async {
    return Get.defaultDialog(
        title: "Choose From",
        //middleText: "Hello world!",
        backgroundColor: Colors.white,
        titlePadding: EdgeInsets.all(25),
        titleStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: ReleaseConstant.Montserrat),
        middleTextStyle: TextStyle(color: Colors.black54),
        //textConfirm: "Confirm",
        //textCancel: "Cancel",
        cancelTextColor: Colors.red,
        confirmTextColor: Colors.green,
        //buttonColor: Colors.red,
        barrierDismissible: false,
        radius: 5,
        content: Column(
          children: [
            UIUtils.buttonWidthSize(
                uiKey: "buttonCamera_image",
                width: 160,
                fillColor: ColorConstant.Btn_color,
                textColor: Colors.white,
                title: "Camera",
                fontFamily: ReleaseConstant.Montserrat,
                fontSize: 14,
                onTap: () async{
                  if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
                    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQualityForImageVideoPicker, maxHeight: maxHeight, maxWidth: maxWidth);

                    if (xFile != null) {
                      xFiles = [];

                      if(imageCrop) {
                        CroppedFile? croppedFile = await getCroppedFile(
                            sourcePath: xFile.path,
                            maxHeight: maxHeight.toInt(),
                            maxWidth: maxWidth.toInt(),
                            compressQuality: imageQualityForImageVideoPicker);
                        if (croppedFile != null) {
                          xFiles!.add(XFile(croppedFile.path));
                        }
                      } else {
                        xFiles!.add(xFile);
                      }
                    }
                  } else {
                    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQualityForImageVideoPicker);
                    if (xFile != null) {
                      xFiles = [];

                      if(imageCrop) {
                        CroppedFile? croppedFile = await getCroppedFile(
                            sourcePath: xFile.path,
                            maxHeight: maxHeight!.toInt(),
                            maxWidth: maxWidth!.toInt(),
                            compressQuality: imageQualityForImageVideoPicker);
                        if (croppedFile != null) {
                          xFiles!.add(XFile(croppedFile.path));
                        }
                      } else {
                        xFiles!.add(xFile);
                      }
                    }
                  }
                  Get.back(result: xFiles);
                }),
            SizedBox(height: 15),
            UIUtils.buttonWidthSize(
                uiKey: "buttonGallery_image",
                width: 160,
                fillColor: ColorConstant.Btn_color,
                textColor: Colors.white,
                title: "Gallery",
                fontFamily: ReleaseConstant.Montserrat,
                fontSize: 14,
                onTap: () async{
                  if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
                    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: imageQualityForImageVideoPicker, maxHeight: maxHeight, maxWidth: maxWidth);
                    if (xFile != null) {
                      xFiles = [];

                      if(imageCrop) {
                        CroppedFile? croppedFile = await getCroppedFile(
                            sourcePath: xFile.path,
                            maxHeight: maxHeight.toInt(),
                            maxWidth: maxWidth.toInt(),
                            compressQuality: imageQualityForImageVideoPicker);
                        if (croppedFile != null) {
                          xFiles!.add(XFile(croppedFile.path));
                        }
                      } else {
                        xFiles!.add(xFile);
                      }
                    }
                  } else {
                    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: imageQualityForImageVideoPicker);
                    if (xFile != null) {
                      xFiles = [];

                      if(imageCrop) {
                        CroppedFile? croppedFile = await getCroppedFile(
                            sourcePath: xFile.path,
                            maxHeight: maxHeight!.toInt(),
                            maxWidth: maxWidth!.toInt(),
                            compressQuality: imageQualityForImageVideoPicker);
                        if (croppedFile != null) {
                          xFiles!.add(XFile(croppedFile.path));
                        }
                      } else {
                        xFiles!.add(xFile);
                      }
                    }
                  }
                  Get.back(result: xFiles);
                }),
            SizedBox(height: 40),
            UIUtils.buttonWidthSize(
                uiKey: "buttonCancel_image",
                width: 160,
                fillColor: Colors.red,
                textColor: Colors.white,
                title: "CANCEL",
                onTap: () async{
                  Get.back();
                })
          ],
        ));
  }

  static FileSizeModel getSeparateNumberString({required String fileSize}) {
    FileSizeModel fileSizeModel = FileSizeModel();
    //String dartString = "1234 MB";

    // Use a regular expression to extract numeric and alphabetic parts
    RegExp regex = RegExp(r'(\d+)(\s*)([A-Za-z]+)');
    Match? match = regex.firstMatch(fileSize);

    if (match != null) {
      String? numericPart = match.group(1);
      String? alphabeticPart = match.group(3);

      print("Numeric part: $numericPart");
      print("Alphabetic part: $alphabeticPart");

      if(numericPart != null) {
        fileSizeModel.size = double.parse(numericPart);
      }
      if(alphabeticPart != null) {
        fileSizeModel.sizeType = alphabeticPart;
      }
    } else {
      print("Invalid format: Unable to separate numbers and strings.");
    }

    return fileSizeModel;
  }
}

class FileSizeModel {
  double size;
  String sizeType; // B, KB, MB, GB

  FileSizeModel({this.size = 0, this.sizeType = ""});
}
