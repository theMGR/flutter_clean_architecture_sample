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

abstract class Attachment implements _i1.SerializableModel {
  Attachment._({
    this.id,
    required this.userId,
    required this.cardId,
    required this.attachment,
  });

  factory Attachment({
    int? id,
    required int userId,
    required int cardId,
    required String attachment,
  }) = _AttachmentImpl;

  factory Attachment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Attachment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      cardId: jsonSerialization['cardId'] as int,
      attachment: jsonSerialization['attachment'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int cardId;

  String attachment;

  Attachment copyWith({
    int? id,
    int? userId,
    int? cardId,
    String? attachment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'cardId': cardId,
      'attachment': attachment,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttachmentImpl extends Attachment {
  _AttachmentImpl({
    int? id,
    required int userId,
    required int cardId,
    required String attachment,
  }) : super._(
          id: id,
          userId: userId,
          cardId: cardId,
          attachment: attachment,
        );

  @override
  Attachment copyWith({
    Object? id = _Undefined,
    int? userId,
    int? cardId,
    String? attachment,
  }) {
    return Attachment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      cardId: cardId ?? this.cardId,
      attachment: attachment ?? this.attachment,
    );
  }
}
