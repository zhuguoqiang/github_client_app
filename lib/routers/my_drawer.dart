import 'package:flutter/material.dart';
import 'package:github_client_app/common/gm_avatar.dart';
import 'package:github_client_app/models/user_model.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_buildHeader(), Expanded(child: _buildMenus())],
          )),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel value, Widget? child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: value.isLogin
                      ? gmAvatar(value.user!.avatar_url, width: 80)
                      : Image.asset(
                          "imgs/avatar_default.png",
                          width: 80,
                        ),
                ),
              ),
              Text(
                value.isLogin ? value.user!.login : "登录",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (!value.isLogin) Navigator.of(context).pushNamed("login");
        },
      );
    });
  }

  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget? child) {
        // var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text("主题"),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text("语言"),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
          ],
        );
      },
    );
  }
}
