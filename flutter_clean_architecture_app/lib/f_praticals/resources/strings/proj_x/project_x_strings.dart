import 'package:flearn/f_praticals/flavor/flavor.dart';
import 'package:flearn/f_praticals/flavor/flavors_type.dart';
import 'package:flearn/f_praticals/resources/strings/strings.dart';
import 'package:flearn/f_praticals/source/constants/release_constant.dart';

class ProjectXStrings extends Strings {
  @override
  String get appName => ReleaseConstant.appNameProjectM;

  @override
  String get baseUrl {
    String flavor = Flavor.flavor;
    if (flavor == FlavorsType.projectX) {
      return ReleaseConstant.X_LIVE_URL;
    } else if (flavor == FlavorsType.projectXDev) {
      return ReleaseConstant.X_DEV_URL;
    } else {
      return super.baseUrl;
    }
  }

  @override
  String get locBgNotificationChannelName => ReleaseConstant.X_locBgNotificationChannelName;

  @override
  String get locBgNotificationMsg => ReleaseConstant.X_locBgNotificationMsg;

  @override
  String get locBgNotificationTitle => ReleaseConstant.X_locBgNotificationTitle;

  @override
  String get webSocketUrl {
    String flavor = Flavor.flavor;
    if (flavor == FlavorsType.projectX) {
      return ReleaseConstant.X_LIVE_WEB_SOCKET_URL;
    } else if (flavor == FlavorsType.projectXDev) {
      return ReleaseConstant.X_DEV_WEB_SOCKET_URL;
    } else {
      return super.webSocketUrl;
    }
  }
}
