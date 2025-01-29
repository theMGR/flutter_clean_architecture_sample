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

abstract class Cardlist implements _i1.SerializableModel {
  Cardlist._({
    this.id,
    required this.listId,
    required this.userId,
    required this.name,
    this.description,
    this.startDate,
    this.dueDate,
    this.attachment,
    this.archived,
    this.checklist,
    this.comments,
  });

  factory Cardlist({
    int? id,
    required int listId,
    required int userId,
    required String name,
    String? description,
    DateTime? startDate,
    DateTime? dueDate,
    bool? attachment,
    bool? archived,
    bool? checklist,
    bool? comments,
  }) = _CardlistImpl;

  factory Cardlist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Cardlist(
      id: jsonSerialization['id'] as int?,
      listId: jsonSerialization['listId'] as int,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      startDate: jsonSerialization['startDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      attachment: jsonSerialization['attachment'] as bool?,
      archived: jsonSerialization['archived'] as bool?,
      checklist: jsonSerialization['checklist'] as bool?,
      comments: jsonSerialization['comments'] as bool?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int listId;

  int userId;

  String name;

  String? description;

  DateTime? startDate;

  DateTime? dueDate;

  bool? attachment;

  bool? archived;

  bool? checklist;

  bool? comments;

  Cardlist copyWith({
    int? id,
    int? listId,
    int? userId,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? dueDate,
    bool? attachment,
    bool? archived,
    bool? checklist,
    bool? comments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'listId': listId,
      'userId': userId,
      'name': name,
      if (description != null) 'description': description,
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (attachment != null) 'attachment': attachment,
      if (archived != null) 'archived': archived,
      if (checklist != null) 'checklist': checklist,
      if (comments != null) 'comments': comments,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CardlistImpl extends Cardlist {
  _CardlistImpl({
    int? id,
    required int listId,
    required int userId,
    required String name,
    String? description,
    DateTime? startDate,
    DateTime? dueDate,
    bool? attachment,
    bool? archived,
    bool? checklist,
    bool? comments,
  }) : super._(
          id: id,
          listId: listId,
          userId: userId,
          name: name,
          description: description,
          startDate: startDate,
          dueDate: dueDate,
          attachment: attachment,
          archived: archived,
          checklist: checklist,
          comments: comments,
        );

  @override
  Cardlist copyWith({
    Object? id = _Undefined,
    int? listId,
    int? userId,
    String? name,
    Object? description = _Undefined,
    Object? startDate = _Undefined,
    Object? dueDate = _Undefined,
    Object? attachment = _Undefined,
    Object? archived = _Undefined,
    Object? checklist = _Undefined,
    Object? comments = _Undefined,
  }) {
    return Cardlist(
      id: id is int? ? id : this.id,
      listId: listId ?? this.listId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      startDate: startDate is DateTime? ? startDate : this.startDate,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      attachment: attachment is bool? ? attachment : this.attachment,
      archived: archived is bool? ? archived : this.archived,
      checklist: checklist is bool? ? checklist : this.checklist,
      comments: comments is bool? ? comments : this.comments,
    );
  }
}
