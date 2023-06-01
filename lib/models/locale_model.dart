import 'package:flutter/material.dart';
import 'package:github_client_app/models/profile_change_notifier.dart';

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale? getLocale() {
    if (profile.locale == null) return null;
    var t = profile.locale?.split("_");
    return Locale(t![0], t![1]);
  }

  // 获取当前Locale的字符串
  String? get locale => profile.locale;

  // 用户改变App语言后，通知依赖项更新
  set locale(String? locale) {
    if (locale != profile.locale) {
      profile.locale = locale;
      notifyListeners();
    }
  }
}
