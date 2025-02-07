import 'package:flearn/main_source/data/dto/api_response_dto.dart';
import 'package:flearn/main_source/data/dto/character_dto.dart';
import 'package:flearn/main_source/domain/entity/character_entity.dart';
import 'package:flutter/material.dart';

abstract class CharacterRepository {
  Future<ApiResponseDto> getCharacters({int page = 0});
}

abstract class LocalCharacterRepository {
  Future<bool> saveCharactersPageToLocal({required int page, required List<CharacterDto> list});

  List<CharacterEntity> getCharactersPageFromLocal({required int page});

  @visibleForTesting
  String getKeyToCharacterPage(int page);
}
