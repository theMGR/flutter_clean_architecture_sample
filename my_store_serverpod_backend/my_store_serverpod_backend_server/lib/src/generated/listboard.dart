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
import 'card.dart' as _i2;

abstract class ListBoard implements _i1.TableRow, _i1.ProtocolSerialization {
  ListBoard._({
    this.id,
    required this.boardId,
    required this.userId,
    required this.name,
    this.archived,
    this.cards,
  });

  factory ListBoard({
    int? id,
    required int boardId,
    required int userId,
    required String name,
    bool? archived,
    List<_i2.Card>? cards,
  }) = _ListBoardImpl;

  factory ListBoard.fromJson(Map<String, dynamic> jsonSerialization) {
    return ListBoard(
      id: jsonSerialization['id'] as int?,
      boardId: jsonSerialization['boardId'] as int,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      archived: jsonSerialization['archived'] as bool?,
      cards: (jsonSerialization['cards'] as List?)
          ?.map((e) => _i2.Card.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = ListBoardTable();

  static const db = ListBoardRepository._();

  @override
  int? id;

  int boardId;

  int userId;

  String name;

  bool? archived;

  List<_i2.Card>? cards;

  @override
  _i1.Table get table => t;

  ListBoard copyWith({
    int? id,
    int? boardId,
    int? userId,
    String? name,
    bool? archived,
    List<_i2.Card>? cards,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'boardId': boardId,
      'userId': userId,
      'name': name,
      if (archived != null) 'archived': archived,
      if (cards != null)
        'cards': cards?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static ListBoardInclude include() {
    return ListBoardInclude._();
  }

  static ListBoardIncludeList includeList({
    _i1.WhereExpressionBuilder<ListBoardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListBoardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListBoardTable>? orderByList,
    ListBoardInclude? include,
  }) {
    return ListBoardIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ListBoard.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ListBoard.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListBoardImpl extends ListBoard {
  _ListBoardImpl({
    int? id,
    required int boardId,
    required int userId,
    required String name,
    bool? archived,
    List<_i2.Card>? cards,
  }) : super._(
          id: id,
          boardId: boardId,
          userId: userId,
          name: name,
          archived: archived,
          cards: cards,
        );

  @override
  ListBoard copyWith({
    Object? id = _Undefined,
    int? boardId,
    int? userId,
    String? name,
    Object? archived = _Undefined,
    Object? cards = _Undefined,
  }) {
    return ListBoard(
      id: id is int? ? id : this.id,
      boardId: boardId ?? this.boardId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      archived: archived is bool? ? archived : this.archived,
      cards: cards is List<_i2.Card>?
          ? cards
          : this.cards?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ListBoardTable extends _i1.Table {
  ListBoardTable({super.tableRelation}) : super(tableName: 'listboard') {
    boardId = _i1.ColumnInt(
      'boardId',
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
    archived = _i1.ColumnBool(
      'archived',
      this,
    );
  }

  late final _i1.ColumnInt boardId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnBool archived;

  @override
  List<_i1.Column> get columns => [
        id,
        boardId,
        userId,
        name,
        archived,
      ];
}

class ListBoardInclude extends _i1.IncludeObject {
  ListBoardInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => ListBoard.t;
}

class ListBoardIncludeList extends _i1.IncludeList {
  ListBoardIncludeList._({
    _i1.WhereExpressionBuilder<ListBoardTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ListBoard.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => ListBoard.t;
}

class ListBoardRepository {
  const ListBoardRepository._();

  Future<List<ListBoard>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListBoardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListBoardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListBoardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ListBoard>(
      where: where?.call(ListBoard.t),
      orderBy: orderBy?.call(ListBoard.t),
      orderByList: orderByList?.call(ListBoard.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<ListBoard?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListBoardTable>? where,
    int? offset,
    _i1.OrderByBuilder<ListBoardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListBoardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ListBoard>(
      where: where?.call(ListBoard.t),
      orderBy: orderBy?.call(ListBoard.t),
      orderByList: orderByList?.call(ListBoard.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<ListBoard?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ListBoard>(
      id,
      transaction: transaction,
    );
  }

  Future<List<ListBoard>> insert(
    _i1.Session session,
    List<ListBoard> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ListBoard>(
      rows,
      transaction: transaction,
    );
  }

  Future<ListBoard> insertRow(
    _i1.Session session,
    ListBoard row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ListBoard>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ListBoard>> update(
    _i1.Session session,
    List<ListBoard> rows, {
    _i1.ColumnSelections<ListBoardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ListBoard>(
      rows,
      columns: columns?.call(ListBoard.t),
      transaction: transaction,
    );
  }

  Future<ListBoard> updateRow(
    _i1.Session session,
    ListBoard row, {
    _i1.ColumnSelections<ListBoardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ListBoard>(
      row,
      columns: columns?.call(ListBoard.t),
      transaction: transaction,
    );
  }

  Future<List<ListBoard>> delete(
    _i1.Session session,
    List<ListBoard> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ListBoard>(
      rows,
      transaction: transaction,
    );
  }

  Future<ListBoard> deleteRow(
    _i1.Session session,
    ListBoard row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ListBoard>(
      row,
      transaction: transaction,
    );
  }

  Future<List<ListBoard>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ListBoardTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ListBoard>(
      where: where(ListBoard.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListBoardTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ListBoard>(
      where: where?.call(ListBoard.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
