import 'package:flearn/main_source/common_src/flavor/flavor.dart';
import 'package:flearn/main_source/common_src/flavor/flavors_type.dart';

import 'free/free_strings.dart';
import 'lite/lite_strings.dart';
import 'plus/plus_strings.dart';

class AppStrings {
  static StringsInterface get() {
    if (Flavor.get() == FlavorsType.plus || Flavor.get() == FlavorsType.plusDev || Flavor.get() == FlavorsType.plusQa || Flavor.get() == FlavorsType.plusDemo || Flavor.get() == FlavorsType.plusUat) {
      return PlusStrings();
    } else if (Flavor.get() == FlavorsType.lite || Flavor.get() == FlavorsType.liteDev || Flavor.get() == FlavorsType.liteQa || Flavor.get() == FlavorsType.liteUat || Flavor.get() == FlavorsType.liteDemo) {
      return LiteStrings();
    } else {
      return FreeStrings();
    }
  }
}

//// STRINGS
abstract class StringsInterface {
  String appName();

  String baseUrl();

  String webSocketUrl();

  String imageUploadUrl();

  String googleApiKey();

  String locBgNotificationChannelName();

  String locBgNotificationTitle();

  String locBgNotificationMsg();

  String liveLocationTitle();
}
