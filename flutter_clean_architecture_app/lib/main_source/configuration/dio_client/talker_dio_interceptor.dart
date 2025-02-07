import 'package:dio/dio.dart';
import 'package:flearn/main_source/configuration/dio_client/dio_client.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

class TalkerDioInterceptor extends TalkerDioLogger {
  Future<String> Function() onRefreshToken;
  DioClient dioClient;

  TalkerDioInterceptor({required this.dioClient, required this.onRefreshToken});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);

    if (err.response?.statusCode == 401 || err.type == DioExceptionType.connectionTimeout) {
      // Token expired, refresh the token
      String bearerToken = await onRefreshToken();

      // Retry the original request with the new token
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $bearerToken';

      try {
        final response = await dioClient.dio.request(
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
