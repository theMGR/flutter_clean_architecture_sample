import 'package:flearn/flutter_architecture_sample/layers/domain/entity/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({int page = 0});
}
