
import 'package:flearn/common_src/flavor/flavors_type.dart';

class Flavor {
  static const String flavor = String.fromEnvironment('FLAVOR');

  static get() {
    return flavor;
  }

  static isPlus() {
    if (get() == FlavorsType.plus ||
        get() == FlavorsType.plusDev ||
        get() == FlavorsType.plusQa ||
        get() == FlavorsType.plusDemo ||
        get() == FlavorsType.plusUat) {
      return true;
    } else {
      return false;
    }
  }
}
