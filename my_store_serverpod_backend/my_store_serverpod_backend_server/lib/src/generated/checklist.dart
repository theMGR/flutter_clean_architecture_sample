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

abstract class CheckList implements _i1.TableRow, _i1.ProtocolSerialization {
  CheckList._({
    this.id,
    required this.cardId,
    required this.name,
    required this.status,
  });

  factory CheckList({
    int? id,
    required int cardId,
    required String name,
    required bool status,
  }) = _CheckListImpl;

  factory CheckList.fromJson(Map<String, dynamic> jsonSerialization) {
    return CheckList(
      id: jsonSerialization['id'] as int?,
      cardId: jsonSerialization['cardId'] as int,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as bool,
    );
  }

  static final t = CheckListTable();

  static const db = CheckListRepository._();

  @override
  int? id;

  int cardId;

  String name;

  bool status;

  @override
  _i1.Table get table => t;

  CheckList copyWith({
    int? id,
    int? cardId,
    String? name,
    bool? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cardId': cardId,
      'name': name,
      'status': status,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'cardId': cardId,
      'name': name,
      'status': status,
    };
  }

  static CheckListInclude include() {
    return CheckListInclude._();
  }

  static CheckListIncludeList includeList({
    _i1.WhereExpressionBuilder<CheckListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CheckListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CheckListTable>? orderByList,
    CheckListInclude? include,
  }) {
    return CheckListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CheckList.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CheckList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CheckListImpl extends CheckList {
  _CheckListImpl({
    int? id,
    required int cardId,
    required String name,
    required bool status,
  }) : super._(
          id: id,
          cardId: cardId,
          name: name,
          status: status,
        );

  @override
  CheckList copyWith({
    Object? id = _Undefined,
    int? cardId,
    String? name,
    bool? status,
  }) {
    return CheckList(
      id: id is int? ? id : this.id,
      cardId: cardId ?? this.cardId,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}

class CheckListTable extends _i1.Table {
  CheckListTable({super.tableRelation}) : super(tableName: 'checklist') {
    cardId = _i1.ColumnInt(
      'cardId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    status = _i1.ColumnBool(
      'status',
      this,
    );
  }

  late final _i1.ColumnInt cardId;

  late final _i1.ColumnString name;

  late final _i1.ColumnBool status;

  @override
  List<_i1.Column> get columns => [
        id,
        cardId,
        name,
        status,
      ];
}

class CheckListInclude extends _i1.IncludeObject {
  CheckListInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => CheckList.t;
}

class CheckListIncludeList extends _i1.IncludeList {
  CheckListIncludeList._({
    _i1.WhereExpressionBuilder<CheckListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CheckList.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => CheckList.t;
}

class CheckListRepository {
  const CheckListRepository._();

  Future<List<CheckList>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CheckListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CheckListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CheckListTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CheckList>(
      where: where?.call(CheckList.t),
      orderBy: orderBy?.call(CheckList.t),
      orderByList: orderByList?.call(CheckList.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<CheckList?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CheckListTable>? where,
    int? offset,
    _i1.OrderByBuilder<CheckListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CheckListTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CheckList>(
      where: where?.call(CheckList.t),
      orderBy: orderBy?.call(CheckList.t),
      orderByList: orderByList?.call(CheckList.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<CheckList?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CheckList>(
      id,
      transaction: transaction,
    );
  }

  Future<List<CheckList>> insert(
    _i1.Session session,
    List<CheckList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CheckList>(
      rows,
      transaction: transaction,
    );
  }

  Future<CheckList> insertRow(
    _i1.Session session,
    CheckList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CheckList>(
      row,
      transaction: transaction,
    );
  }

  Future<List<CheckList>> update(
    _i1.Session session,
    List<CheckList> rows, {
    _i1.ColumnSelections<CheckListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CheckList>(
      rows,
      columns: columns?.call(CheckList.t),
      transaction: transaction,
    );
  }

  Future<CheckList> updateRow(
    _i1.Session session,
    CheckList row, {
    _i1.ColumnSelections<CheckListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CheckList>(
      row,
      columns: columns?.call(CheckList.t),
      transaction: transaction,
    );
  }

  Future<List<CheckList>> delete(
    _i1.Session session,
    List<CheckList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CheckList>(
      rows,
      transaction: transaction,
    );
  }

  Future<CheckList> deleteRow(
    _i1.Session session,
    CheckList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CheckList>(
      row,
      transaction: transaction,
    );
  }

  Future<List<CheckList>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CheckListTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CheckList>(
      where: where(CheckList.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CheckListTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CheckList>(
      where: where?.call(CheckList.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
