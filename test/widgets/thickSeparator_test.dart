import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/widgets/ThickSeparator.dart';

void main() {
  testWidgets('ThickSeparator default values', (WidgetTester tester) async {
    ThickSeparator thickSeparator = new ThickSeparator();

    expect(thickSeparator.thickness, 0.1);
    expect(thickSeparator.indent, 0.0);
    expect(thickSeparator.color, null);
  });

  testWidgets('ThickSeparator custom values', (WidgetTester tester) async {
    ThickSeparator thickSeparator = new ThickSeparator(
      thickness: 5.7,
      indent: 0.375,
      color: Colors.deepOrange,
    );

    expect(thickSeparator.thickness, 5.7);
    expect(thickSeparator.indent, 0.375);
    expect(thickSeparator.color, Colors.deepOrange);
  });
}
