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
import 'dart:async' as _i2;
import 'package:my_pod_client/src/protocol/mobile_auth_model.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointMobileAuthEndPoint extends _i1.EndpointRef {
  EndpointMobileAuthEndPoint(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'mobileAuthEndPoint';

  _i2.Future<_i3.MobileAuthModel?> addMobileAuth(_i3.MobileAuthModel input) =>
      caller.callServerEndpoint<_i3.MobileAuthModel?>(
        'mobileAuthEndPoint',
        'addMobileAuth',
        {'input': input},
      );

  _i2.Future<_i3.MobileAuthModel?> getMobileAuthByPhone(String phone) =>
      caller.callServerEndpoint<_i3.MobileAuthModel?>(
        'mobileAuthEndPoint',
        'getMobileAuthByPhone',
        {'phone': phone},
      );

  _i2.Future<bool> updateToken(
    String phone,
    String token,
  ) =>
      caller.callServerEndpoint<bool>(
        'mobileAuthEndPoint',
        'updateToken',
        {
          'phone': phone,
          'token': token,
        },
      );

  _i2.Future<bool> verifyOTP(
    String phone,
    String otp,
  ) =>
      caller.callServerEndpoint<bool>(
        'mobileAuthEndPoint',
        'verifyOTP',
        {
          'phone': phone,
          'otp': otp,
        },
      );

  _i2.Future<String?> generateOTP(String phone) =>
      caller.callServerEndpoint<String?>(
        'mobileAuthEndPoint',
        'generateOTP',
        {'phone': phone},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    example = EndpointExample(this);
    mobileAuthEndPoint = EndpointMobileAuthEndPoint(this);
  }

  late final EndpointExample example;

  late final EndpointMobileAuthEndPoint mobileAuthEndPoint;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'mobileAuthEndPoint': mobileAuthEndPoint,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
