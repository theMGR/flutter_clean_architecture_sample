import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

class TalkerDioInterceptor extends TalkerDioLogger {


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
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
}