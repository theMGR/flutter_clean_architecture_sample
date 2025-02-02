import 'package:flearn/flutter_architecture_sample/layers/data/source/local/local_storage.dart';
import 'package:flearn/flutter_architecture_sample/layers/data/source/network/api.dart';
import 'package:flearn/flutter_architecture_sample/layers/domain/entity/character.dart';
import 'package:flearn/flutter_architecture_sample/layers/domain/repository/character_repository.dart';
import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final Api _api;
  final LocalStorage _localStorage;

  LoginRepositoryImpl({
    required Api api,
    required LocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  @override
  Future<List<Character>> getCharacters({int page = 0}) async {
    final cachedList = _localStorage.loadCharactersPage(page: page);
    if (cachedList.isNotEmpty) {
      return cachedList;
    }

    final fetchedList = await _api.loadCharacters(page: page);
    await _localStorage.saveCharactersPage(page: page, list: fetchedList);
    return fetchedList;
  }

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
}
