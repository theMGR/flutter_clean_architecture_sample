class ApiResponseDto {
  String? error;
  int? statusCode;
  dynamic data;

  ApiResponseDto({this.error, this.statusCode, this.data});
}
