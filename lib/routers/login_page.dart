import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/models/git.dart';
import 'package:github_client_app/models/user_model.dart';
import 'package:github_client_app/models/user.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() {
    // TODO: implement createState
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin ?? "";
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var gm = GMLocallizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("登录")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: <Widget>[
            TextFormField(
              autofocus: _nameAutoFocus,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名",
                prefixIcon: Icon(Icons.person),
              ),
              // 校验
              validator: (v) {
                return v == null || v.trim().isNotEmpty ? null : "用户名是必填项！";
              },
            ),
            TextFormField(
              autofocus: !_nameAutoFocus,
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "密码",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      pwdShow = !pwdShow;
                    });
                  },
                ),
              ),
              obscureText: !pwdShow,
              // 校验
              validator: (v) {
                return v == null || v.trim().isNotEmpty ? null : "密码是必填项！";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55.0),
                child: ElevatedButton(
                  child: Text("登录"),
                  onPressed: _onLogin,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _onLogin() async {
    // 先验证字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      // showLoading(context);
      User? user;
      try {
        user = await Git(context).login(
            _unameController.text, "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");
        //
        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioError catch (e) {
        // 登录失败提示
        if (e.response?.statusCode == 401) {
          // showToast("用户名或密码错误！");
        } else {
          // showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
        // Navigator.of(context).pop();
      }

      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
