import 'package:flearn/main_source/configuration/config/config.dart';
import 'package:flearn/main_source/data/dto/api_response_dto.dart';
import 'package:flearn/main_source/data/dto/character_dto.dart';
import 'package:flearn/main_source/data/source/local/prefs.dart';
import 'package:flearn/main_source/data/source/network/dio_api_service/dio_api_service.dart';
import 'package:flearn/main_source/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository, LocalCharacterRepository {
  final DioApiService dioApiService;
  final Prefs prefs;

  final String keyCharactersList = 'keyCharactersList';

  CharacterRepositoryImpl({required this.dioApiService, required this.prefs});

  @override
  Future<ApiResponseDto> getCharacters({int page = 0}) async {
    ApiResponseDto responseDto = ApiResponseDto();

    if (await hasInternetConnection() == true) {
      await dioApiService.getCharacters(page: page).then((response) async {
        responseDto.statusCode = response.statusCode;
        if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null) {
          final list = (response.data['results'] as List<dynamic>).map((e) => CharacterDto.fromJson(e)).toList();

          if (await saveCharactersPageToLocal(page: page, list: list) == true) {
            responseDto.data = list;
          } else {
            responseDto.hasError = true;
            responseDto.error = 'Error in saving to local';
          }
        } else {
          responseDto.hasError = true;
          responseDto.error = response.statusMessage;
        }
      }).catchError((e) {
        responseDto.hasError = true;
        responseDto.error = e;
      });
    } else {
      final cachedList = getCharactersPageFromLocal(page: page);
      if (cachedList.isEmpty) {
        responseDto.hasError = true;
        responseDto.error = 'No Internet connection';
      } else {
        responseDto.data = cachedList;
      }
    }

    return responseDto;
  }

  @override
  List<CharacterDto> getCharactersPageFromLocal({required int page}) {
    final key = getKeyToCharacterPage(page);
    final jsonList = prefs.get<List<String>>(key);

    return jsonList != null ? jsonList.map((e) => CharacterDto.fromRawJson(e)).toList() : [];
  }

  @override
  Future<bool> saveCharactersPageToLocal({required int page, required List<CharacterDto> list}) async {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    final key = getKeyToCharacterPage(page);
    return await prefs.save(key: key, value: jsonList);
  }

  @override
  String getKeyToCharacterPage(int page) {
    return '${keyCharactersList}_$page';
  }
}
