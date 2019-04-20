import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/pages/animationPage.dart';
import 'package:myapp/widgets/animatedLogo.dart';

import '../test_helper.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TestHelper.buildPage(AnimationPage()));

    // Verify that our counter starts at 0.
    expect(find.text('Hello developers!'), findsOneWidget);
    expect(find.byType(AnimatedLogo), findsOneWidget);
  });
}
