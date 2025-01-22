import 'package:flearn/f_praticals/flavor/flavor.dart';
import 'package:flearn/f_praticals/resources/colors/colors.dart';
import 'package:flearn/f_praticals/resources/colors/proj_m/project_m_colors.dart';
import 'package:flearn/f_praticals/resources/colors/proj_x/project_x_colors.dart';
import 'package:flearn/f_praticals/resources/images/images.dart';
import 'package:flearn/f_praticals/resources/images/proj_m/project_m_images.dart';
import 'package:flearn/f_praticals/resources/images/proj_x/project_x_images.dart';

class AppColors {
  static ColorS? get() {
    if (Flavor.isProjectX()) {
      return ProjectXColors();
    } else if (Flavor.isProjectM()) {
      return ProjectMColors();
    } else {
      return null;
    }
  }
}
