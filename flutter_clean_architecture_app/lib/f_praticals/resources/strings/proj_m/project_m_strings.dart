import 'package:flearn/f_praticals/flavor/flavor.dart';
import 'package:flearn/f_praticals/flavor/flavors_type.dart';
import 'package:flearn/f_praticals/resources/strings/strings.dart';
import 'package:flearn/f_praticals/source/constants/release_constant.dart';

class ProjectMStrings extends Strings {
  @override
  String get appName => ReleaseConstant.appNameProjectM;

  @override
  String get baseUrl {
    String flavor = Flavor.flavor;
    if (flavor == FlavorsType.projectX) {
      return ReleaseConstant.M_LIVE_URL;
    } else if (flavor == FlavorsType.projectXDev) {
      return ReleaseConstant.M_DEV_URL;
    } else {
      return super.baseUrl;
    }
  }

  @override
  String get locBgNotificationChannelName => ReleaseConstant.M_locBgNotificationChannelName;

  @override
  String get locBgNotificationMsg => ReleaseConstant.M_locBgNotificationMsg;

  @override
  String get locBgNotificationTitle => ReleaseConstant.M_locBgNotificationTitle;

  @override
  String get webSocketUrl {
    String flavor = Flavor.flavor;
    if (flavor == FlavorsType.projectX) {
      return ReleaseConstant.M_LIVE_WEB_SOCKET_URL;
    } else if (flavor == FlavorsType.projectXDev) {
      return ReleaseConstant.M_DEV_WEB_SOCKET_URL;
    } else {
      return super.webSocketUrl;
    }
  }
}
