import 'package:flutter/material.dart';
import 'package:myapp/models/contact.dart';
import 'package:myapp/util/dataProviders.dart';
import 'package:myapp/widgets/ThickSeparator.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:after_layout/after_layout.dart';

class ContactPage extends StatefulWidget {
  ContactPage({this.title = "Home"});

  final String title;

  @override
  State<StatefulWidget> createState() => _ContactState(title);
}

class _ContactState extends State<ContactPage>
    with AfterLayoutMixin<ContactPage> {
  _ContactState(this.title) {
    contactProvider = ContactProvider();
  }

  final String title;
  List<Contact> _contacts = new List<Contact>();
  ContactProvider contactProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.refresh),
            onPressed: () => _getData(true),
          )
        ],
      ),
      drawer: MyWidgetCreator.getDrawer(context),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            _buildItem(context, _contacts[index]),
        itemCount: _contacts.length,
        separatorBuilder: (BuildContext context, int index) =>
            ThickSeparator(thickness: 15.0, color: Colors.red, indent: 50.0),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Contact contact) {
    return Dismissible(
      key: Key(contact.id.toString()),
      onDismissed: (direction) {
        print(direction.toString());
        contactProvider.delete(contact.id);

        setState(() {
          _contacts.remove(contact);
        });

        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(contact.firstname + " removed")));
      },
      background: Container(color: Colors.red),
      child: ListTile(
        title: Text(contact.firstname + " " + contact.lastname),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _getData();
  }

  Future<void> _getData([bool update = false]) async {
    await contactProvider.open();
    List<Contact> contacts = new List<Contact>();
    if (update) {
      await contactProvider.updateContacts(context);
    }
    contacts = await contactProvider.loadContacts(context);

    setState(() {
      _contacts = contacts;
    });
  }
}
