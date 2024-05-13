import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationChecker {
  static changeLanguage(BuildContext context) {
    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == const Locale('en', 'US')) {
      EasyLocalization.of(context)!.setLocale(const Locale('vi', 'VN'));
    } else {
      EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
    }
  }
}
