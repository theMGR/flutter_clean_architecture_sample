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

abstract class Checklist implements _i1.TableRow, _i1.ProtocolSerialization {
  Checklist._({
    this.id,
    required this.cardId,
    required this.name,
    required this.status,
  });

  factory Checklist({
    int? id,
    required int cardId,
    required String name,
    required bool status,
  }) = _ChecklistImpl;

  factory Checklist.fromJson(Map<String, dynamic> jsonSerialization) {
    return Checklist(
      id: jsonSerialization['id'] as int?,
      cardId: jsonSerialization['cardId'] as int,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as bool,
    );
  }

  static final t = ChecklistTable();

  static const db = ChecklistRepository._();

  @override
  int? id;

  int cardId;

  String name;

  bool status;

  @override
  _i1.Table get table => t;

  Checklist copyWith({
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

  static ChecklistInclude include() {
    return ChecklistInclude._();
  }

  static ChecklistIncludeList includeList({
    _i1.WhereExpressionBuilder<ChecklistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChecklistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChecklistTable>? orderByList,
    ChecklistInclude? include,
  }) {
    return ChecklistIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Checklist.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Checklist.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChecklistImpl extends Checklist {
  _ChecklistImpl({
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
  Checklist copyWith({
    Object? id = _Undefined,
    int? cardId,
    String? name,
    bool? status,
  }) {
    return Checklist(
      id: id is int? ? id : this.id,
      cardId: cardId ?? this.cardId,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}

class ChecklistTable extends _i1.Table {
  ChecklistTable({super.tableRelation}) : super(tableName: 'checklist') {
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

class ChecklistInclude extends _i1.IncludeObject {
  ChecklistInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Checklist.t;
}

class ChecklistIncludeList extends _i1.IncludeList {
  ChecklistIncludeList._({
    _i1.WhereExpressionBuilder<ChecklistTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Checklist.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Checklist.t;
}

class ChecklistRepository {
  const ChecklistRepository._();

  Future<List<Checklist>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChecklistTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChecklistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChecklistTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Checklist>(
      where: where?.call(Checklist.t),
      orderBy: orderBy?.call(Checklist.t),
      orderByList: orderByList?.call(Checklist.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Checklist?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChecklistTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChecklistTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChecklistTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Checklist>(
      where: where?.call(Checklist.t),
      orderBy: orderBy?.call(Checklist.t),
      orderByList: orderByList?.call(Checklist.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Checklist?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Checklist>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Checklist>> insert(
    _i1.Session session,
    List<Checklist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Checklist>(
      rows,
      transaction: transaction,
    );
  }

  Future<Checklist> insertRow(
    _i1.Session session,
    Checklist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Checklist>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Checklist>> update(
    _i1.Session session,
    List<Checklist> rows, {
    _i1.ColumnSelections<ChecklistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Checklist>(
      rows,
      columns: columns?.call(Checklist.t),
      transaction: transaction,
    );
  }

  Future<Checklist> updateRow(
    _i1.Session session,
    Checklist row, {
    _i1.ColumnSelections<ChecklistTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Checklist>(
      row,
      columns: columns?.call(Checklist.t),
      transaction: transaction,
    );
  }

  Future<List<Checklist>> delete(
    _i1.Session session,
    List<Checklist> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Checklist>(
      rows,
      transaction: transaction,
    );
  }

  Future<Checklist> deleteRow(
    _i1.Session session,
    Checklist row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Checklist>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Checklist>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChecklistTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Checklist>(
      where: where(Checklist.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChecklistTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Checklist>(
      where: where?.call(Checklist.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
