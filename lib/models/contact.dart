import 'dart:convert';

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

  factory ContactFactory.fromJson(Map<String, dynamic> json) => new ContactFactory(
    contacts: new List<Contact>.from(json[tableContact].map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    tableContact: new List<dynamic>.from(contacts.map((x) => x.toJson())),
  };
}

final String columnId = "id";
final String columnFirstname = "firstname";
final String columnLastname = "lastname";
final String columnEMail = "eMail";
final String columnTelephone = "telephone";
final String tableContact = "contacts";


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
    id: json[columnId],
    firstname: json[columnFirstname],
    lastname: json[columnLastname],
    eMail: json[columnEMail],
    telephone: json[columnTelephone],
  );

  Map<String, dynamic> toJson() => {
    columnId: id,
    columnFirstname: firstname,
    columnLastname: lastname,
    columnEMail: eMail,
    columnTelephone: telephone,
  };
}
