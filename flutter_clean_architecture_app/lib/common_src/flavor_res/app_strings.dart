import 'package:flearn/common_src/constants/release_constant.dart';
import 'package:flearn/common_src/flavor/flavor.dart';
import 'package:flearn/common_src/flavor/flavors_type.dart';

class AppStrings {
  static Strings get() {
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
abstract class Strings {
  String appName();

  String baseUrl();

  String webSocketUrl();

  String imageUploadUrl();

  String googleApiKey();

  String locBgNotificationChannelName();

  String locBgNotificationTitle();

  String locBgNotificationMsg();
}

//// LITE
class LiteStrings implements Strings {
  @override
  String appName() => ReleaseConstant.appNameLite;

  @override
  String baseUrl() {
    if (Flavor.get() == FlavorsType.lite) {
      return ReleaseConstant.baseUrlLiteLive;
    } else if (Flavor.get() == FlavorsType.liteDev) {
      return ReleaseConstant.baseUrlLiteDev;
    } else if (Flavor.get() == FlavorsType.liteQa) {
      return ReleaseConstant.baseUrlLiteQa;
    } else if (Flavor.get() == FlavorsType.liteUat) {
      return ReleaseConstant.baseUrlLiteUat;
    } else if (Flavor.get() == FlavorsType.liteDemo) {
      return ReleaseConstant.baseUrlLiteDemo;
    } else {
      return ReleaseConstant.baseUrlLiteDev; // if no flavor selected, dev will be default
    }
  }

  @override
  String webSocketUrl() {
    if (Flavor.get() == FlavorsType.lite) {
      return ReleaseConstant.baseUrlLiteLive;
    } else if (Flavor.get() == FlavorsType.liteDev) {
      return ReleaseConstant.baseUrlLiteDev;
    } else if (Flavor.get() == FlavorsType.liteQa) {
      return ReleaseConstant.baseUrlLiteQa;
    } else if (Flavor.get() == FlavorsType.liteUat) {
      return ReleaseConstant.baseUrlLiteUat;
    } else if (Flavor.get() == FlavorsType.liteDemo) {
      return ReleaseConstant.baseUrlLiteDemo;
    } else {
      return ReleaseConstant.baseUrlLiteDev; // if no flavor selected, dev will be default
    }
  }

  @override
  String imageUploadUrl() {
    if (Flavor.get() == FlavorsType.lite) {
      return ReleaseConstant.imageUploadLiteLive;
    } else {
      return ReleaseConstant.imageUploadLite;
    }
  }

  @override
  String googleApiKey() {
    if (Flavor.get() == FlavorsType.lite) {
      return ReleaseConstant.googleApiLiteLive;
    } else {
      return ReleaseConstant.googleApiLite;
    }
  }

  @override
  String locBgNotificationChannelName() => "CABackgroundLocationTracking";

  @override
  String locBgNotificationTitle() => "Courier Alliance";

  @override
  String locBgNotificationMsg() => "Background SyncUp of orders going on";
}

//// FREE
class FreeStrings implements Strings {
  @override
  String appName() => ReleaseConstant.appNameFree;

  @override
  String baseUrl() {
    return ReleaseConstant.baseUrlFreeLive;
  }

  @override
  String webSocketUrl() {
    return ReleaseConstant.baseUrlFreeLive;
  }

  @override
  String imageUploadUrl() {
    return ReleaseConstant.imageUploadFreeLive;
  }

  @override
  String googleApiKey() {
    return ReleaseConstant.googleApiFreeLive;
  }

  @override
  String locBgNotificationChannelName() => "IEXBackgroundLocationTracking";

  @override
  String locBgNotificationTitle() => "ieX";

  @override
  String locBgNotificationMsg() => "Background SyncUp of IEX orders going on";
}

//// PLUS
class PlusStrings implements Strings {
  @override
  String appName() => ReleaseConstant.appNamePlus;

  @override
  String baseUrl() {
    if (Flavor.get() == FlavorsType.plus) {
      return ReleaseConstant.baseUrlPlusLive;
    } else if (Flavor.get() == FlavorsType.plusDev) {
      return ReleaseConstant.baseUrlPlusDev;
    } else if (Flavor.get() == FlavorsType.plusQa) {
      return ReleaseConstant.baseUrlPlusQa;
    } else if (Flavor.get() == FlavorsType.plusUat) {
      return ReleaseConstant.baseUrlPlusUat;
    } else if (Flavor.get() == FlavorsType.plusDemo) {
      return ReleaseConstant.baseUrlPlusDemo;
    } else {
      return ReleaseConstant.baseUrlPlusDev; // if no flavor selected, dev will be default
    }
  }

  @override
  String webSocketUrl() {
    if (Flavor.get() == FlavorsType.plus) {
      return ReleaseConstant.baseUrlPlusLive;
    } else if (Flavor.get() == FlavorsType.plusDev) {
      return ReleaseConstant.baseUrlPlusDev;
    } else if (Flavor.get() == FlavorsType.plusQa) {
      return ReleaseConstant.baseUrlPlusQa;
    } else if (Flavor.get() == FlavorsType.plusUat) {
      return ReleaseConstant.baseUrlPlusUat;
    } else if (Flavor.get() == FlavorsType.plusDemo) {
      return ReleaseConstant.baseUrlPlusDemo;
    } else {
      return ReleaseConstant.baseUrlPlusDev; // if no flavor selected, dev will be default
    }
  }

  @override
  String imageUploadUrl() {
    if (Flavor.get() == FlavorsType.plus) {
      return ReleaseConstant.imageUploadPlusLive;
    } else {
      return ReleaseConstant.imageUploadPlus;
    }
  }

  @override
  String googleApiKey() {
    if (Flavor.get() == FlavorsType.plus) {
      return ReleaseConstant.googleApiPlusLive;
    } else {
      return ReleaseConstant.googleApiPlus;
    }
  }

  @override
  String locBgNotificationChannelName() => "CABackgroundLocationTracking";

  @override
  String locBgNotificationTitle() => "Courier Alliance";

  @override
  String locBgNotificationMsg() => "Background SyncUp of orders going on";
}
