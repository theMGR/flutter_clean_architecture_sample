
import 'package:flearn/main_source/data/dto/location_status_dto.dart';

abstract class LoginRepository {
  Future<LocationStatusDto> updateLocation(LocationStatusDto locationStatusDto);

  Future<bool> changeUserStatus(int code);
}
