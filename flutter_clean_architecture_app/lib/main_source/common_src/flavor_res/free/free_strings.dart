import 'package:flearn/main_source/common_src/constants/release_constant.dart';
import 'package:flearn/main_source/common_src/flavor_res/app_strings.dart';

class FreeStrings implements StringsInterface {
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

  @override
  String liveLocationTitle() => 'Flearn free live location';
}
