import 'package:flearn/f_praticals/flavor/flavor.dart';
import 'package:flearn/f_praticals/resources/images/images.dart';
import 'package:flearn/f_praticals/resources/images/proj_m/project_m_images.dart';
import 'package:flearn/f_praticals/resources/images/proj_x/project_x_images.dart';

class AppImages {
  static Images? get() {
    if (Flavor.isProjectX()) {
      return ProjectXImages();
    } else if (Flavor.isProjectM()) {
      return ProjectMImages();
    } else {
      return null;
    }
  }
}
