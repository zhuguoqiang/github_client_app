import 'package:flutter/material.dart';
import 'package:github_client_app/models/locale_model.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var color = Theme.of(context).primaryColor;
    var localModel = Provider.of<LocaleModel>(context);

    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localModel.locale == value ? color : null),
        ),
        trailing: localModel.locale == value
            ? Icon(
                Icons.done,
                color: color,
              )
            : null,
        onTap: () {
          localModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("语言"),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US")
        ],
      ),
    );
  }
}
