import 'package:flutter/material.dart';
import 'package:github_client_app/models/profile_change_notifier.dart';
import 'package:github_client_app/common/Global.dart';

class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认蓝色
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == profile.theme, orElse: () => Colors.blue);
  // 主题改变后，通知依赖项， 新主题立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      profile.theme = color[500]?.value ?? 0;
      notifyListeners();
    }
  }
}
