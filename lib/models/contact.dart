import 'dart:convert';

//Create a contact factory object out of a json string
ContactFactory contactFactoryFromJson(String str) {
  final jsonData = json.decode(str);
  return ContactFactory.fromJson(jsonData);
}

//create a json string out of a contact factory object
String contactFactoryToJson(ContactFactory data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

//Use the contact factory to create a list of contacts out of a valid json string
class ContactFactory {
  List<Contact> contacts;

  ContactFactory({
    this.contacts,
  });

  factory ContactFactory.fromJson(Map<String, dynamic> json) =>
      new ContactFactory(
        contacts: new List<Contact>.from(
            json[Contact.tableContact].map((x) => Contact.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    Contact.tableContact: new List<dynamic>.from(contacts.map((x) => x.toJson())),
      };
}

//final strings which are used to identify the corresponding values inside a json
// and also the corresponding database columns (see contact provider).


//Contact class represents a contact with all the attributes given.
class Contact {
  static const String columnId = "id";
  static const String columnFirstname = "firstname";
  static const String columnLastname = "lastname";
  static const String columnEMail = "eMail";
  static const String columnTelephone = "telephone";
  static const String tableContact = "contacts";

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

  //factory method to create a contact out of a *parsed* json string
  factory Contact.fromJson(Map<String, dynamic> json) => new Contact(
        id: json[columnId],
        firstname: json[columnFirstname],
        lastname: json[columnLastname],
        eMail: json[columnEMail],
        telephone: json[columnTelephone],
      );

  //method to create a json map out of current contact object
  Map<String, dynamic> toJson() => {
        columnId: id,
        columnFirstname: firstname,
        columnLastname: lastname,
        columnEMail: eMail,
        columnTelephone: telephone,
      };
}
