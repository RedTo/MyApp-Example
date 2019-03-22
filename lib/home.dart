import 'package:flutter/material.dart';
import 'package:myapp/widgetBuild.dart';

class Home extends StatelessWidget {
  Home(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MyWidgetCreator.getDrawer(context),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            _buildItem(context, index),
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 50.0,
              color: Colors.red,
            ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ListTile(
      title: Text("Text # $index"),
    );
  }
}
