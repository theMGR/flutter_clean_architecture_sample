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
import 'member.dart' as _i2;

abstract class Workspace implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = WorkspaceTable();

  static const db = WorkspaceRepository._();

  @override
  int? id;

  int userId;

  String name;

  String description;

  String visibility;

  List<_i2.Member>? members;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'visibility': visibility,
      if (members != null)
        'members': members?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static WorkspaceInclude include() {
    return WorkspaceInclude._();
  }

  static WorkspaceIncludeList includeList({
    _i1.WhereExpressionBuilder<WorkspaceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkspaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkspaceTable>? orderByList,
    WorkspaceInclude? include,
  }) {
    return WorkspaceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Workspace.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Workspace.t),
      include: include,
    );
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

class WorkspaceTable extends _i1.Table {
  WorkspaceTable({super.tableRelation}) : super(tableName: 'workspace') {
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
    visibility = _i1.ColumnString(
      'visibility',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString visibility;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        name,
        description,
        visibility,
      ];
}

class WorkspaceInclude extends _i1.IncludeObject {
  WorkspaceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Workspace.t;
}

class WorkspaceIncludeList extends _i1.IncludeList {
  WorkspaceIncludeList._({
    _i1.WhereExpressionBuilder<WorkspaceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Workspace.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Workspace.t;
}

class WorkspaceRepository {
  const WorkspaceRepository._();

  Future<List<Workspace>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkspaceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WorkspaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkspaceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Workspace>(
      where: where?.call(Workspace.t),
      orderBy: orderBy?.call(Workspace.t),
      orderByList: orderByList?.call(Workspace.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Workspace?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkspaceTable>? where,
    int? offset,
    _i1.OrderByBuilder<WorkspaceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WorkspaceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Workspace>(
      where: where?.call(Workspace.t),
      orderBy: orderBy?.call(Workspace.t),
      orderByList: orderByList?.call(Workspace.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Workspace?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Workspace>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Workspace>> insert(
    _i1.Session session,
    List<Workspace> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Workspace>(
      rows,
      transaction: transaction,
    );
  }

  Future<Workspace> insertRow(
    _i1.Session session,
    Workspace row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Workspace>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Workspace>> update(
    _i1.Session session,
    List<Workspace> rows, {
    _i1.ColumnSelections<WorkspaceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Workspace>(
      rows,
      columns: columns?.call(Workspace.t),
      transaction: transaction,
    );
  }

  Future<Workspace> updateRow(
    _i1.Session session,
    Workspace row, {
    _i1.ColumnSelections<WorkspaceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Workspace>(
      row,
      columns: columns?.call(Workspace.t),
      transaction: transaction,
    );
  }

  Future<List<Workspace>> delete(
    _i1.Session session,
    List<Workspace> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Workspace>(
      rows,
      transaction: transaction,
    );
  }

  Future<Workspace> deleteRow(
    _i1.Session session,
    Workspace row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Workspace>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Workspace>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WorkspaceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Workspace>(
      where: where(Workspace.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WorkspaceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Workspace>(
      where: where?.call(Workspace.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
