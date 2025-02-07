import 'package:flearn/main_source/common_src/flavor/flavor.dart';
import 'package:flearn/main_source/common_src/flavor/flavors_type.dart';

import 'free/free_images.dart';
import 'lite/lite_images.dart';
import 'plus/plus_images.dart';

class AppImages {
  static ImagesInterface get() {
    if (Flavor.get() == FlavorsType.plus || Flavor.get() == FlavorsType.plusDev || Flavor.get() == FlavorsType.plusQa || Flavor.get() == FlavorsType.plusDemo || Flavor.get() == FlavorsType.plusUat) {
      return PlusImages();
    } else if (Flavor.get() == FlavorsType.lite || Flavor.get() == FlavorsType.liteDev || Flavor.get() == FlavorsType.liteQa || Flavor.get() == FlavorsType.liteUat || Flavor.get() == FlavorsType.liteDemo) {
      return LiteImages();
    } else {
      return FreeImages();
    }
  }
}

//// IMAGES
abstract class ImagesInterface {
  String appLogo();

  String appBarLogo();
}
