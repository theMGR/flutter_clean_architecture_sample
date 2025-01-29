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

abstract class Listboard implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = ListboardTable();

  static const db = ListboardRepository._();

  @override
  int? id;

  int boardId;

  int userId;

  String name;

  bool? archived;

  List<_i2.Cardlist>? cards;

  @override
  _i1.Table get table => t;

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

  static ListboardInclude include() {
    return ListboardInclude._();
  }

  static ListboardIncludeList includeList({
    _i1.WhereExpressionBuilder<ListboardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListboardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListboardTable>? orderByList,
    ListboardInclude? include,
  }) {
    return ListboardIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Listboard.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Listboard.t),
      include: include,
    );
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

class ListboardTable extends _i1.Table {
  ListboardTable({super.tableRelation}) : super(tableName: 'listboard') {
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

class ListboardInclude extends _i1.IncludeObject {
  ListboardInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Listboard.t;
}

class ListboardIncludeList extends _i1.IncludeList {
  ListboardIncludeList._({
    _i1.WhereExpressionBuilder<ListboardTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Listboard.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Listboard.t;
}

class ListboardRepository {
  const ListboardRepository._();

  Future<List<Listboard>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListboardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ListboardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListboardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Listboard>(
      where: where?.call(Listboard.t),
      orderBy: orderBy?.call(Listboard.t),
      orderByList: orderByList?.call(Listboard.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Listboard?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListboardTable>? where,
    int? offset,
    _i1.OrderByBuilder<ListboardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ListboardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Listboard>(
      where: where?.call(Listboard.t),
      orderBy: orderBy?.call(Listboard.t),
      orderByList: orderByList?.call(Listboard.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Listboard?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Listboard>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Listboard>> insert(
    _i1.Session session,
    List<Listboard> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Listboard>(
      rows,
      transaction: transaction,
    );
  }

  Future<Listboard> insertRow(
    _i1.Session session,
    Listboard row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Listboard>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Listboard>> update(
    _i1.Session session,
    List<Listboard> rows, {
    _i1.ColumnSelections<ListboardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Listboard>(
      rows,
      columns: columns?.call(Listboard.t),
      transaction: transaction,
    );
  }

  Future<Listboard> updateRow(
    _i1.Session session,
    Listboard row, {
    _i1.ColumnSelections<ListboardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Listboard>(
      row,
      columns: columns?.call(Listboard.t),
      transaction: transaction,
    );
  }

  Future<List<Listboard>> delete(
    _i1.Session session,
    List<Listboard> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Listboard>(
      rows,
      transaction: transaction,
    );
  }

  Future<Listboard> deleteRow(
    _i1.Session session,
    Listboard row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Listboard>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Listboard>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ListboardTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Listboard>(
      where: where(Listboard.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ListboardTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Listboard>(
      where: where?.call(Listboard.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
