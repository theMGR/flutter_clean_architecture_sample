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

abstract class Card implements _i1.TableRow, _i1.ProtocolSerialization {
  Card._({
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

  factory Card({
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
  }) = _CardImpl;

  factory Card.fromJson(Map<String, dynamic> jsonSerialization) {
    return Card(
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

  static final t = CardTable();

  static const db = CardRepository._();

  @override
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

  @override
  _i1.Table get table => t;

  Card copyWith({
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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CardInclude include() {
    return CardInclude._();
  }

  static CardIncludeList includeList({
    _i1.WhereExpressionBuilder<CardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CardTable>? orderByList,
    CardInclude? include,
  }) {
    return CardIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Card.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Card.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CardImpl extends Card {
  _CardImpl({
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
  Card copyWith({
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
    return Card(
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

class CardTable extends _i1.Table {
  CardTable({super.tableRelation}) : super(tableName: 'card') {
    listId = _i1.ColumnInt(
      'listId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    dueDate = _i1.ColumnDateTime(
      'dueDate',
      this,
    );
    attachment = _i1.ColumnBool(
      'attachment',
      this,
    );
    archived = _i1.ColumnBool(
      'archived',
      this,
    );
    checklist = _i1.ColumnBool(
      'checklist',
      this,
    );
    comments = _i1.ColumnBool(
      'comments',
      this,
    );
  }

  late final _i1.ColumnInt listId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime dueDate;

  late final _i1.ColumnBool attachment;

  late final _i1.ColumnBool archived;

  late final _i1.ColumnBool checklist;

  late final _i1.ColumnBool comments;

  @override
  List<_i1.Column> get columns => [
        id,
        listId,
        userId,
        name,
        description,
        startDate,
        dueDate,
        attachment,
        archived,
        checklist,
        comments,
      ];
}

class CardInclude extends _i1.IncludeObject {
  CardInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Card.t;
}

class CardIncludeList extends _i1.IncludeList {
  CardIncludeList._({
    _i1.WhereExpressionBuilder<CardTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Card.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Card.t;
}

class CardRepository {
  const CardRepository._();

  Future<List<Card>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Card>(
      where: where?.call(Card.t),
      orderBy: orderBy?.call(Card.t),
      orderByList: orderByList?.call(Card.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Card?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CardTable>? where,
    int? offset,
    _i1.OrderByBuilder<CardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Card>(
      where: where?.call(Card.t),
      orderBy: orderBy?.call(Card.t),
      orderByList: orderByList?.call(Card.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Card?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Card>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Card>> insert(
    _i1.Session session,
    List<Card> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Card>(
      rows,
      transaction: transaction,
    );
  }

  Future<Card> insertRow(
    _i1.Session session,
    Card row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Card>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Card>> update(
    _i1.Session session,
    List<Card> rows, {
    _i1.ColumnSelections<CardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Card>(
      rows,
      columns: columns?.call(Card.t),
      transaction: transaction,
    );
  }

  Future<Card> updateRow(
    _i1.Session session,
    Card row, {
    _i1.ColumnSelections<CardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Card>(
      row,
      columns: columns?.call(Card.t),
      transaction: transaction,
    );
  }

  Future<List<Card>> delete(
    _i1.Session session,
    List<Card> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Card>(
      rows,
      transaction: transaction,
    );
  }

  Future<Card> deleteRow(
    _i1.Session session,
    Card row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Card>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Card>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CardTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Card>(
      where: where(Card.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CardTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Card>(
      where: where?.call(Card.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
