import 'package:flutter/material.dart';
import 'package:myapp/pages/animationPage.dart';
import 'package:myapp/pages/contactPage.dart';
import 'package:myapp/pages/counterPage.dart';
import 'package:progress_hud/progress_hud.dart';

//class to create custom widgets (reusability)
class MyWidgetCreator {
  //create a menu drawer
  static Widget getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            //special drawer header
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.verified_user, color: Colors.white),
              backgroundColor: Colors.blueAccent,
            ),
            accountEmail: Text("mobile@development.app"),
            accountName: Text("Mobile App Development"),
          ),
          ListTile(
            //menu item
            onTap: () => _switchPage(context, ContactPage()),
            leading: Icon(Icons.home),
            title: Text("Contacts"),
          ),
          ListTile(
            //menu item 2
            onTap: () => _switchPage(context, CounterPage()),
            leading: Icon(Icons.plus_one),
            title: Text("Counter"),
          ),
          ListTile(
            //menu item 2
            onTap: () => _switchPage(context, AnimationPage()),
            leading: Icon(Icons.wb_incandescent),
            title: Text("Animation"),
          ),
        ],
      ),
    );
  }

  //method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pop(
        context); //remove a page from the widget stack (close navigation)
    Navigator.pushReplacement(
        //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  //build a generic spinner (progress indicator)
  static Widget buildGenericSpinner([String text = "Refreshing..."]) {
    return ProgressHUD(
      backgroundColor: Colors.black26,
      //the color around the progress hud
      color: Colors.white,
      //the font color inside the progress hud
      containerColor: Colors.blue,
      //the color of the "popup"
      borderRadius: 5.0,
      text: text,
    );
  }
}
