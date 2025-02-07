import 'package:dio/dio.dart' as dio_;
import 'package:flearn/main_source/configuration/dio_client/dio_client.dart';
import 'package:get/get.dart' as get_;

import 'dio_api_interface.dart';

class DioApiService extends DioClient implements DioApiInterface {
  DioApiService({required super.dio, required super.prefs});

  @override
  Future<dio_.Response> getCharacters({int page = 0}) async {
    final response = await get('api/character/?page=$page', baseUrl: 'https://rickandmortyapi.com/');
    return response;
  }
}

/*
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
}*/
