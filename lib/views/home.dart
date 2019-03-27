import 'package:flutter/material.dart';
import 'package:myapp/model/contact.dart';
import 'package:myapp/utility/dataProviders.dart';
import 'package:myapp/views/contact_details.dart';
import 'package:myapp/widgets/ThickSeparator.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:after_layout/after_layout.dart';

class Home extends StatefulWidget {
  Home({this.title = "Home"});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomeState(title);
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  _HomeState(this.title) {
    contactProvider = ContactProvider();
  }

  ContactProvider contactProvider;

  final String title;
  var _contacts = new List<Contact>();

  @override
  void afterFirstLayout(BuildContext context) {
    _getData();
  }

  _getData([bool update = false]) async {
    await contactProvider.open();
    List<Contact> contacts;
    if (update) {
      await contactProvider.updateContacts(context);
    }
    contacts = await contactProvider.loadContacts(context);
    print(contacts.length);

    setState(() {
      _contacts = contacts;
    });
  }

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
            ThickSeparator(thickness: 1.0, color: Colors.grey),
      ),
    );
  }

  Widget _buildItem(BuildContext context, Contact contact) {
    return Dismissible(
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify Widgets.
      key: Key(contact.id.toString()),
      // We also need to provide a function that tells our app
      // what to do after an item has been swiped away.
      onDismissed: (direction) {
        // Remove the item from our data source.
        contactProvider.delete(contact.id);
        setState(() {
          _contacts.remove(contact);
        });

        // Then show a snackbar!
        Scaffold.of(context).showSnackBar(SnackBar(
            content:
                Text(contact.firstname + " " + contact.lastname + " removed")));
      },
      // Show a red background as the item is swiped away
      background: Container(color: Colors.red),
      child: ListTile(
        title: Text(contact.firstname + " " + contact.lastname),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContactDetails(contact))),
      ),
    );
  }
}
