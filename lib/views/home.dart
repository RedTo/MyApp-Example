import 'package:flutter/material.dart';
import 'package:myapp/widgets/ThickSeparator.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';

class Home extends StatelessWidget {
  Home({this.title = "Home"});

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
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) => ThickSeparator(
              thickness: 1.0,
              color: Colors.grey
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
