import 'package:flutter/material.dart';
import 'package:myapp/models/contact.dart';
import 'package:myapp/util/apiLoader.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Contact Provider will help us to fetch data from database or api
class ContactProvider {
  //url where we get the contact data from
  static const String url =
      'http://my-json-server.typicode.com/redto/fake_json_server/db';

  Database db;

  //show a progress indicator, fetch data, close indicator and return
  Future<List<Contact>> loadContacts(BuildContext context) async {
    //this will open up a dialog with a generic spinner (progress indicator)
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyWidgetCreator.buildGenericSpinner();
        });

    //fetch data from local database
    var contacts = await getContacts();
    //if there is no data available, try to fetch it from the url
    if (contacts.length == 0) {
      var jsonString = await APILoader.getJson(url); //get data from api
      var onlineContacts = contactFactoryFromJson(jsonString).contacts;
      //foreach contact (we have got from the api) insert into local database
      onlineContacts.forEach((contact) => insert(contact));
      contacts = onlineContacts;
    }

    Navigator.pop(context); //close the progress indicator
    return contacts; //return the fetched contacts
  }

  //update local database by online storage
  Future<void> updateContacts(BuildContext context) async {
    //this will open up a dialog with a generic spinner (progress indicator)
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyWidgetCreator.buildGenericSpinner();
        });

    //get the data from the online reference (api)
    var jsonString = await APILoader.getJson(url);
    //create list of contacts via the contact factory
    var onlineContacts = contactFactoryFromJson(jsonString).contacts;
    //foreach contact call update or create
    onlineContacts.forEach((contact) => updateOrCreate(contact));

    //close the progress indicator
    Navigator.pop(context);
  }

  //update contact if available or create it
  Future<void> updateOrCreate(Contact contact) async {
    //try to update contact
    var result = await update(contact);
    if (result == 0) {
      //update will return 1 for true, 0 for false
      await insert(contact); //insert if update failed
    }
  }

  //get all contacts from the database
  Future<List<Contact>> getContacts() async {
    //create a empty list
    List<Contact> contacts = new List<Contact>();
    //do a "SELECT * FROM $tableContact" -> get all contacts
    var entries = await db.query(Contact.tableContact);

    //foreach entry create a contact and add it to the list
    entries.forEach((e) => contacts.add(Contact.fromJson(e)));
    //return the list of contacts (list could never be null!)
    return contacts;
  }

  //open a new database connection
  Future open() async {
    //specify a path where the database should be stored
    var databasePath =
        await getDatabasesPath(); //system specific! (automatically)
    var path = join(databasePath, 'contacts.db');
    //try to open the database, if it does not exist create it
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table ${Contact.tableContact} ( 
  ${Contact.columnId} integer primary key, 
  ${Contact.columnFirstname} text not null,
  ${Contact.columnLastname} text not null,
  ${Contact.columnEMail} text not null,
  ${Contact.columnTelephone} text not null)
'''); //just as a note $variableName is the same like "String " + variableName.toString() + " other String"
    });
  }

  //insert a contact to the database
  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert(Contact.tableContact, contact.toJson());
    return contact;
  }

  //get a contact by the contact id
  Future<Contact> getContact(int id) async {
    List<Map> maps = await db.query(Contact.tableContact,
        //specify which columns should be loaded
        columns: [
          Contact.columnId,
          Contact.columnFirstname,
          Contact.columnLastname,
          Contact.columnEMail,
          Contact.columnTelephone
        ],
        //specify the where clause of your sql query ? is the argument
        where: '${Contact.columnId} = ?',
        whereArgs: [id]); //replace ? with id (basically)
    if (maps.length > 0) {
      return Contact.fromJson(maps.first); //if contact exist create and return
    }
    return null; //if no contact could be found, return null
  }

  //delete a contact from the local database by its id
  Future<int> delete(int id) async {
    return await db
        .delete(Contact.tableContact, where: '${Contact.columnId} = ?', whereArgs: [id]);
  }

  //update a contact based on its id
  Future<int> update(Contact contact) async {
    return await db.update(Contact.tableContact, contact.toJson(),
        where: '${Contact.columnId} = ?', whereArgs: [contact.id]);
  }

  //close the database if no opened connection is needed
  Future close() async => db.close();
}
