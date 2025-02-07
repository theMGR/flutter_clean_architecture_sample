import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/data/dto/user_status_dto.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flearn/main_source/data/source/network/dio_api_service/dio_api_service.dart';
import 'package:flearn/main_source/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final DioApiService dioApiService;
  final Prefs prefs;

  LoginRepositoryImpl({required this.dioApiService, required this.prefs});

  @override
  Future<LocationStatusDto> updateLocation(LocationStatusDto locationStatusDto) {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }

  @override
  Future<bool> changeUserStatus(int code) async {
    /*await WebSocketServer.disconnect();
    //await forceSyncUp();
    firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.setAutoInitEnabled(false);
    //TODO check for implementation of newer version firebase messaging
    await firebaseMessaging.deleteToken();
    await oobMenuMasterDAO!.dbDrop();
    await loginMasterDAO!.dbDrop();
    if(code != ValueConstant.LOG_OUT_STATUS_SYNCUP_NOT_DELETED) {
      print('Local db records has been deleted');
      await ordersMasterDAO!.dbDelete();
      await saveOrdersDetailsDAO!.dbDelete();
      await pobPodImagesDAO!.dbDelete();
      await labelMasterDAO?.dropTable();
    }
    if (code == ValueConstant.LOGIN_STATUS_NOT_ALLOWED) {
      await mCustomSharedPrefs!.setTrackUser(false);
      await LocationTrackByTransistor.stopLocationTrack();
      await BackgroundFetch.stop();
    }
    if (await mCustomSharedPrefs!.isRememberMeChecked()) {
      print('nonMaintainProfile called : items deleted');
      return await mCustomSharedPrefs!.nonMaintainProfile();
    } else {
      print('all profile deleted');
      return await mCustomSharedPrefs!.deleteUserProfile();
    }*/

    return false;
  }

  @override
  Future<LocationStatusDto> updateUUserStatus(UserStatusDto userStatusDto) {
    // TODO: implement updateUUserStatus
    throw UnimplementedError();
  }
}
