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

abstract class Board implements _i1.SerializableModel {
  Board._({
    this.id,
    required this.workspaceId,
    required this.userId,
    required this.name,
    this.description,
    required this.visibility,
    required this.background,
    this.starred,
    this.enableCover,
    this.watch,
    this.availableOffline,
    this.label,
    this.emailAddress,
    this.commenting,
    this.memberType,
    this.pinned,
    this.selfJoin,
    this.close,
  });

  factory Board({
    int? id,
    required int workspaceId,
    required int userId,
    required String name,
    String? description,
    required String visibility,
    required String background,
    bool? starred,
    bool? enableCover,
    bool? watch,
    bool? availableOffline,
    String? label,
    String? emailAddress,
    int? commenting,
    int? memberType,
    bool? pinned,
    bool? selfJoin,
    bool? close,
  }) = _BoardImpl;

  factory Board.fromJson(Map<String, dynamic> jsonSerialization) {
    return Board(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      visibility: jsonSerialization['visibility'] as String,
      background: jsonSerialization['background'] as String,
      starred: jsonSerialization['starred'] as bool?,
      enableCover: jsonSerialization['enableCover'] as bool?,
      watch: jsonSerialization['watch'] as bool?,
      availableOffline: jsonSerialization['availableOffline'] as bool?,
      label: jsonSerialization['label'] as String?,
      emailAddress: jsonSerialization['emailAddress'] as String?,
      commenting: jsonSerialization['commenting'] as int?,
      memberType: jsonSerialization['memberType'] as int?,
      pinned: jsonSerialization['pinned'] as bool?,
      selfJoin: jsonSerialization['selfJoin'] as bool?,
      close: jsonSerialization['close'] as bool?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workspaceId;

  int userId;

  String name;

  String? description;

  String visibility;

  String background;

  bool? starred;

  bool? enableCover;

  bool? watch;

  bool? availableOffline;

  String? label;

  String? emailAddress;

  int? commenting;

  int? memberType;

  bool? pinned;

  bool? selfJoin;

  bool? close;

  Board copyWith({
    int? id,
    int? workspaceId,
    int? userId,
    String? name,
    String? description,
    String? visibility,
    String? background,
    bool? starred,
    bool? enableCover,
    bool? watch,
    bool? availableOffline,
    String? label,
    String? emailAddress,
    int? commenting,
    int? memberType,
    bool? pinned,
    bool? selfJoin,
    bool? close,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'userId': userId,
      'name': name,
      if (description != null) 'description': description,
      'visibility': visibility,
      'background': background,
      if (starred != null) 'starred': starred,
      if (enableCover != null) 'enableCover': enableCover,
      if (watch != null) 'watch': watch,
      if (availableOffline != null) 'availableOffline': availableOffline,
      if (label != null) 'label': label,
      if (emailAddress != null) 'emailAddress': emailAddress,
      if (commenting != null) 'commenting': commenting,
      if (memberType != null) 'memberType': memberType,
      if (pinned != null) 'pinned': pinned,
      if (selfJoin != null) 'selfJoin': selfJoin,
      if (close != null) 'close': close,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BoardImpl extends Board {
  _BoardImpl({
    int? id,
    required int workspaceId,
    required int userId,
    required String name,
    String? description,
    required String visibility,
    required String background,
    bool? starred,
    bool? enableCover,
    bool? watch,
    bool? availableOffline,
    String? label,
    String? emailAddress,
    int? commenting,
    int? memberType,
    bool? pinned,
    bool? selfJoin,
    bool? close,
  }) : super._(
          id: id,
          workspaceId: workspaceId,
          userId: userId,
          name: name,
          description: description,
          visibility: visibility,
          background: background,
          starred: starred,
          enableCover: enableCover,
          watch: watch,
          availableOffline: availableOffline,
          label: label,
          emailAddress: emailAddress,
          commenting: commenting,
          memberType: memberType,
          pinned: pinned,
          selfJoin: selfJoin,
          close: close,
        );

  @override
  Board copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    int? userId,
    String? name,
    Object? description = _Undefined,
    String? visibility,
    String? background,
    Object? starred = _Undefined,
    Object? enableCover = _Undefined,
    Object? watch = _Undefined,
    Object? availableOffline = _Undefined,
    Object? label = _Undefined,
    Object? emailAddress = _Undefined,
    Object? commenting = _Undefined,
    Object? memberType = _Undefined,
    Object? pinned = _Undefined,
    Object? selfJoin = _Undefined,
    Object? close = _Undefined,
  }) {
    return Board(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      visibility: visibility ?? this.visibility,
      background: background ?? this.background,
      starred: starred is bool? ? starred : this.starred,
      enableCover: enableCover is bool? ? enableCover : this.enableCover,
      watch: watch is bool? ? watch : this.watch,
      availableOffline:
          availableOffline is bool? ? availableOffline : this.availableOffline,
      label: label is String? ? label : this.label,
      emailAddress: emailAddress is String? ? emailAddress : this.emailAddress,
      commenting: commenting is int? ? commenting : this.commenting,
      memberType: memberType is int? ? memberType : this.memberType,
      pinned: pinned is bool? ? pinned : this.pinned,
      selfJoin: selfJoin is bool? ? selfJoin : this.selfJoin,
      close: close is bool? ? close : this.close,
    );
  }
}
