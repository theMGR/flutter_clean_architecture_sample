import 'dart:convert';

import 'package:flutter/services.dart';

class CommonUtils {
  static Future<String> getJsonStringFromAsset(String jsonAssetPath) async{
    return await rootBundle.loadString(jsonAssetPath);
  }

  static Future<dynamic> getDecodedJsonFromAsset(String jsonAssetPath) async{
    return await json.decode(await getJsonStringFromAsset(jsonAssetPath));
  }

  static String getMinutesSeconds(int otpCountDownTimer) {
    return Duration(seconds: otpCountDownTimer).toString().substring(2, 7);
  }
}