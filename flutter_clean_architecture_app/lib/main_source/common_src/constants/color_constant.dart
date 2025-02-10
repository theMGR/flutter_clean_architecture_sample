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


  static const Color COLOR_LIGHT_GREY = Color(0x42000000);
  static const Color COLOR_WHITE = Color(0xFFFFFFFF);
  static const Color COLOR_GREY = Color(0xFFA2A1B9);
  static const Color LITE_BLACK = Color(0xFF454F63);
  static const Gradient_Dark_blue = Color(0xFF004E8C);
  static const Gradient_cyan =  Color(0xFF00C6CD);
  static const Gradient_Lite_blue = Color(0xFF5C88C5);
  static const Gradient_Dark_Yellow = Color(0xFFCBBE00);
  static const Gradient_Lite_Yellow = Color(0xFFFEF104);
  static const Online_offline_green = Color(0xFF009833);
  static const Color blue_1 = Color(0xFF004E8C);
  static const Color blue_2 = Color(0xFF074980);
  static const Color blue_3 = Color(0xFF4D77AF);
  static const Color blue_4 = Color(0xFF608ABE);
  static const Color blue_5 = Color(0xFF618CC6);
  static const Color blue_6 = Color(0xFF77B9ED);
  static const Color blue_7 = Color(0xFFFFFFFF);

  static const Color yellow_1 = Color(0xFFBDB818);
  static const Color yellow_2 = Color(0xFFCBBE00);
  static const Color yellow_3 = Color(0xFFFEF104);
  static const Color yellow_4 = Color(0xFFD9CF0F);

  static const Color green_1 = Color(0xFF00E05A);
  static const Color green_2 = Color(0xFF29B912);

  static const Color grey_light = Color(0xF818589);
  static const Color grey_1 = Color(0xFFF6F6F6);
  static const color_grey =  Color(0xFFA0A0A0);
}
