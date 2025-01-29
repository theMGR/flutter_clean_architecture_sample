/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Checklist implements _i1.SerializableModel {
  Checklist._({
    this.id,
    required this.cardId,
    required this.name,
    required this.status,
  });

  factory Checklist({
    int? id,
    required int cardId,
    required String name,
    required bool status,
  }) = _ChecklistImpl;

  factory Checklist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Checklist(
      id: jsonSerialization['id'] as int?,
      cardId: jsonSerialization['cardId'] as int,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int cardId;

  String name;

  bool status;

  Checklist copyWith({
    int? id,
    int? cardId,
    String? name,
    bool? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardId': cardId,
      'name': name,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChecklistImpl extends Checklist {
  _ChecklistImpl({
    int? id,
    required int cardId,
    required String name,
    required bool status,
  }) : super._(
          id: id,
          cardId: cardId,
          name: name,
          status: status,
        );

  @override
  Checklist copyWith({
    Object? id = _Undefined,
    int? cardId,
    String? name,
    bool? status,
  }) {
    return Checklist(
      id: id is int? ? id : this.id,
      cardId: cardId ?? this.cardId,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
