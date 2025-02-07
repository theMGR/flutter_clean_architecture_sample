
class LocalDataSyncUpProcess {
  static int count = 0;
  static String? baseUrl = "";
  static String? webSocketUrl = "";


  //static Future pushAllSavedData() async { // todo }

  Future<dynamic> getNotSyncedSavedData() async {
    // todo
  }

  Future<dynamic> pushAllSavedData() async {
    // todo
  }

  /*static Future<void> pobPodImageUploadMultipart(CollectionDeliveryModel model, List<File> mCapturedFile, PobPodImagesDAO pobPodImagesDAO) async {
    PobPodImagesModel aImagesModel = PobPodImagesModel();

    for (var i in mCapturedFile) {
      //var str = i.path.split('/').last;
      //String filename = str.split('.').first;
      //String fileExt = str.split('.').last;

      //  File file = File(i.path);
      //File compressImg = await compressImage(CompressObject(file, file.path, Math.Random().nextInt(10000)));
      aImagesModel.orderId = model.orderId;
      aImagesModel.statusId = model.statusTypeId;
      aImagesModel.syncUpId = model.syncUpId;
      aImagesModel.isUploaded = ValueConstant.START_UPLOAD;
      aImagesModel.imageKey = '${Utils.getRandomInt()}';
      aImagesModel.imagePath = i.path;
      aImagesModel.mobileUuId = model.mobileUUID ?? Utils.getUUID();
      aImagesModel.orderAddressId = model.orderAddressId;
      aImagesModel.imageuploadOrderIdList = [...model.imageUploadOrderIdList ?? []];

      await pobPodImagesDAO.saveOrdersDetails(aImagesModel);
    }

    if (await Utils.onCheckNetworkConnection()) {
      await pushAllImagesS3(pobPodImagesDAO).whenComplete(() async => await sentImageUrlsToBE(pobPodImagesDAO));
    }
  }*/

/*  static Future pushAllSavedOrders(List<SavedOrdersDTO> savedOrders, OrdersMasterDAO? ordersMasterDAO, SaveOrdersDetailsDAO? saveOrdersDetailsDAO, CustomSharedPrefs? customSharedPrefs) async {
    Get.lazyPut(() => BackgroundSyncUpUseCase());
    var response = await Get.find<BackgroundSyncUpUseCase>().execute(savedOrders).catchError((e) async {
      return e;
      // await customSharedPrefs.setIsBackgroundSyncUpdateIsRunning(false);
    });
    await OrdersUtils.updateBGSyncUpServiceOrdersResponse(response, ordersMasterDAO, saveOrdersDetailsDAO, customSharedPrefs);
  }*/

/*  static Future<List<SavedOrdersDTO>> getSavedOrderDetails(List<PobPodDetailsModel> data) async {
    return  [];
  }*/

  /*static Future<String> getImagePath(String? orderId, String? statusId, String? path) async {
    File image = File('$path');
    Uint8List file = await image.readAsBytes();
    await image.writeAsBytes(file);

    Get.lazyPut(() => ImageUploadUseCase());
    var result = await Get.find<ImageUploadUseCase>().execute(ImageUploadParams(orderId: orderId, statusId: statusId, file: image)).catchError((e) {
      return null;
    });
    return result ?? '';
  }*/

  /*static Future<String> getCapturedImageURL(String orderId, String statusId, String path) async {
    File image = File('$path');
    Uint8List file = await image.readAsBytes();
    await image.writeAsBytes(file);

    Get.lazyPut(() => CapturedImageUploadUseCase());
    var result = await Get.find<CapturedImageUploadUseCase>().execute(CapturedImageUploadParams(orderId: orderId, statusId: statusId, file: image)).catchError((onError) {
      return null;
    });
    return result ?? '';
  }*/

  /*static Future<void> updateSavedOrders(SaveOrderResultWrapper savedOrders, OrdersMasterDAO? ordersMasterDAO, SaveOrdersDetailsDAO? saveOrdersDetailsDAO, CustomSharedPrefs? customSharedPrefs) async {
    await OrdersUtils.updateBGSyncUpServiceOrdersResponse(savedOrders, ordersMasterDAO, saveOrdersDetailsDAO, customSharedPrefs);
  }*/

