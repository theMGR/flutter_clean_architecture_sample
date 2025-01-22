import 'package:flearn/f_praticals/flavor/flavors_type.dart';

class Flavor {
  static const String flavor = String.fromEnvironment('FLAVOR');

  // static String get() => flavor;

  static bool isProjectX() {
    return flavor == FlavorsType.projectX || flavor == FlavorsType.projectXDev;
  }

  static bool isProjectM() {
    return flavor == FlavorsType.projectX || flavor == FlavorsType.projectXDev;
  }
}
