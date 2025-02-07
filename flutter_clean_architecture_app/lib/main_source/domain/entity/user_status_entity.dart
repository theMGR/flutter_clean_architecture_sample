

class UserStatusEntity {
  String? driverId;
  String? id;
  double? longitude;
  double? latitude;
  String? activeStatusTypeId;
  bool? isMoving;
  String? locationActivityType;
  bool? isCharging;
  String? battery;
  String? speed;
  String? event;
  String? mobileMode;
  int? statusId;

  UserStatusEntity({
    this.driverId,
    this.id,
    this.longitude,
    this.latitude,
    this.activeStatusTypeId,
    this.isMoving,
    this.locationActivityType,
    this.isCharging,
    this.battery,
    this.speed,
    this.event,
    this.mobileMode,
    this.statusId
  });
}
