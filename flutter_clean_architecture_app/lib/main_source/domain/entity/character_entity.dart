import 'package:equatable/equatable.dart';

class CharacterEntity with EquatableMixin {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final LocationEntity? origin;
  final LocationEntity? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  CharacterEntity({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
      ];

  bool get isAlive => status == 'Alive';
}

class LocationEntity with EquatableMixin {
  LocationEntity({
    this.name,
    this.url,
  });

  final String? name;
  final String? url;

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
