import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageService extends GetxService {
  static LanguageService get to => Get.find();

  final RxString _locale = 'en'.obs;
  final List<String> supportedLocales = ['en', 'es', 'hi'];

  String get currentLocale => _locale.value;

  String getCurrentLanguageName() {
    switch (_locale.value) {
      case 'en':
        return 'english'.tr;
      case 'es':
        return 'spanish'.tr;
      case 'hi':
        return 'hindi'.tr;
      default:
        return 'english'.tr;
    }
  }

  Future<LanguageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    _locale.value = prefs.getString('language') ?? 'en';
    return this;
  }

  Future<void> changeLanguage(String languageCode) async {
    if (!supportedLocales.contains(languageCode)) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    _locale.value = languageCode;
    Get.updateLocale(Locale(languageCode));
    }
}