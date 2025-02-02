import 'dart:convert';

import 'package:flearn/main_source/domain/entity/location_status_entity.dart';

class LocationStatusDto extends LocationStatusEntity {
  LocationStatusDto({
    super.latitude,
    super.longitude,
    super.latLongInsertUpdateTime,
    super.status,
    super.id,
    super.userId,
  });

  factory LocationStatusDto.fromJson(dynamic json) => LocationStatusDto(
        latitude: json['latitude'],
        longitude: json['longitude'],
        latLongInsertUpdateTime: json['latLongInsertUpdateTime'],
        status: json['status'],
        id: json['id'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'latLongInsertUpdateTime': latLongInsertUpdateTime,
        'status': status,
        'id': id,
        'userId': userId,
      };

  factory LocationStatusDto.fromRawJson(String str) => LocationStatusDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  LocationStatusDto copyWith({double? latitude, double? longitude, String? latLongInsertUpdateTime, int? status, String? id, String? userId}) {
    return LocationStatusDto(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      latLongInsertUpdateTime: latLongInsertUpdateTime ?? this.latLongInsertUpdateTime,
      status: status ?? this.status,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return "$latitude, $longitude, $latLongInsertUpdateTime, $status, $id, $userId ";
  }
}
