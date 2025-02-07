import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/data/dto/user_status_dto.dart';
import 'package:flearn/main_source/domain/repository/login_repository.dart';

import '../../configuration/config/usecase.dart';

class LocationUpdateUseCase extends UseCase<LocationStatusDto, LocationStatusDto> {
  final LoginRepository _repository;

  LocationUpdateUseCase({
    required LoginRepository repository,
  }) : _repository = repository;

  @override
  Future<LocationStatusDto> call(LocationStatusDto input) {
    return _repository.updateLocation(input);
  }
}

class UserStatusUpdateUseCase extends UseCase<UserStatusDto, LocationStatusDto?> {
  final LoginRepository _repository;

  UserStatusUpdateUseCase({
    required LoginRepository repository,
  }) : _repository = repository;

  @override
  Future<LocationStatusDto?> call(UserStatusDto input) {
    return _repository.updateUUserStatus(input);
  }
}
