import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flearn/main_source/configuration/config/config.dart';
import 'package:flearn/main_source/configuration/dio_client/dio_client.dart';
import 'package:flearn/main_source/configuration/firebase/firebase_crashlogger.dart';
import 'package:flutter/material.dart';

class DioInterceptor extends Interceptor with FirebaseCrashLogger {
  final DioClient _dioClient;

  DioInterceptor(this._dioClient);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = "";
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    try {
      options.queryParameters.forEach(
        (k, v) => debugPrint(
          '► $k: $v',
        ),
      );
    } catch (_) {}
    try {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      final String prettyJson = encoder.convert(options.data);
      log.d(
        // ignore: unnecessary_null_comparison
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"${options.baseUrl}${options.path}"}\n\n"
        "Headers:\n"
        "$headerMessage\n"
        "❖ QueryParameters : \n"
        "Body: $prettyJson",
      );
    } catch (e, stackTrace) {
      log.e("Failed to extract json request $e");
      nonFatalError(error: e, stackTrace: stackTrace);
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log.e(
      "<-- ${err.message} ${err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}\n\n"
      "${err.response != null ? err.response!.data : 'Unknown Error'}",
    );

    nonFatalError(error: err, stackTrace: err.stackTrace);
    super.onError(err, handler);

    if (err.response?.statusCode == 401 || err.type == DioExceptionType.connectionTimeout) {
      // Token expired, refresh the token
      String? bearerToken = await _dioClient.refreshToken();

      // Retry the original request with the new token
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $bearerToken';

      try {
        final response = await _dioClient.dio.request(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            method: options.method,
            headers: options.headers,
          ),
        );
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    } else {
      return handler.next(err);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);
    log.d(
      // ignore: unnecessary_null_comparison
      "◀ ︎RESPONSE ${response.statusCode} ${response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL'}\n\n"
      "Headers:\n"
      "$headerMessage\n"
      "❖ Results : \n"
      "Response: $prettyJson",
    );
    super.onResponse(response, handler);
  }
}