  /*static Future<void> updatePobPodImagesDB(SavedOrdersResultDTO savedOrders, PobPodImagesDAO? pobPodImagesDAO, String? aImageKey) async {
    // todo saravanakumar -> check
    *//*if (savedOrders != null) {
      if (savedOrders.status == ValueConstant.ORDER_SYNCUP_SUCCESS || savedOrders.status == ValueConstant.DUPLICATE_IMAGE) {
        await pobPodImagesDAO!.deleteSavedOrderDetails(savedOrders.orderId, savedOrders.orderStatus, aImageKey);
      }
    }*//*

    if (savedOrders.status == ValueConstant.ORDER_SYNCUP_SUCCESS || savedOrders.status == ValueConstant.DUPLICATE_IMAGE) {
      await pobPodImagesDAO!.deleteSavedOrderDetails(savedOrders.orderId, savedOrders.orderStatus, aImageKey);
    }
  }*/


  /*static Future<void> pushAllImagesS3(PobPodImagesDAO pobPodImagesDAO) async {
    var aImages = (await pobPodImagesDAO.getAllOrderDetails(ValueConstant.START_UPLOAD)).toSet().toList();
    print('==LOCAL DB IMAGE UPLOAD RECORDS==${aImages.length}');
    // FormData listData =FormData(Map<String,dynamic>());
    if (aImages.isNotEmpty) {
      for (var i in aImages) {
        PobPodImagesModel aImageData = PobPodImagesModel();
        File file = File(i.imagePath!);
        var image = MultipartFile(file.readAsBytesSync(), filename: '${i.orderId}_${OrderStatusUtils.isPobStatusOrder(i.statusId) ? 'POB' : 'POD'}_${DateFormat('dd-MM-yyyy').format(DateTime.now())}.jpg');
        aImageData.orderId = i.orderId;
        aImageData.statusId = i.statusId;
        aImageData.imageKey = i.imageKey;
        var data = FormData({'imagefile': image, 'uniqueImageKey': '${OrderStatusUtils.isPobStatusOrder(i.statusId) ? 'POB' : 'POD'}_${i.orderId}'});
        aImageData.imagefile = data;
        print('Image Key --> ' + aImageData.imageKey.toString());
        print('Imagedata ======' + aImageData.toString());
        aImageData.imageuploadOrderIdList = [];
        aImageData.imageuploadOrderIdList?.addAll(i.imageuploadOrderIdList ?? []);
        Get.lazyPut(() => ImageUploadS3UseCase());

        await Get.find<ImageUploadS3UseCase>().execute(aImageData).then((result) async {
          if (result != null && result.code == ValueConstant.ImageUploadS3Success) {
            aImageData.isUploaded = ValueConstant.START_UPLOAD_BE_Url;
            aImageData.message = result.message;
            aImageData.url = result.url;
            aImageData.imagefile = null;
            aImageData.imageKey = i.imageKey;
            aImageData.syncUpId = i.syncUpId;
            await pobPodImagesDAO.updateUploadedStatus(aImageData);
            Future.delayed(Duration(seconds: 5));
          } else {
            print('Image upload status in S3 = ${result!.code}');
          }
        }).catchError((e) {
          print('Image Upload BG Error --> ' + e.toString());
        });
      }
    }
  }*/

  /*static Future<void> sentImageUrlsToBE(PobPodImagesDAO pobPodImagesDAO) async {
    var aImages = (await pobPodImagesDAO.getAllOrderDetails(ValueConstant.START_UPLOAD_BE_Url)).toSet().toList();

    if (aImages.isNotEmpty) {
      Get.lazyPut(() => UploadImageS3UrlUsecase());
      await Get.find<UploadImageS3UrlUsecase>().execute(aImages).then((result) {
        result.map((e) async {
          var model = result.firstWhereOrNull((element) => element.imageKey == e.imageKey);
          if (model != null) {
            await LocationCallbackHandler.updatePobPodImagesDB(e, pobPodImagesDAO, model.imageKey);
          }
        }).toList();
      }).catchError((e) {
        print('Image Upload BG Error --> ' + e.toString());
      });
    }
  }*/




}
