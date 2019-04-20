import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/widgets/ThickSeparator.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';

import '../test_helper.dart';

void main() {
  test('ThickSeparator default values', () {
    ThickSeparator thickSeparator = new ThickSeparator();

    expect(thickSeparator.thickness, 0.1);
    expect(thickSeparator.indent, 0.0);
    expect(thickSeparator.color, null);
  });

  test('ThickSeparator custom values', () {
    ThickSeparator thickSeparator = new ThickSeparator(
      thickness: 5.7,
      indent: 0.375,
      color: Colors.deepOrange,
    );

    expect(thickSeparator.thickness, 5.7);
    expect(thickSeparator.indent, 0.375);
    expect(thickSeparator.color, Colors.deepOrange);
  });

  testWidgets('ThickSeparator build', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildPage(ThickSeparator()));

    expect(find.byType(ThickSeparator), findsOneWidget);
  });
}
