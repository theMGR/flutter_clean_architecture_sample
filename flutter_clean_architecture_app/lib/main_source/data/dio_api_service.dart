// lib/data/services/dio_api_service.dart
import 'package:dio/dio.dart';
import 'package:flearn/main_source/configuration/dio_client/dio_client.dart';

class DioApiService extends DioClient{
  DioApiService({required super.dio, required super.prefs});



  Future<Response> getUser(String userId) async {

    final response = await _dioClient.get('/getUser', params: {'userId': userId});
    return UserDto.fromJson(response.data);
  }

  Future<Response> createUser(UserDto user) async {
    final response = await _dioClient.post('/createUser', data: user.toJson());
    return UserDto.fromJson(response.data);
  }

  Future<String> uploadFile(String userId, String filePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
      'userId': userId,
    });
    final response = await _dioClient.postFormData('/uploadFile', formData);
    return response.data['imageUrl'];
  }

  Future<void> postImageUrl(String imageUrl) async {
    await _dioClient.post('/ImageUrl', data: {'imageUrl': imageUrl});
  }

  Future<String> login(String userName, String password) async {
    final response = await _dioClient.post('/login', data: {
      'userName': userName,
      'password': password,
    });
    return response.data['token'];
  }
}