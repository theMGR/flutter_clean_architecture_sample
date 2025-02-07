import 'package:flearn/main_source/common_src/constants/release_constant.dart';
import 'package:flearn/main_source/common_src/flavor/flavor.dart';
import 'package:flearn/main_source/common_src/flavor/flavors_type.dart';
import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';

class LiteStrings implements StringsInterface {
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

  @override
  String liveLocationTitle() => 'Flearn Lite live location';
}
