import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/pages/contactPage.dart';

import '../test_helper.dart';

void main() {
  testWidgets('ContactsPage default widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TestHelper.buildPage(ContactPage()));
    // Verify that our counter starts at 0.
    expect(find.text('Contacts'), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
