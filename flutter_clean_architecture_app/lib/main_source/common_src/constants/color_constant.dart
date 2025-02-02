import 'package:flearn/main_source/common_src/flavor_res/app_colors.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class ColorConstant {
  static Color buttonColor = AppColors.get().buttonColor();

  static Color freeButtonColor = Color(0xFF0091EA); //Light Blue 50 #E1F5FE
  static Color liteButtonColor = Color(0xFF00C853); //Green 50 #E8F5E9
  static Color plusButtonColor = Color(0xFFD50000); // Red 50 #FFEBEE

  static const List<Color> groupColors = [
    ColorConstant.green,
    ColorConstant.blue,
    ColorConstant.purple,
    ColorConstant.skyBlue,
    ColorConstant.grey,
  ];

  static const Color green = Color(0xFFB1CD00);
  static const Color blue = Color(0xFF00849D);
  static const Color purple = Color(0xFFDB50FF);
  static const Color skyBlue = Color(0xFF509CFF);
  static const Color grey = Color(0xFF9C9C9C);
}
