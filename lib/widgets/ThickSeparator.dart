import 'package:flutter/material.dart';

class ThickSeparator extends StatelessWidget {
  const ThickSeparator({
    Key key,
    this.thickness = 0.1,
    this.height = 16.0,
    this.indent = 0.0,
    this.color,
  })  : assert(height >= 0.0),
        assert(thickness >= 0.0),
        super(key: key);

  final double thickness;
  final double height;
  final double indent;
  final Color color;

  static BorderSide createBorderSide(BuildContext context,
      {Color color, double width = 0.0}) {
    assert(width != null);
    return BorderSide(
      color: color ?? Theme.of(context).dividerColor,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: indent),
          height: thickness,
          color: color,
        ),
      ),
    );
  }
}
