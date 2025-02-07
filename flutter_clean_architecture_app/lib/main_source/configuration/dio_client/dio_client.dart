import 'package:dio/dio.dart';
import 'package:flearn/main_source/common_src/constants/value_constant.dart';
import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';
import 'package:flearn/main_source/configuration/dio_client/talker_dio_interceptor.dart';
import 'package:flearn/main_source/configuration/error/failure.dart';
import 'package:flearn/main_source/configuration/firebase/firebase_crashlogger.dart';
import 'package:flearn/main_source/data/dto/location_status_dto.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flutter/foundation.dart';

import '../config/either.dart';
import 'isolate_parser.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient with FirebaseCrashLogger {
  final bool isUnitTest;

  final Prefs prefs;
  final Dio dio;

  DioClient({required this.dio, required this.prefs, this.isUnitTest = false}) {
    if (!isUnitTest) {
      //dio.interceptors.add(DioInterceptor(this));
      dio.interceptors.add(TalkerDioInterceptor(
        dioClient: this,
        onRefreshToken: () async {
          return prefs.getBearerToken() ?? '';
        },
      ));
    }
  }

  Future<Either<Failure, dynamic>> getEither(
    String url, {
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    bool requireBearerToken = true,
    String? baseUrl,
    ResponseConverter<dynamic>? isolateConverter,
  }) async {
    try {
      if (requireBearerToken == false) {
        dio.options.headers.remove(ValueConstant.authorization);
      } else {
        if (dio.options.headers.keys.contains(ValueConstant.authorization) == false || dio.options.headers[ValueConstant.authorization] == null) {
          dio.options.headers.putIfAbsent(ValueConstant.authorization, () async => ValueConstant.onGetBearerToken(prefs.getBearerToken()));
        }
      }

      if (baseUrl != null) {
        dio.options.baseUrl = baseUrl;
      } else {
        dio.options.baseUrl = AppStrings.get().baseUrl();
      }

      final response = await dio.get(url, queryParameters: queryParameters, onReceiveProgress: onReceiveProgress);
      if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      } else {
        if (isolateConverter != null) {
          final isolateParse = IsolateParser<dynamic>(
            response.data as Map<String, dynamic>,
            isolateConverter,
          );
          final result = await isolateParse.parseInBackground();
          return Either.right(result);
        } else {
          return Either.right(response.data);
        }
      }
    } on DioException catch (e, stackTrace) {
      if (!isUnitTest) {
        nonFatalError(error: e, stackTrace: stackTrace);
      }
      return Either.left(
        ServerFailure(e.response?.data['error'] as String? ?? e.message),
      );
    }
  }

  Future<Either<Failure, dynamic>> postEither(
    String url, {
    dynamic data,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
    bool requireBearerToken = true,
    String? baseUrl,
    ResponseConverter<dynamic>? isolateConverter,
  }) async {
    try {
      if (requireBearerToken == false) {
        dio.options.headers.remove(ValueConstant.authorization);
      } else {
        if (dio.options.headers.keys.contains(ValueConstant.authorization) == false || dio.options.headers[ValueConstant.authorization] == null) {
          dio.options.headers.putIfAbsent(ValueConstant.authorization, () async => ValueConstant.onGetBearerToken(prefs.getBearerToken()));
        }
      }

      if (baseUrl != null) {
        dio.options.baseUrl = baseUrl;
      } else {
        dio.options.baseUrl = AppStrings.get().baseUrl();
      }

      final response = await dio.post(url, data: data, onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
      if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      } else {
        if (isolateConverter != null) {
          final isolateParse = IsolateParser<dynamic>(response.data as Map<String, dynamic>, isolateConverter);
          final result = await isolateParse.parseInBackground();
          return Either.right(result);
        } else {
          return Either.right(response.data);
        }
      }
    } on DioException catch (e, stackTrace) {
      if (!isUnitTest) {
        nonFatalError(error: e, stackTrace: stackTrace);
      }
      return Either.left(
        ServerFailure(e.response?.data['error'] as String? ?? e.message),
      );
    }
  }

  Future<Response> get(String url, {Map<String, dynamic>? params, ProgressCallback? onReceiveProgress, bool requireBearerToken = true, String? baseUrl}) async {
    try {
      if (requireBearerToken == false) {
        dio.options.headers.remove(ValueConstant.authorization);
      } else {
        if (dio.options.headers.keys.contains(ValueConstant.authorization) == false || dio.options.headers[ValueConstant.authorization] == null) {
          dio.options.headers.putIfAbsent(ValueConstant.authorization, () async => ValueConstant.onGetBearerToken(prefs.getBearerToken()));
        }
      }

      if (baseUrl != null) {
        dio.options.baseUrl = baseUrl;
      } else {
        dio.options.baseUrl = AppStrings.get().baseUrl();
      }

      return await dio.get(url, queryParameters: params, onReceiveProgress: onReceiveProgress);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String url, {dynamic data, ProgressCallback? onReceiveProgress, ProgressCallback? onSendProgress, bool requireBearerToken = true, String? baseUrl}) async {
    try {
      if (requireBearerToken == false) {
        dio.options.headers.remove(ValueConstant.authorization);
      } else {
        if (dio.options.headers.keys.contains(ValueConstant.authorization) == false || dio.options.headers[ValueConstant.authorization] == null) {
          dio.options.headers.putIfAbsent(ValueConstant.authorization, () async => ValueConstant.onGetBearerToken(prefs.getBearerToken()));
        }
      }

      if (baseUrl != null) {
        dio.options.baseUrl = baseUrl;
      } else {
        dio.options.baseUrl = AppStrings.get().baseUrl();
      }

      return await dio.post(url, data: data, onReceiveProgress: onReceiveProgress, onSendProgress: onSendProgress);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      return 'Request timed out';
    } else {
      return 'An error occurred: ${e.message}';
    }
  }
}

void howToUse(Dio dio, Prefs prefs) async {
  final dioClient = DioClient(dio: dio, prefs: prefs);

  final result = await dioClient.getEither(
    '/getUser',
    queryParameters: {'userId': '123'},
  );

  result.fold(
    onLeft: (failure) {
      if (failure is ServerFailure) {}
      debugPrint('Error: ${failure is ServerFailure}');
    },
    onRight: (response) {
      final user = LocationStatusDto.fromJson(response); // Parse the response here
      debugPrint('User: ${user.userId}');
    },
  );
}
