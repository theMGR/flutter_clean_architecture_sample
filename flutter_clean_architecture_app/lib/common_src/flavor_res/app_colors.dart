import 'package:flearn/common_src/constants/color_constant.dart';
import 'package:flearn/common_src/flavor/flavor.dart';
import 'package:flearn/common_src/flavor/flavors_type.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Colors get() {
    if (Flavor.get() == FlavorsType.plus || Flavor.get() == FlavorsType.plusDev || Flavor.get() == FlavorsType.plusQa || Flavor.get() == FlavorsType.plusDemo || Flavor.get() == FlavorsType.plusUat) {
      return PlusColors();
    } else if (Flavor.get() == FlavorsType.lite || Flavor.get() == FlavorsType.liteDev || Flavor.get() == FlavorsType.liteQa || Flavor.get() == FlavorsType.liteUat || Flavor.get() == FlavorsType.liteDemo) {
      return LiteColors();
    } else {
      return FreeColors();
    }
  }
}

//// COLORS
abstract class Colors {
  Color buttonColor();
}

/*class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}*/

//// LITE
class LiteColors implements Colors {
  @override
  Color buttonColor() => ColorConstant.liteButtonColor;
}

//// FREE
class FreeColors implements Colors {
  @override
  Color buttonColor() => ColorConstant.freeButtonColor;
}

//// PLUS
class PlusColors implements Colors {
  @override
  Color buttonColor() => ColorConstant.plusButtonColor;
}
