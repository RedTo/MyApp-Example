import 'package:flutter/material.dart';
import 'package:myapp/models/contact.dart';
import 'package:myapp/util/apiLoader.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactProvider {
  final String url =
      'http://my-json-server.typicode.com/redto/fake_json_server/db';

  Database db;

  Future<List<Contact>> loadContacts(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyWidgetCreator.buildGenericSpinner();
        });

    var contacts = await getContacts();
    if (contacts.length == 0) {
      var jsonString = await APILoader.getJson(url);
      var onlineContacts = contactFactoryFromJson(jsonString).contacts;
      onlineContacts.forEach((contact) => insert(contact));
      contacts = onlineContacts;
    }

    Navigator.pop(context);
    return contacts;
  }

  Future<void> updateContacts(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyWidgetCreator.buildGenericSpinner();
        });

    var jsonString = await APILoader.getJson(url);
    var onlineContacts = contactFactoryFromJson(jsonString).contacts;
    onlineContacts.forEach((contact) => updateOrCreate(contact));

    Navigator.pop(context);
  }

  Future<void> updateOrCreate(Contact contact) async {
    var result = await update(contact);
    if(result == 0){
      await insert(contact);
    }
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = new List<Contact>();
    var entries = await db.query(tableContact);

    entries.forEach((e) {
      contacts.add(Contact.fromJson(e));
    });
    return contacts;
  }

  Future open() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'contacts.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableContact ( 
  $columnId integer primary key, 
  $columnFirstname text not null,
  $columnLastname text not null,
  $columnEMail text not null,
  $columnTelephone text not null)
''');
    });
  }

  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert(tableContact, contact.toJson());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    List<Map> maps = await db.query(tableContact,
        columns: [
          columnId,
          columnFirstname,
          columnLastname,
          columnEMail,
          columnTelephone
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromJson(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableContact, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    return await db.update(tableContact, contact.toJson(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future close() async => db.close();
}
