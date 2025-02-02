
import 'package:flearn/main_source/common_src/flavor/flavors_type.dart';

class Flavor {
  static const String flavor = String.fromEnvironment('FLAVOR');

  static get() {
    return flavor;
  }

  static isPlus() {
    if (get() == FlavorsType.plus || get() == FlavorsType.plusDev || get() == FlavorsType.plusQa || get() == FlavorsType.plusDemo || get() == FlavorsType.plusUat) {
      return true;
    } else {
      return false;
    }
  }

  static isLite() {
    if (get() == FlavorsType.lite || get() == FlavorsType.liteDev || get() == FlavorsType.liteQa || get() == FlavorsType.liteDemo || get() == FlavorsType.liteUat) {
      return true;
    } else {
      return false;
    }
  }

  static isFree() {
    if (get() == FlavorsType.free || get() == FlavorsType.freeDev || get() == FlavorsType.freeQa || get() == FlavorsType.freeDemo || get() == FlavorsType.freeUat) {
      return true;
    } else {
      return false;
    }
  }
}
