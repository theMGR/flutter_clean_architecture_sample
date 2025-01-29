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

abstract class Comment implements _i1.SerializableModel {
  Comment._({
    this.id,
    required this.cardId,
    required this.userId,
    required this.description,
  });

  factory Comment({
    int? id,
    required int cardId,
    required int userId,
    required String description,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      cardId: jsonSerialization['cardId'] as int,
      userId: jsonSerialization['userId'] as int,
      description: jsonSerialization['description'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int cardId;

  int userId;

  String description;

  Comment copyWith({
    int? id,
    int? cardId,
    int? userId,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardId': cardId,
      'userId': userId,
      'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int cardId,
    required int userId,
    required String description,
  }) : super._(
          id: id,
          cardId: cardId,
          userId: userId,
          description: description,
        );

  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? cardId,
    int? userId,
    String? description,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      cardId: cardId ?? this.cardId,
      userId: userId ?? this.userId,
      description: description ?? this.description,
    );
  }
}
