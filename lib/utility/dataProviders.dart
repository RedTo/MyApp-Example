import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/model/contact.dart';
import 'package:myapp/utility/api_loader.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactProvider {
  final String _contactsURL =
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
      var jsonString = await API_Loader.getJson(_contactsURL);
      var onlineContacts = contactFactoryFromJson(jsonString).contacts;

      onlineContacts.forEach((c) => insert(c));
      contacts = onlineContacts;
    }
    Navigator.pop(context);
    return contacts;
  }

  Future updateContacts(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyWidgetCreator.buildGenericSpinner();
        });

    var jsonString = await API_Loader.getJson(_contactsURL);
    var onlineContacts = contactFactoryFromJson(jsonString).contacts;
    onlineContacts.forEach((c) => updateOrCreate(c));

    //TODO check why two reads are required
    var con = await getContacts();
    print("con " + con.length.toString());

    Navigator.pop(context);
    return null;
  }

  void updateOrCreate(Contact contact) async {
    var result = await update(contact);
    if (result == 0) {
      await insert(contact);
    }
  }

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contacts.db');
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableNameContact ( 
  $columnContactId integer primary key, 
  $columnContactFirstname text not null,
  $columnContactLastname text not null,
  $columnContactEMail text not null,
  $columnContactTelephone text not null)
''');
    });
  }

  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert(tableNameContact, contact.toJson());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    List<Map> maps = await db.query(tableNameContact,
        columns: [
          columnContactId,
          columnContactFirstname,
          columnContactLastname,
          columnContactEMail,
          columnContactTelephone
        ],
        where: '$columnContactId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = new List<Contact>();
    var entries = await db.query(tableNameContact);
    if (entries.length > 0) {
      entries.forEach((e) => contacts.add(Contact.fromJson(e)));
    }
    return contacts;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableNameContact,
        where: '$columnContactId = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    return await db.update(tableNameContact, contact.toJson(),
        where: '$columnContactId = ?', whereArgs: [contact.id]);
  }

  Future close() async => db.close();
}
