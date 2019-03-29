import 'package:flutter/material.dart';

//custom separator widget
class ThickSeparator extends StatelessWidget {
  //the user could specify how thick the separator should be,
  // which indent (from left) and which color the separator should have
  const ThickSeparator({
    Key key,
    this.thickness = 0.1,
    this.indent = 0.0,
    this.color,
  })  : assert(thickness >= 0.0),
        super(key: key);

  final double thickness;
  final double indent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thickness,
      child: Center(
        child: Container(
          //you could play around with the margin to also implement a indent from the right for example
          margin: EdgeInsetsDirectional.only(start: indent),
          height: thickness, //make the container as height as the sized box
          color: color,
        ),
      ),
    );
  }
}
