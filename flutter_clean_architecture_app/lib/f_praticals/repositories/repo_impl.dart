import 'dart:convert';

import 'package:flearn/f_praticals/dto/albums_dto.dart';
import 'package:flearn/f_praticals/dto/api_response_dto.dart';
import 'package:http/http.dart' as http;

class RepoImpl {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/";

  static Future<ApiResponseDTO> fetchPhotos() async {
    http.Response response = await http.get(Uri.parse('${baseUrl}photos'));

    print("#### status code: ${response.statusCode}");

    ApiResponseDTO apiResponseDTO = ApiResponseDTO(statusCode: response.statusCode);

    if (response.statusCode == 200) {
      try {
        apiResponseDTO.data = (jsonDecode(response.body) as List).map((value) {
          print("#### $value");
          return PhotoDTO.fromJson(value);
        }).toList();
      } catch (e) {
        apiResponseDTO.error = 'Failed to load album: Error: $e';
        throw Exception('Failed to load album: Error: $e');
      }
    } else {
      apiResponseDTO.error = 'Failed to load album: status code: ${response.statusCode}';
      throw Exception('Failed to load album: status code: ${response.statusCode}');
    }
    return apiResponseDTO;
  }
}
