import 'package:equatable/equatable.dart';

class LatitudeLongitudeEntity with EquatableMixin {
  final double? latitude;
  final double? longitude;

  LatitudeLongitudeEntity({this.latitude, this.longitude});

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
