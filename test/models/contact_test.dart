// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/contact.dart';

final String sampleContact =
    '{"id":1,"firstname":"Susane","lastname":"Doe","eMail":"susane@doe.com","telephone":"015673948260"}';
final String sampleContacts = '{"contacts":[' + sampleContact + ']}';

void main() {
  Map<String, dynamic> _stringToJson(str) {
    return json.decode(str);
  }

  Contact _createSampleContact() {
    return Contact(
        id: 1,
        firstname: "Susane",
        lastname: "Doe",
        eMail: "susane@doe.com",
        telephone: "015673948260");
  }

  ContactFactory _createSampleContactFactory() {
    List<Contact> contacts = List<Contact>();
    contacts.add(_createSampleContact());
    return ContactFactory(contacts: contacts);
  }

  test('contactFactoryFromJson', () {
    expect(
        contactFactoryFromJson(sampleContacts).contacts.first.firstname,
        ContactFactory.fromJson(_stringToJson(sampleContacts))
            .contacts
            .first
            .firstname);
  });

  test('contactFactoryToJson', () {
    ContactFactory contactFactory = _createSampleContactFactory();
    expect(contactFactoryToJson(contactFactory), sampleContacts);
  });

  test('ContactFactory toJson', () {
    ContactFactory contactFactory = _createSampleContactFactory();
    expect(contactFactory.toJson(), _stringToJson(sampleContacts));
  });

  test('Contact from Json', () {
    Contact contact = Contact.fromJson(_stringToJson(sampleContact));
    expect(contact.id, 1);
    expect(contact.firstname, "Susane");
    expect(contact.lastname, "Doe");
    expect(contact.eMail, "susane@doe.com");
    expect(contact.telephone, "015673948260");
  });

  test('Contact to Json', () {
    Contact contact = _createSampleContact();
    var contactJson = contact.toJson();
    expect(_stringToJson(sampleContact), contactJson);
  });
  //testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //  // Build our app and trigger a frame.
  //  await tester.pumpWidget(MyApp());
  //
  //  // Verify that our counter starts at 0.
  //  expect(find.text('0'), findsOneWidget);
  //  expect(find.text('1'), findsNothing);
  //
  //  // Tap the '+' icon and trigger a frame.
  //  await tester.tap(find.byIcon(Icons.add));
  //  await tester.pump();
  //
  //  // Verify that our counter has incremented.
  //  expect(find.text('0'), findsNothing);
  //  expect(find.text('1'), findsOneWidget);
  //});
}
