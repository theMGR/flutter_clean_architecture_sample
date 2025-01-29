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
import 'card.dart' as _i2;

abstract class Listboard implements _i1.SerializableModel {
  Listboard._({
    this.id,
    required this.boardId,
    required this.userId,
    required this.name,
    this.archived,
    this.cards,
  });

  factory Listboard({
    int? id,
    required int boardId,
    required int userId,
    required String name,
    bool? archived,
    List<_i2.Cardlist>? cards,
  }) = _ListboardImpl;

  factory Listboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return Listboard(
      id: jsonSerialization['id'] as int?,
      boardId: jsonSerialization['boardId'] as int,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      archived: jsonSerialization['archived'] as bool?,
      cards: (jsonSerialization['cards'] as List?)
          ?.map((e) => _i2.Cardlist.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int boardId;

  int userId;

  String name;

  bool? archived;

  List<_i2.Cardlist>? cards;

  Listboard copyWith({
    int? id,
    int? boardId,
    int? userId,
    String? name,
    bool? archived,
    List<_i2.Cardlist>? cards,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'boardId': boardId,
      'userId': userId,
      'name': name,
      if (archived != null) 'archived': archived,
      if (cards != null) 'cards': cards?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListboardImpl extends Listboard {
  _ListboardImpl({
    int? id,
    required int boardId,
    required int userId,
    required String name,
    bool? archived,
    List<_i2.Cardlist>? cards,
  }) : super._(
          id: id,
          boardId: boardId,
          userId: userId,
          name: name,
          archived: archived,
          cards: cards,
        );

  @override
  Listboard copyWith({
    Object? id = _Undefined,
    int? boardId,
    int? userId,
    String? name,
    Object? archived = _Undefined,
    Object? cards = _Undefined,
  }) {
    return Listboard(
      id: id is int? ? id : this.id,
      boardId: boardId ?? this.boardId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      archived: archived is bool? ? archived : this.archived,
      cards: cards is List<_i2.Cardlist>?
          ? cards
          : this.cards?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
