class ApiResponseDto {
  dynamic error;
  int? statusCode;
  String? statusMessage;
  dynamic data;
  bool hasError;

  ApiResponseDto({
    this.error,
    this.statusCode = 200,
    this.statusMessage = 'OK',
    this.data,
    this.hasError = false,
  });
}
