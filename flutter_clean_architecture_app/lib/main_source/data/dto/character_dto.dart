import 'dart:convert';

import 'package:flearn/main_source/domain/entity/character_entity.dart';

class CharacterDto extends CharacterEntity {
  CharacterDto({
    super.id,
    super.name,
    super.status,
    super.species,
    super.type,
    super.gender,
    super.origin,
    super.location,
    super.image,
    super.episode,
    super.url,
    super.created,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory CharacterDto.fromRawJson(String str) => CharacterDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------
  factory CharacterDto.fromJson(Map<String, dynamic> json) => CharacterDto(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'] == null ? null : LocationDto.fromLocation(json['origin']),
        location: json['location'] == null ? null : LocationDto.fromJson(json['location']),
        image: json['image'],
        episode: json['episode'] == null ? [] : List<String>.from(json['episode']!.map((dynamic x) => x)),
        url: json['url'],
        created: json['created'] == null ? null : DateTime.parse(json['created']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin != null ? LocationDto.fromLocation(origin!).toJson() : null,
        'location': location != null ? LocationDto.fromLocation(location!).toJson() : null,
        'image': image,
        'episode': episode == null ? [null] : List<dynamic>.from(episode!.map((x) => x)),
        'url': url,
        'created': created?.toIso8601String(),
      };
}

class LocationDto extends LocationEntity {
  LocationDto({
    super.name,
    super.url,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory LocationDto.fromRawJson(String str) => LocationDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------
  factory LocationDto.fromJson(Map<String, dynamic> json) => LocationDto(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };

  // ---------------------------------------------------------------------------
  // Domain
  // ---------------------------------------------------------------------------
  factory LocationDto.fromLocation(LocationEntity location) {
    return LocationDto(
      name: location.name,
      url: location.url,
    );
  }

  LocationEntity toLocationEntity() {
    return LocationEntity(
      name: name,
      url: url,
    );
  }
}
