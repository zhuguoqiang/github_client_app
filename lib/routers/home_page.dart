import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/models/user_model.dart';
import 'package:github_client_app/routers/my_drawer.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = "##loading##"; //表尾标记
  var _items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel? userModel = null;
    if (null == userModel) {
      return Center(
        child: ElevatedButton(
          child: Text("login"),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      return ListView();
    }
  }
}
