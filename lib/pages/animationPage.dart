import 'package:flutter/material.dart';
import 'package:myapp/widgets/animatedLogo.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';

class AnimationPage extends StatefulWidget {
  _AnimationPageState createState() => new _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  _AnimationPageState();

  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
        backgroundColor: Colors.red,
      ),
      drawer: MyWidgetCreator.getDrawer(context),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new AnimatedLogo(animation: animation),
          new Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          ),
          new Text(
            "Hello developers!",
            style: new TextStyle(
                fontSize: 30.0, color: Colors.red, letterSpacing: 2.0),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
          ),
        ],
      ),
    );
  }
}
