import 'dart:convert';

import 'package:flearn/main_source/domain/entity/user_status_entity.dart';

class UserStatusDto extends UserStatusEntity {
  UserStatusDto({
    super.driverId,
    super.id,
    super.longitude,
    super.latitude,
    super.tblStatusTypesId,
    super.isMoving,
    super.activityType,
    super.isCharging,
    super.battery,
    super.speed,
    super.event,
    super.mobileMode,
  });

  UserStatusDto copyWith({
    String? driverId,
    String? id,
    double? longitude,
    double? latitude,
    String? tblStatusTypesId,
    bool? isMoving,
    String? activityType,
    bool? isCharging,
    String? battery,
    String? speed,
    String? event,
    String? mobileMode,
  }) {
    return UserStatusDto(
      driverId: driverId ?? this.driverId,
      id: id ?? this.id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      tblStatusTypesId: tblStatusTypesId ?? this.tblStatusTypesId,
      isMoving: isMoving ?? this.isMoving,
      activityType: activityType ?? this.activityType,
      isCharging: isCharging ?? this.isCharging,
      battery: battery ?? this.battery,
      speed: speed ?? this.speed,
      event: event ?? this.event,
      mobileMode: mobileMode ?? this.mobileMode,
    );
  }

  factory UserStatusDto.fromJson(Map<String, dynamic> json) => UserStatusDto(
        driverId: json["driverId"],
        id: json["id"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        tblStatusTypesId: json["tblStatusTypesId"],
        isMoving: json["isMoving"],
        activityType: json["activityType"],
        isCharging: json["isCharging"],
        battery: json["battery"],
        speed: json["speed"],
        event: json["event"],
        mobileMode: json["mobileMode"],
      );

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "id": id,
        "longitude": longitude,
        "latitude": latitude,
        "tblStatusTypesId": tblStatusTypesId,
        "isMoving": isMoving,
        "activityType": activityType,
        "isCharging": isCharging,
        "battery": battery,
        "speed": speed,
        "event": event,
        "mobileMode": mobileMode,
      };

  factory UserStatusDto.fromRawJson(String str) => UserStatusDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  @override
  String toString() {
    return "$driverId, $id, $longitude, $latitude, $tblStatusTypesId, $isMoving, $activityType, $isCharging, $battery, $speed, $event, $mobileMode, ";
  }
}
