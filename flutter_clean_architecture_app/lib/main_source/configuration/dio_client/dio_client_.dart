import 'package:dio/dio.dart';

class DioClient_ {
  final Dio _dio = Dio();
  String? _bearerToken;

  DioClient_._() {}

  DioClient_(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);

    // Add interceptors for token refresh logic
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 401 || error.type == DioExceptionType.connectionTimeout) {
          // Refresh token if timed out or unauthorized
          await _refreshToken();
          // Retry the original request
          return handler.resolve(await _retryRequest(error.requestOptions));
        }
        return handler.next(error);
      },
    ));
  }

  Future<void> _refreshToken() async {
    // Call the getBearerToken API to refresh the token
    final response = await _dio.post('/getBearerToken', data: {
      'userName': 'your_username', // Replace with actual username
      'password': 'your_password', // Replace with actual password
    });
    _bearerToken = response.data['token'];
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {'Authorization': 'Bearer $_bearerToken'},
    );
    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(url, queryParameters: params);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String url, {dynamic data}) async {
    try {
      return await _dio.post(url, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> postFormData(String url, FormData formData) async {
    try {
      return await _dio.post(url, data: formData);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Request timed out';
    } else {
      return 'An error occurred: ${e.message}';
    }
  }
}