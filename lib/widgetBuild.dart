import 'package:flutter/material.dart';
import 'package:myapp/home.dart';
import 'package:myapp/main.dart';

class MyWidgetCreator {
  static Widget getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.verified_user),
              backgroundColor: Colors.grey,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Home("Home")));
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MyHomePage(title: "Home")));
            },
            leading: Icon(Icons.home),
            title: Text("Counter"),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
