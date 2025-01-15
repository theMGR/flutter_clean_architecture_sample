import 'package:flutter/foundation.dart';
import 'package:flearn/layers/domain/entity/character.dart';

class CharacterDetailsChangeNotifier extends ChangeNotifier {
  CharacterDetailsChangeNotifier({required this.character});

  final Character character;
}
