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

abstract class MobileAuthModel
    implements _i1.TableRow, _i1.ProtocolSerialization {
  MobileAuthModel._({
    this.id,
    this.phone,
    this.otp,
    this.token,
    this.otpExpiration,
    this.createdAt,
    this.updatedAt,
  });

  factory MobileAuthModel({
    int? id,
    String? phone,
    String? otp,
    String? token,
    DateTime? otpExpiration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MobileAuthModelImpl;

  factory MobileAuthModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return MobileAuthModel(
      id: jsonSerialization['id'] as int?,
      phone: jsonSerialization['phone'] as String?,
      otp: jsonSerialization['otp'] as String?,
      token: jsonSerialization['token'] as String?,
      otpExpiration: jsonSerialization['otpExpiration'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['otpExpiration']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MobileAuthModelTable();

  static const db = MobileAuthModelRepository._();

  @override
  int? id;

  String? phone;

  String? otp;

  String? token;

  DateTime? otpExpiration;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table get table => t;

  MobileAuthModel copyWith({
    int? id,
    String? phone,
    String? otp,
    String? token,
    DateTime? otpExpiration,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (phone != null) 'phone': phone,
      if (otp != null) 'otp': otp,
      if (token != null) 'token': token,
      if (otpExpiration != null) 'otpExpiration': otpExpiration?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (phone != null) 'phone': phone,
      if (otp != null) 'otp': otp,
      if (token != null) 'token': token,
      if (otpExpiration != null) 'otpExpiration': otpExpiration?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static MobileAuthModelInclude include() {
    return MobileAuthModelInclude._();
  }

  static MobileAuthModelIncludeList includeList({
    _i1.WhereExpressionBuilder<MobileAuthModelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MobileAuthModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MobileAuthModelTable>? orderByList,
    MobileAuthModelInclude? include,
  }) {
    return MobileAuthModelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MobileAuthModel.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MobileAuthModel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MobileAuthModelImpl extends MobileAuthModel {
  _MobileAuthModelImpl({
    int? id,
    String? phone,
    String? otp,
    String? token,
    DateTime? otpExpiration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          phone: phone,
          otp: otp,
          token: token,
          otpExpiration: otpExpiration,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  MobileAuthModel copyWith({
    Object? id = _Undefined,
    Object? phone = _Undefined,
    Object? otp = _Undefined,
    Object? token = _Undefined,
    Object? otpExpiration = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return MobileAuthModel(
      id: id is int? ? id : this.id,
      phone: phone is String? ? phone : this.phone,
      otp: otp is String? ? otp : this.otp,
      token: token is String? ? token : this.token,
      otpExpiration:
          otpExpiration is DateTime? ? otpExpiration : this.otpExpiration,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class MobileAuthModelTable extends _i1.Table {
  MobileAuthModelTable({super.tableRelation})
      : super(tableName: 'mobile_auth') {
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    otp = _i1.ColumnString(
      'otp',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
    otpExpiration = _i1.ColumnDateTime(
      'otpExpiration',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnString phone;

  late final _i1.ColumnString otp;

  late final _i1.ColumnString token;

  late final _i1.ColumnDateTime otpExpiration;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        phone,
        otp,
        token,
        otpExpiration,
        createdAt,
        updatedAt,
      ];
}

class MobileAuthModelInclude extends _i1.IncludeObject {
  MobileAuthModelInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => MobileAuthModel.t;
}

class MobileAuthModelIncludeList extends _i1.IncludeList {
  MobileAuthModelIncludeList._({
    _i1.WhereExpressionBuilder<MobileAuthModelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MobileAuthModel.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => MobileAuthModel.t;
}

class MobileAuthModelRepository {
  const MobileAuthModelRepository._();

  Future<List<MobileAuthModel>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MobileAuthModelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MobileAuthModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MobileAuthModelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MobileAuthModel>(
      where: where?.call(MobileAuthModel.t),
      orderBy: orderBy?.call(MobileAuthModel.t),
      orderByList: orderByList?.call(MobileAuthModel.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<MobileAuthModel?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MobileAuthModelTable>? where,
    int? offset,
    _i1.OrderByBuilder<MobileAuthModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MobileAuthModelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MobileAuthModel>(
      where: where?.call(MobileAuthModel.t),
      orderBy: orderBy?.call(MobileAuthModel.t),
      orderByList: orderByList?.call(MobileAuthModel.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<MobileAuthModel?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MobileAuthModel>(
      id,
      transaction: transaction,
    );
  }

  Future<List<MobileAuthModel>> insert(
    _i1.Session session,
    List<MobileAuthModel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MobileAuthModel>(
      rows,
      transaction: transaction,
    );
  }

  Future<MobileAuthModel> insertRow(
    _i1.Session session,
    MobileAuthModel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MobileAuthModel>(
      row,
      transaction: transaction,
    );
  }

  Future<List<MobileAuthModel>> update(
    _i1.Session session,
    List<MobileAuthModel> rows, {
    _i1.ColumnSelections<MobileAuthModelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MobileAuthModel>(
      rows,
      columns: columns?.call(MobileAuthModel.t),
      transaction: transaction,
    );
  }

  Future<MobileAuthModel> updateRow(
    _i1.Session session,
    MobileAuthModel row, {
    _i1.ColumnSelections<MobileAuthModelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MobileAuthModel>(
      row,
      columns: columns?.call(MobileAuthModel.t),
      transaction: transaction,
    );
  }

  Future<List<MobileAuthModel>> delete(
    _i1.Session session,
    List<MobileAuthModel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MobileAuthModel>(
      rows,
      transaction: transaction,
    );
  }

  Future<MobileAuthModel> deleteRow(
    _i1.Session session,
    MobileAuthModel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MobileAuthModel>(
      row,
      transaction: transaction,
    );
  }

  Future<List<MobileAuthModel>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MobileAuthModelTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MobileAuthModel>(
      where: where(MobileAuthModel.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MobileAuthModelTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MobileAuthModel>(
      where: where?.call(MobileAuthModel.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
