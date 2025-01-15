import 'dart:io';

import 'package:flearn/common_src/helper/utils/print_utils.dart';
import 'package:flutter/foundation.dart' as foundation_;
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocaleRepository {
  Future<bool> saveLanguageCodeToLocal({String languageCode = "en"});

  Future<String?> getLanguageCodeFromLocal();

  Future<bool> deleteLanguageCodeFromLocal();
}

class LocaleRepositoryImpl implements LocaleRepository {
  final String key = 'locale_key';

  @override
  Future<bool> saveLanguageCodeToLocal({String languageCode = "en"}) async {
    if (!foundation_.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.setString(key, languageCode);
      } catch (e) {
        Print.debug("SP:Exception : saveLanguageCodeToLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<String?> getLanguageCodeFromLocal() async {
    if (!foundation_.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(key);
      } catch (e) {
        Print.debug("SP:Exception: getLanguageCodeFromLocal :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteLanguageCodeFromLocal() async {
    if (!foundation_.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.remove(key);
      } catch (e) {
        //throw Exception();
        Print.debug("SP:Exception: deleteLanguageCodeFromLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }
}
