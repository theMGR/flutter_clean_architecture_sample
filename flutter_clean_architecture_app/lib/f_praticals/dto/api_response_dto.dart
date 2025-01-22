class ApiResponseDTO {
  String? error;
  int? statusCode;
  dynamic data;

  ApiResponseDTO({this.error, this.statusCode, this.data});
}
