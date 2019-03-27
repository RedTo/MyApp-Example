import 'package:flutter/material.dart';
import 'package:myapp/views/counter.dart';
import 'package:myapp/views/home.dart';
import 'package:progress_hud/progress_hud.dart';

class MyWidgetCreator {
  static Widget getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.verified_user, color: Colors.white),
              backgroundColor: Colors.blueAccent,
            ),
            accountEmail: Text("mobile@development.app"),
            accountName: Text("Mobile App Development"),
          ),
          ListTile(
            onTap: () => _switchPage(context, Home()),
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () => _switchPage(context, Counter()),
            leading: Icon(Icons.plus_one),
            title: Text("Counter"),
          ),
        ],
      ),
    );
  }

  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  static Widget buildGenericSpinner([String text = 'Refreshing']) {
    return new ProgressHUD(
        backgroundColor: Colors.black12,
        color: Colors.white,
        containerColor: Colors.blue,
        borderRadius: 5.0,
        text: text);
  }
}
