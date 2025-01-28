/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Attachment implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = AttachmentTable();

  static const db = AttachmentRepository._();

  @override
  int? id;

  int userId;

  int cardId;

  String attachment;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'cardId': cardId,
      'attachment': attachment,
    };
  }

  static AttachmentInclude include() {
    return AttachmentInclude._();
  }

  static AttachmentIncludeList includeList({
    _i1.WhereExpressionBuilder<AttachmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttachmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttachmentTable>? orderByList,
    AttachmentInclude? include,
  }) {
    return AttachmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attachment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Attachment.t),
      include: include,
    );
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

class AttachmentTable extends _i1.Table {
  AttachmentTable({super.tableRelation}) : super(tableName: 'attachment') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    cardId = _i1.ColumnInt(
      'cardId',
      this,
    );
    attachment = _i1.ColumnString(
      'attachment',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt cardId;

  late final _i1.ColumnString attachment;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        cardId,
        attachment,
      ];
}

class AttachmentInclude extends _i1.IncludeObject {
  AttachmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Attachment.t;
}

class AttachmentIncludeList extends _i1.IncludeList {
  AttachmentIncludeList._({
    _i1.WhereExpressionBuilder<AttachmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Attachment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Attachment.t;
}

class AttachmentRepository {
  const AttachmentRepository._();

  Future<List<Attachment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AttachmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttachmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttachmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Attachment>(
      where: where?.call(Attachment.t),
      orderBy: orderBy?.call(Attachment.t),
      orderByList: orderByList?.call(Attachment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Attachment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AttachmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<AttachmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttachmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Attachment>(
      where: where?.call(Attachment.t),
      orderBy: orderBy?.call(Attachment.t),
      orderByList: orderByList?.call(Attachment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Attachment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Attachment>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Attachment>> insert(
    _i1.Session session,
    List<Attachment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Attachment>(
      rows,
      transaction: transaction,
    );
  }

  Future<Attachment> insertRow(
    _i1.Session session,
    Attachment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Attachment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Attachment>> update(
    _i1.Session session,
    List<Attachment> rows, {
    _i1.ColumnSelections<AttachmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Attachment>(
      rows,
      columns: columns?.call(Attachment.t),
      transaction: transaction,
    );
  }

  Future<Attachment> updateRow(
    _i1.Session session,
    Attachment row, {
    _i1.ColumnSelections<AttachmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Attachment>(
      row,
      columns: columns?.call(Attachment.t),
      transaction: transaction,
    );
  }

  Future<List<Attachment>> delete(
    _i1.Session session,
    List<Attachment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Attachment>(
      rows,
      transaction: transaction,
    );
  }

  Future<Attachment> deleteRow(
    _i1.Session session,
    Attachment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Attachment>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Attachment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AttachmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Attachment>(
      where: where(Attachment.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AttachmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Attachment>(
      where: where?.call(Attachment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
