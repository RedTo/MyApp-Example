import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('increment');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('starts at 0', () async {
      expect(await driver.getText(counterTextFinder), "0");
    });

    test('increments the counter', () async {
      //await Future.delayed(Duration(seconds: 5));
      for (int i = 1; i <= 5; i++) {
        await driver.tap(buttonFinder);
        expect(await driver.getText(counterTextFinder), i.toString());

        //await Future.delayed(Duration(seconds: 1));
      }

      //await Future.delayed(Duration(seconds: 5));
    });
  });
}
