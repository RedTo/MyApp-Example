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

  test('final Strings should stay the same', () {
    expect(columnId, "id");
    expect(columnFirstname, "firstname");
    expect(columnLastname, "lastname");
    expect(columnEMail, "eMail");
    expect(columnTelephone, "telephone");
    expect(tableContact, "contacts");
  });
}
