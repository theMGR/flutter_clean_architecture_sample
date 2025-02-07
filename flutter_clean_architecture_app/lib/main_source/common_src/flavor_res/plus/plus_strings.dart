import 'package:flearn/main_source/common_src/constants/release_constant.dart';
import 'package:flearn/main_source/common_src/flavor/flavor.dart';
import 'package:flearn/main_source/common_src/flavor/flavors_type.dart';
import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';

class PlusStrings implements StringsInterface {
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

  @override
  String liveLocationTitle() => 'Flearn Plus live location';
}
