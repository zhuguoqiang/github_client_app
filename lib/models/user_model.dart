import 'package:github_client_app/models/profile_change_notifier.dart';
import 'package:github_client_app/models/index.dart';

class UserModel extends ProfileChangeNotifier {
  User? get user => profile.user;

  // APP 是否登录
  bool get isLogin => user != null;

  // 用户信息发生变化，更新信息，通知依赖它的子孙Widgets
  set user(User? user) {
    if (user?.login != profile.user?.login) {
      profile.lastLogin = profile.user?.login;
      profile.user = user;
      notifyListeners();
    }
  }
}
