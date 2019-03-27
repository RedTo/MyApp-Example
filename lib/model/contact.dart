//This class represents the contact structure found on http://my-json-server.typicode.com/redto/fake_json_server/db
// and was generated with https://app.quicktype.io/ and change to store data easily into sqflite

import 'dart:convert';

final String tableNameContact = "contacts";
final String columnContactId = "id";
final String columnContactFirstname = "firstname";
final String columnContactLastname = "lastname";
final String columnContactEMail = "eMail";
final String columnContactTelephone = "telephone";

ContactFactory contactFactoryFromJson(String str) {
  final jsonData = json.decode(str);
  return ContactFactory.fromJson(jsonData);
}

String contactFactoryToJson(ContactFactory data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ContactFactory {
  List<Contact> contacts;

  ContactFactory({
    this.contacts,
  });

  factory ContactFactory.fromJson(Map<String, dynamic> json) =>
      new ContactFactory(
        contacts: new List<Contact>.from(
            json["contacts"].map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contacts": new List<dynamic>.from(contacts.map((x) => x.toJson())),
      };
}

class Contact {
  int id;
  String firstname;
  String lastname;
  String eMail;
  String telephone;

  Contact({
    this.id,
    this.firstname,
    this.lastname,
    this.eMail,
    this.telephone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => new Contact(
        id: json[columnContactId],
        firstname: json[columnContactFirstname],
        lastname: json[columnContactLastname],
        eMail: json[columnContactEMail],
        telephone: json[columnContactTelephone],
      );

  Map<String, dynamic> toJson() => {
        columnContactId: id,
        columnContactFirstname: firstname,
        columnContactLastname: lastname,
        columnContactEMail: eMail,
        columnContactTelephone: telephone,
      };
}
