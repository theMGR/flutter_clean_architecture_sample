import 'package:flearn/f_praticals/flavor/flavor.dart';
import 'package:flearn/f_praticals/resources/strings/proj_m/project_m_strings.dart';
import 'package:flearn/f_praticals/resources/strings/proj_x/project_x_strings.dart';
import 'package:flearn/f_praticals/resources/strings/strings.dart';

class AppStrings {
  static Strings? get() {
    if (Flavor.isProjectX()) {
      return ProjectXStrings();
    } else if (Flavor.isProjectM()) {
      return ProjectMStrings();
    } else {
      return null;
    }
  }
}
