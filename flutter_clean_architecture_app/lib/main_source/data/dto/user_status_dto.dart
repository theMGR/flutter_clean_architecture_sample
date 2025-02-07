import 'dart:convert';

import 'package:flearn/main_source/domain/entity/user_status_entity.dart';

class UserStatusDto extends UserStatusEntity {
  UserStatusDto({super.driverId, super.id, super.longitude, super.latitude, super.activeStatusTypeId, super.isMoving, super.locationActivityType, super.isCharging, super.battery, super.speed, super.event, super.mobileMode, super.statusId});

  UserStatusDto copyWith({
    String? driverId,
    String? id,
    double? longitude,
    double? latitude,
    String? activeStatusTypeId,
    bool? isMoving,
    String? locationActivityType,
    bool? isCharging,
    String? battery,
    String? speed,
    String? event,
    String? mobileMode,
    int? statusId,
  }) {
    return UserStatusDto(
      driverId: driverId ?? this.driverId,
      id: id ?? this.id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      activeStatusTypeId: activeStatusTypeId ?? this.activeStatusTypeId,
      isMoving: isMoving ?? this.isMoving,
      locationActivityType: locationActivityType ?? this.locationActivityType,
      isCharging: isCharging ?? this.isCharging,
      battery: battery ?? this.battery,
      speed: speed ?? this.speed,
      event: event ?? this.event,
      mobileMode: mobileMode ?? this.mobileMode,
      statusId: statusId ?? this.statusId,
    );
  }

  factory UserStatusDto.fromJson(Map<String, dynamic> json) => UserStatusDto(
        driverId: json["driverId"],
        id: json["id"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        activeStatusTypeId: json["activeStatusTypeId"],
        isMoving: json["isMoving"],
        locationActivityType: json["locationActivityType"],
        isCharging: json["isCharging"],
        battery: json["battery"],
        speed: json["speed"],
        event: json["event"],
        mobileMode: json["mobileMode"],
        statusId: json["statusId"],
      );

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "id": id,
        "longitude": longitude,
        "latitude": latitude,
        "activeStatusTypeId": activeStatusTypeId,
        "isMoving": isMoving,
        "locationActivityType": locationActivityType,
        "isCharging": isCharging,
        "battery": battery,
        "speed": speed,
        "event": event,
        "mobileMode": mobileMode,
        "statusId": statusId,
      };

  factory UserStatusDto.fromRawJson(String str) => UserStatusDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  @override
  String toString() {
    return "$driverId, $id, $longitude, $latitude, $activeStatusTypeId, $isMoving, $locationActivityType, $isCharging, $battery, $speed, $event, $mobileMode, $statusId, ";
  }
}
