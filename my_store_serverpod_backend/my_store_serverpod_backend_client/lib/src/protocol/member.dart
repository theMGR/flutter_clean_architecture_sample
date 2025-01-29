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

abstract class Member implements _i1.SerializableModel {
  Member._({
    this.id,
    required this.workspaceId,
    required this.userId,
    required this.name,
    required this.role,
  });

  factory Member({
    int? id,
    required int workspaceId,
    required int userId,
    required String name,
    required String role,
  }) = _MemberImpl;

  factory Member.fromJson(Map<String, dynamic> jsonSerialization) {
    return Member(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      role: jsonSerialization['role'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workspaceId;

  int userId;

  String name;

  String role;

  Member copyWith({
    int? id,
    int? workspaceId,
    int? userId,
    String? name,
    String? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'userId': userId,
      'name': name,
      'role': role,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemberImpl extends Member {
  _MemberImpl({
    int? id,
    required int workspaceId,
    required int userId,
    required String name,
    required String role,
  }) : super._(
          id: id,
          workspaceId: workspaceId,
          userId: userId,
          name: name,
          role: role,
        );

  @override
  Member copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? userId,
    String? name,
    String? role,
  }) {
    return Member(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }
}
