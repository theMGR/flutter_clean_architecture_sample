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
import '../endpoints/example_endpoint.dart' as _i2;
import '../endpoints/mobile_auth_endpoints.dart' as _i3;
import 'package:my_pod_server/src/generated/mobile_auth_model.dart' as _i4;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'example': _i2.ExampleEndpoint()
        ..initialize(
          server,
          'example',
          null,
        ),
      'mobileAuthEndPoint': _i3.MobileAuthEndPoint()
        ..initialize(
          server,
          'mobileAuthEndPoint',
          null,
        ),
    };
    connectors['example'] = _i1.EndpointConnector(
      name: 'example',
      endpoint: endpoints['example']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['example'] as _i2.ExampleEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
    connectors['mobileAuthEndPoint'] = _i1.EndpointConnector(
      name: 'mobileAuthEndPoint',
      endpoint: endpoints['mobileAuthEndPoint']!,
      methodConnectors: {
        'addMobileAuth': _i1.MethodConnector(
          name: 'addMobileAuth',
          params: {
            'input': _i1.ParameterDescription(
              name: 'input',
              type: _i1.getType<_i4.MobileAuthModel>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['mobileAuthEndPoint'] as _i3.MobileAuthEndPoint)
                  .addMobileAuth(
            session,
            params['input'],
          ),
        ),
        'getMobileAuthByPhone': _i1.MethodConnector(
          name: 'getMobileAuthByPhone',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['mobileAuthEndPoint'] as _i3.MobileAuthEndPoint)
                  .getMobileAuthByPhone(
            session,
            params['phone'],
          ),
        ),
        'updateToken': _i1.MethodConnector(
          name: 'updateToken',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['mobileAuthEndPoint'] as _i3.MobileAuthEndPoint)
                  .updateToken(
            session,
            params['phone'],
            params['token'],
          ),
        ),
        'verifyOTP': _i1.MethodConnector(
          name: 'verifyOTP',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'otp': _i1.ParameterDescription(
              name: 'otp',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['mobileAuthEndPoint'] as _i3.MobileAuthEndPoint)
                  .verifyOTP(
            session,
            params['phone'],
            params['otp'],
          ),
        ),
        'generateOTP': _i1.MethodConnector(
          name: 'generateOTP',
          params: {
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['mobileAuthEndPoint'] as _i3.MobileAuthEndPoint)
                  .generateOTP(
            session,
            params['phone'],
          ),
        ),
      },
    );
  }
}
