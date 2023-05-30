import 'package:flutter/material.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() {
    // TODO: implement createState
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("name"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
