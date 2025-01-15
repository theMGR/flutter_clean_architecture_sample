import 'package:flearn/common_src/constants/asset_constant.dart';
import 'package:flearn/common_src/flavor/flavor.dart';
import 'package:flearn/common_src/flavor/flavors_type.dart';

class AppImages {
  static Images get() {
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
abstract class Images {
  String appLogo();

  String appBarLogo();
}

//// LITE
class LiteImages extends Images {
  @override
  String appLogo() => AssetConstant.logoLite;

  @override
  String appBarLogo() => AssetConstant.logoLite;
}

//// FREE
class FreeImages extends Images {
  @override
  String appLogo() => AssetConstant.logoFree;

  @override
  String appBarLogo() => AssetConstant.logoFree;
}

//// PLUS
class PlusImages implements Images {
  @override
  String appLogo() => AssetConstant.logoPlus;

  @override
  String appBarLogo() => AssetConstant.logoPlus;
}
