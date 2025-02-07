import 'package:equatable/equatable.dart';

class LocationStatusEntity {
  double? latitude;
  double? longitude;
  String? latLongInsertUpdateTime;
  int? status;
  String? id;
  String? userId;

  LocationStatusEntity({
    this.latitude,
    this.longitude,
    this.latLongInsertUpdateTime,
    this.status,
    this.id,
    this.userId,
  });

}
