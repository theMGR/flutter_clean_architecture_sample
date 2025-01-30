import 'package:flutter/foundation.dart';
import 'package:flearn/flutter_architecture_sample/layers/domain/entity/character.dart';

class CharacterDetailsChangeNotifier extends ChangeNotifier {
  CharacterDetailsChangeNotifier({required this.character});

  final Character character;
}
