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
import 'member.dart' as _i2;

abstract class Workspace implements _i1.SerializableModel {
  Workspace._({
    this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.visibility,
    this.members,
  });

  factory Workspace({
    int? id,
    required int userId,
    required String name,
    required String description,
    required String visibility,
    List<_i2.Member>? members,
  }) = _WorkspaceImpl;

  factory Workspace.fromJson(Map<String, dynamic> jsonSerialization) {
    return Workspace(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      visibility: jsonSerialization['visibility'] as String,
      members: (jsonSerialization['members'] as List?)
          ?.map((e) => _i2.Member.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String name;

  String description;

  String visibility;

  List<_i2.Member>? members;

  Workspace copyWith({
    int? id,
    int? userId,
    String? name,
    String? description,
    String? visibility,
    List<_i2.Member>? members,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'visibility': visibility,
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WorkspaceImpl extends Workspace {
  _WorkspaceImpl({
    int? id,
    required int userId,
    required String name,
    required String description,
    required String visibility,
    List<_i2.Member>? members,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          description: description,
          visibility: visibility,
          members: members,
        );

  @override
  Workspace copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? description,
    String? visibility,
    Object? members = _Undefined,
  }) {
    return Workspace(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      visibility: visibility ?? this.visibility,
      members: members is List<_i2.Member>?
          ? members
          : this.members?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
