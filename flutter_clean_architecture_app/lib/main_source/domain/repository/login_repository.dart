
import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/data/dto/user_status_dto.dart';

abstract class LoginRepository {
  Future<LocationStatusDto> updateLocation(LocationStatusDto locationStatusDto);

  Future<LocationStatusDto> updateUUserStatus(UserStatusDto userStatusDto);

  Future<bool> changeUserStatus(int code);
}
