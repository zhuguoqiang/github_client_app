import 'package:flutter/material.dart';
import 'package:github_client_app/models/git.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/models/user_model.dart';
import 'package:github_client_app/routers/my_drawer.dart';
import 'package:github_client_app/widgets/repo_item.dart';
import 'package:provider/provider.dart';

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
    UserModel? userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: ElevatedButton(
          child: Text("login"),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          // 如果到了表尾
          if (_items[index].name == loadingTag) {
            // 不足100
            if (hasMore) {
              // 获取数据
              _retrieveData();
              // loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              );
            } else {
              // 已加载100，不在获取
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          } else {}
          return RepoItem(_items[index]);
        },
        separatorBuilder: (context, index) => Divider(
          height: .0,
        ),
      );
    }
  }

  void _retrieveData() async {
    var data = await Git(context).getRepos(
      queryParameters: {'page': page, 'page_size': 20},
    );
    //如果返回的数据小于指定的条数，则表示没有更多数据，反之则否
    hasMore = data.length > 0 && data.length % 20 == 0;
    // 把请求的数据添加到items中
    if (this.mounted) {
      setState(() {
        _items.insertAll(_items.length - 1, data);
        page++;
      });
    }
  }
}
