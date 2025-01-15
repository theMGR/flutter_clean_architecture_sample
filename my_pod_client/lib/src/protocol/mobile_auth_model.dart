/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class MobileAuthModel implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? phone;

  String? otp;

  String? token;

  DateTime? otpExpiration;

  DateTime? createdAt;

  DateTime? updatedAt;

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
