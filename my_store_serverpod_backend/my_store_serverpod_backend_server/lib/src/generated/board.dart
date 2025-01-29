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

abstract class Board implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = BoardTable();

  static const db = BoardRepository._();

  @override
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

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static BoardInclude include() {
    return BoardInclude._();
  }

  static BoardIncludeList includeList({
    _i1.WhereExpressionBuilder<BoardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BoardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BoardTable>? orderByList,
    BoardInclude? include,
  }) {
    return BoardIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Board.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Board.t),
      include: include,
    );
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

class BoardTable extends _i1.Table {
  BoardTable({super.tableRelation}) : super(tableName: 'board') {
    workspaceId = _i1.ColumnInt(
      'workspaceId',
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
    visibility = _i1.ColumnString(
      'visibility',
      this,
    );
    background = _i1.ColumnString(
      'background',
      this,
    );
    starred = _i1.ColumnBool(
      'starred',
      this,
    );
    enableCover = _i1.ColumnBool(
      'enableCover',
      this,
    );
    watch = _i1.ColumnBool(
      'watch',
      this,
    );
    availableOffline = _i1.ColumnBool(
      'availableOffline',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    emailAddress = _i1.ColumnString(
      'emailAddress',
      this,
    );
    commenting = _i1.ColumnInt(
      'commenting',
      this,
    );
    memberType = _i1.ColumnInt(
      'memberType',
      this,
    );
    pinned = _i1.ColumnBool(
      'pinned',
      this,
    );
    selfJoin = _i1.ColumnBool(
      'selfJoin',
      this,
    );
    close = _i1.ColumnBool(
      'close',
      this,
    );
  }

  late final _i1.ColumnInt workspaceId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString visibility;

  late final _i1.ColumnString background;

  late final _i1.ColumnBool starred;

  late final _i1.ColumnBool enableCover;

  late final _i1.ColumnBool watch;

  late final _i1.ColumnBool availableOffline;

  late final _i1.ColumnString label;

  late final _i1.ColumnString emailAddress;

  late final _i1.ColumnInt commenting;

  late final _i1.ColumnInt memberType;

  late final _i1.ColumnBool pinned;

  late final _i1.ColumnBool selfJoin;

  late final _i1.ColumnBool close;

  @override
  List<_i1.Column> get columns => [
        id,
        workspaceId,
        userId,
        name,
        description,
        visibility,
        background,
        starred,
        enableCover,
        watch,
        availableOffline,
        label,
        emailAddress,
        commenting,
        memberType,
        pinned,
        selfJoin,
        close,
      ];
}

class BoardInclude extends _i1.IncludeObject {
  BoardInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Board.t;
}

class BoardIncludeList extends _i1.IncludeList {
  BoardIncludeList._({
    _i1.WhereExpressionBuilder<BoardTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Board.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Board.t;
}

class BoardRepository {
  const BoardRepository._();

  Future<List<Board>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BoardTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BoardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BoardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Board>(
      where: where?.call(Board.t),
      orderBy: orderBy?.call(Board.t),
      orderByList: orderByList?.call(Board.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Board?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BoardTable>? where,
    int? offset,
    _i1.OrderByBuilder<BoardTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BoardTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Board>(
      where: where?.call(Board.t),
      orderBy: orderBy?.call(Board.t),
      orderByList: orderByList?.call(Board.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Board?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Board>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Board>> insert(
    _i1.Session session,
    List<Board> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Board>(
      rows,
      transaction: transaction,
    );
  }

  Future<Board> insertRow(
    _i1.Session session,
    Board row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Board>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Board>> update(
    _i1.Session session,
    List<Board> rows, {
    _i1.ColumnSelections<BoardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Board>(
      rows,
      columns: columns?.call(Board.t),
      transaction: transaction,
    );
  }

  Future<Board> updateRow(
    _i1.Session session,
    Board row, {
    _i1.ColumnSelections<BoardTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Board>(
      row,
      columns: columns?.call(Board.t),
      transaction: transaction,
    );
  }

  Future<List<Board>> delete(
    _i1.Session session,
    List<Board> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Board>(
      rows,
      transaction: transaction,
    );
  }

  Future<Board> deleteRow(
    _i1.Session session,
    Board row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Board>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Board>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BoardTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Board>(
      where: where(Board.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BoardTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Board>(
      where: where?.call(Board.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
