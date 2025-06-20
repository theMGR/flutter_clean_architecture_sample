import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String url, {bool? inApp}) async {
  Uri uri = Uri.parse("");
  Logger logger = Logger();
  if (url.startsWith("https://") ||
      url.startsWith("http://") ||
      url.startsWith("tel:") ||
      url.startsWith("sms:") ||
      url.startsWith("wa:") ||
      url.startsWith("tg:") ||
      url.startsWith("mailto:") ||
      url.startsWith("whatsapp")) {
    uri = Uri.parse(url);
  } else {
    uri = Uri.parse("https://$url");
  }
  if (await canLaunchUrl(uri)) {
    logger.i("launched $uri");

    if (inApp == null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(uri, mode: LaunchMode.inAppWebView, webOnlyWindowName: "Project X");
    }
  } else {
    logger.e("cant launch $uri");
  }
}
