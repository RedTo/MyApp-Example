import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:progress_hud/progress_hud.dart';

import '../test_helper.dart';

void main() {
  testWidgets('myWidgetCreator genericSpinner', (WidgetTester tester) async {
    await tester.pumpWidget(
        TestHelper.buildPage(MyWidgetCreator.buildGenericSpinner()));

    expect(find.byType(ProgressHUD), findsOneWidget);
    expect(find.text('Refreshing...'), findsOneWidget);
  });

  testWidgets('myWidgetCreator genericSpinner custom text',
      (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildPage(
        MyWidgetCreator.buildGenericSpinner('Custom Text')));

    expect(find.byType(ProgressHUD), findsOneWidget);
    expect(find.text('Custom Text'), findsOneWidget);
    expect(find.text('Refreshing...'), findsNothing);
  });
}
