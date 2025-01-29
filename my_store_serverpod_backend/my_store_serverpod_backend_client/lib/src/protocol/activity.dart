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

abstract class Activity implements _i1.SerializableModel {
  Activity._({
    this.id,
    this.boardId,
    required this.userId,
    this.cardId,
    required this.description,
    required this.dateCreated,
  });

  factory Activity({
    int? id,
    int? boardId,
    required int userId,
    int? cardId,
    required String description,
    required DateTime dateCreated,
  }) = _ActivityImpl;

  factory Activity.fromJson(Map<String, dynamic> jsonSerialization) {
    return Activity(
      id: jsonSerialization['id'] as int?,
      boardId: jsonSerialization['boardId'] as int?,
      userId: jsonSerialization['userId'] as int,
      cardId: jsonSerialization['cardId'] as int?,
      description: jsonSerialization['description'] as String,
      dateCreated:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreated']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? boardId;

  int userId;

  int? cardId;

  String description;

  DateTime dateCreated;

  Activity copyWith({
    int? id,
    int? boardId,
    int? userId,
    int? cardId,
    String? description,
    DateTime? dateCreated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (boardId != null) 'boardId': boardId,
      'userId': userId,
      if (cardId != null) 'cardId': cardId,
      'description': description,
      'dateCreated': dateCreated.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityImpl extends Activity {
  _ActivityImpl({
    int? id,
    int? boardId,
    required int userId,
    int? cardId,
    required String description,
    required DateTime dateCreated,
  }) : super._(
          id: id,
          boardId: boardId,
          userId: userId,
          cardId: cardId,
          description: description,
          dateCreated: dateCreated,
        );

  @override
  Activity copyWith({
    Object? id = _Undefined,
    Object? boardId = _Undefined,
    int? userId,
    Object? cardId = _Undefined,
    String? description,
    DateTime? dateCreated,
  }) {
    return Activity(
      id: id is int? ? id : this.id,
      boardId: boardId is int? ? boardId : this.boardId,
      userId: userId ?? this.userId,
      cardId: cardId is int? ? cardId : this.cardId,
      description: description ?? this.description,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}
