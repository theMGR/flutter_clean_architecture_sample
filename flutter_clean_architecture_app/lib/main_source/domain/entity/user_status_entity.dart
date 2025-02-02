import 'package:equatable/equatable.dart';

class UserStatusEntity with EquatableMixin {
  final String? driverId;
  final String? id;
  final double? longitude;
  final double? latitude;
  final String? tblStatusTypesId;
  final bool? isMoving;
  final String? activityType;
  final bool? isCharging;
  final String? battery;
  final String? speed;
  final String? event;
  final String? mobileMode;

  UserStatusEntity({
    this.driverId,
    this.id,
    this.longitude,
    this.latitude,
    this.tblStatusTypesId,
    this.isMoving,
    this.activityType,
    this.isCharging,
    this.battery,
    this.speed,
    this.event,
    this.mobileMode,
  });

  @override
  List<Object?> get props => [
        driverId,
        id,
        longitude,
        latitude,
        tblStatusTypesId,
        isMoving,
        activityType,
        isCharging,
        battery,
        speed,
        event,
        mobileMode,
      ];
}
