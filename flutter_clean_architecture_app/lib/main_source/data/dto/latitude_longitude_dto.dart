import 'dart:convert';

import 'package:flearn/main_source/domain/entity/latitude_longitude_entity.dart';

class LatitudeLongitudeDto extends LatitudeLongitudeEntity {
  //LatitudeLongitudeDto({double ? latitude, double? longitude}) : super(latitude: latitude, longitude: longitude);

  LatitudeLongitudeDto({super.latitude, super.longitude});

  factory LatitudeLongitudeDto.fromJson(Map<String, dynamic> json) => LatitudeLongitudeDto(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  factory LatitudeLongitudeDto.fromRawJson(String str) => LatitudeLongitudeDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  LatitudeLongitudeDto copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LatitudeLongitudeDto(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return "$latitude, $longitude, ";
  }
}
