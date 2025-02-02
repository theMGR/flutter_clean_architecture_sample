
import 'package:flearn/main_source/common_src/lang/strings_bengali.dart';
import 'package:flearn/main_source/common_src/lang/strings_gujarati.dart';
import 'package:flearn/main_source/common_src/lang/strings_hindi.dart';
import 'package:flearn/main_source/common_src/lang/strings_telugu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../strings_english.dart';
import '../strings_tamil.dart';
import 'locale_repository.dart';

class TranslationService extends Translations {
  static Locale? get deviceLocale => Locale(Get.deviceLocale?.languageCode ?? "en");

  static String getLanguage(String code) {
    switch (code) {
      case 'bn':
        return 'বাংলা';
      case 'gu':
        return 'ગુજરાતી';
      case 'hi':
        return 'हिंदी';
      case 'ta':
        return 'தமிழ்';
      case 'te':
        return 'తెలుగు';

      case 'en':
      default:
        return 'English';
    }
  }

  static List<Locale> supportedLocales = [Locale("en"), Locale("ta"), Locale("hi"), Locale("te"), Locale("bn"), Locale("gu")];
  static final fallbackLocale = Locale("en");

  static List<String> listLanguageCodes() {
    List<String> list = [];
    for (Locale locale in supportedLocales) {
      list.add(locale.languageCode);
    }

    return list;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        "en": StringsEnglish.keyValues,
        "bn": StringsBengali.keyValues,
        "gu": StringsGujarati.keyValues,
        "hi": StringsHindi.keyValues,
        "ta": StringsTamil.keyValues,
        "te": StringsTelugu.keyValues
      };


  // get locale from shared preference else default locale
  static Future<Locale?> getLocale() async {
    Locale? locale;
    LocaleRepository localeRepository = Get.find<LocaleRepositoryImpl>();

    try {
      String? languageCode = await localeRepository.getLanguageCodeFromLocal();
      //Print.Debug("MAIN updateValue LanguageCode $languageCode");

      if (languageCode != null) {
        locale = Locale(languageCode);
      } else {
        bool isSaved = await localeRepository.saveLanguageCodeToLocal(languageCode: TranslationService.fallbackLocale.languageCode);

        //Print.Debug("MAIN updateValue LanguageCode isSaved $isSaved");

        if (isSaved) {
          languageCode = await localeRepository.getLanguageCodeFromLocal();
          locale = Locale(languageCode ?? "en");
          //Print.Debug("MAIN updateValue getLanguageCodeFromLocal $languageCode");
        }
      }
    } catch (e) {
      //Print.Debug("MAIN updateValue LanguageCode exception $e");
      locale = TranslationService.fallbackLocale;
    }

    return locale;
  }
}
