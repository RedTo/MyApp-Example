import 'package:flutter/material.dart';
import 'package:myapp/pages/contactPage.dart';

//entry point of the application (create a myapp)
void main() => runApp(MyApp());

//basis of the app (first class)
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //wrapper for all the pages/views etc
      title: 'Flutter Demo',
      theme: ThemeData(
        //specifies a theme (look/design of the app)
        primarySwatch: Colors.blue,
      ),
      home: ContactPage(), //starting point, first page
    );
  }
}
