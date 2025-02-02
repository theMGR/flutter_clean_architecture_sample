import 'package:equatable/equatable.dart';

class LocationStatusEntity with EquatableMixin {
  final double? latitude;
  final double? longitude;
  final String? latLongInsertUpdateTime;
  final int? status;
  final String? id;
  final String? userId;

  LocationStatusEntity({
    this.latitude,
    this.longitude,
    this.latLongInsertUpdateTime,
    this.status,
    this.id,
    this.userId,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        latLongInsertUpdateTime,
        status,
        id,
        userId,
      ];
}
