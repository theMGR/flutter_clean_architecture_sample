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

abstract class Activity implements _i1.TableRow, _i1.ProtocolSerialization {
  Activity._({
    this.id,
    required this.boardId,
    required this.userId,
    required this.cardId,
    required this.description,
    required this.dateCreated,
  });

  factory Activity({
    int? id,
    required int boardId,
    required int userId,
    required int cardId,
    required String description,
    required DateTime dateCreated,
  }) = _ActivityImpl;

  factory Activity.fromJson(Map<String, dynamic> jsonSerialization) {
    return Activity(
      id: jsonSerialization['id'] as int?,
      boardId: jsonSerialization['boardId'] as int,
      userId: jsonSerialization['userId'] as int,
      cardId: jsonSerialization['cardId'] as int,
      description: jsonSerialization['description'] as String,
      dateCreated:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dateCreated']),
    );
  }

  static final t = ActivityTable();

  static const db = ActivityRepository._();

  @override
  int? id;

  int boardId;

  int userId;

  int cardId;

  String description;

  DateTime dateCreated;

  @override
  _i1.Table get table => t;

  Activity copyWith({
    int? id,
    int? boardId,
    int? userId,
    int? cardId,
    String? description,
    DateTime? dateCreated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'boardId': boardId,
      'userId': userId,
      'cardId': cardId,
      'description': description,
      'dateCreated': dateCreated.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'boardId': boardId,
      'userId': userId,
      'cardId': cardId,
      'description': description,
      'dateCreated': dateCreated.toJson(),
    };
  }

  static ActivityInclude include() {
    return ActivityInclude._();
  }

  static ActivityIncludeList includeList({
    _i1.WhereExpressionBuilder<ActivityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityTable>? orderByList,
    ActivityInclude? include,
  }) {
    return ActivityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Activity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Activity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityImpl extends Activity {
  _ActivityImpl({
    int? id,
    required int boardId,
    required int userId,
    required int cardId,
    required String description,
    required DateTime dateCreated,
  }) : super._(
          id: id,
          boardId: boardId,
          userId: userId,
          cardId: cardId,
          description: description,
          dateCreated: dateCreated,
        );

  @override
  Activity copyWith({
    Object? id = _Undefined,
    int? boardId,
    int? userId,
    int? cardId,
    String? description,
    DateTime? dateCreated,
  }) {
    return Activity(
      id: id is int? ? id : this.id,
      boardId: boardId ?? this.boardId,
      userId: userId ?? this.userId,
      cardId: cardId ?? this.cardId,
      description: description ?? this.description,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}

class ActivityTable extends _i1.Table {
  ActivityTable({super.tableRelation}) : super(tableName: 'activity') {
    boardId = _i1.ColumnInt(
      'boardId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    cardId = _i1.ColumnInt(
      'cardId',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    dateCreated = _i1.ColumnDateTime(
      'dateCreated',
      this,
    );
  }

  late final _i1.ColumnInt boardId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt cardId;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime dateCreated;

  @override
  List<_i1.Column> get columns => [
        id,
        boardId,
        userId,
        cardId,
        description,
        dateCreated,
      ];
}

class ActivityInclude extends _i1.IncludeObject {
  ActivityInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Activity.t;
}

class ActivityIncludeList extends _i1.IncludeList {
  ActivityIncludeList._({
    _i1.WhereExpressionBuilder<ActivityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Activity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Activity.t;
}

class ActivityRepository {
  const ActivityRepository._();

  Future<List<Activity>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Activity>(
      where: where?.call(Activity.t),
      orderBy: orderBy?.call(Activity.t),
      orderByList: orderByList?.call(Activity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Activity?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityTable>? where,
    int? offset,
    _i1.OrderByBuilder<ActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Activity>(
      where: where?.call(Activity.t),
      orderBy: orderBy?.call(Activity.t),
      orderByList: orderByList?.call(Activity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Activity?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Activity>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Activity>> insert(
    _i1.Session session,
    List<Activity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Activity>(
      rows,
      transaction: transaction,
    );
  }

  Future<Activity> insertRow(
    _i1.Session session,
    Activity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Activity>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Activity>> update(
    _i1.Session session,
    List<Activity> rows, {
    _i1.ColumnSelections<ActivityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Activity>(
      rows,
      columns: columns?.call(Activity.t),
      transaction: transaction,
    );
  }

  Future<Activity> updateRow(
    _i1.Session session,
    Activity row, {
    _i1.ColumnSelections<ActivityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Activity>(
      row,
      columns: columns?.call(Activity.t),
      transaction: transaction,
    );
  }

  Future<List<Activity>> delete(
    _i1.Session session,
    List<Activity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Activity>(
      rows,
      transaction: transaction,
    );
  }

  Future<Activity> deleteRow(
    _i1.Session session,
    Activity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Activity>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Activity>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ActivityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Activity>(
      where: where(Activity.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Activity>(
      where: where?.call(Activity.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
