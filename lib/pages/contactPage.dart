import 'package:flutter/material.dart';
import 'package:myapp/models/contact.dart';
import 'package:myapp/util/dataProviders.dart';
import 'package:myapp/widgets/ThickSeparator.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';
import 'package:after_layout/after_layout.dart';

//ContactPage to create a list of locally stored contacts
class ContactPage extends StatefulWidget {
  //constructor with optional parameter but default value (so title will never be null!)
  ContactPage({this.title = "Contacts"});

  final String title;

  @override
  State<StatefulWidget> createState() => _ContactState(title);
}

//the corresponding state to for the contact page
class _ContactState extends State<ContactPage>
    with AfterLayoutMixin<ContactPage> {
  //add the possibility to do something after first layout build

  //constructor of the state, create a new contact provider if state is build
  _ContactState(this.title) {
    _contactProvider = ContactProvider();
  }

  final String title;
  List<Contact> _contacts = new List<Contact>();
  ContactProvider _contactProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        //actions are usually in the upper right corner (right side in the appbar)
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.refresh, color: Colors.white),
            onPressed: () => _getData(true),
          )
        ],
      ),
      drawer: MyWidgetCreator.getDrawer(context),
      //there a different types of those listview builders ListView.builder and ListView.custom
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            _buildItem(context, _contacts[index]),
        //specifies how a list item is build
        itemCount: _contacts.length,
        //specifies how many times the build function is called
        separatorBuilder: (BuildContext context,
                int index) => //specifies which widget is separating two list items
            ThickSeparator(thickness: 1.0, color: Colors.grey, indent: 15.0),
      ),
    );
  }

  //@override
  //Widget build(BuildContext context) {
  //  return new MaterialApp(
  //    title: 'Flutter Demo',
  //    theme: new ThemeData(
  //      primarySwatch: Colors.blue,
  //    ),
  //    home: new FutureBuilder(future: new Future(() async {
  //      var token = await AccessToken.getInstance().getOrCreate();
  //      var user = await fetchUser(token);
  //      return await fetchEvents(user, token);
  //    }), builder: (BuildContext context, AsyncSnapshot<EventList> feedState) {
  //      if (feedState.error != null) {
  //        // TODO: error handling
  //      }
  //      if (feedState.data == null) {
  //        return new Center(child: new CircularProgressIndicator());
  //      }
  //      return new MyHomePage(
  //          title: 'Flutter Demo Home Page', events: feedState.data);
  //    }),
  //    // This trailing comma makes auto-formatting nicer for build methods.
  //  );

  //method to build a list item
  Widget _buildItem(BuildContext context, Contact contact) {
    return Dismissible(
      //allows us to swipe a list element to the left or the right
      key: Key(contact.id.toString()), //identifier for a widget
      onDismissed: (direction) {
        //you can check which swiping direction was used through direction

        //delete the swiped contact from the database
        _contactProvider.delete(contact.id);

        setState(() {
          //call set state to refresh the list and trigger a rebuild
          _contacts
              .remove(contact); //remove the deleted contact from the "view"
        });

        //show a little notification to the user
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(contact.firstname + " removed")));
      },
      background: Container(color: Colors.red),
      child: ListTile(
        //the normal list tile / item
        title: Text(contact.firstname + " " + contact.lastname),
      ),
    );
  }

  //use this method to do something after the screen was build the first time
  @override
  void afterFirstLayout(BuildContext context) {
    _getData();

    _contactProvider.open().then((value) {
      print("opend");
    }, onError: (error) {
      print(error.toString());
    });
  }

  //get data from the contact (data) provider
  Future<void> _getData([bool update = false]) async {
    await _contactProvider.open(); //open the database
    List<Contact> contacts = new List<Contact>(); //create a empty list
    if (update) {
      //if update is marked
      await _contactProvider.updateContacts(
          context); //fetch data from the api and update database
    }
    contacts = await _contactProvider
        .loadContacts(context); //load contacts from the database

    //call set state to change the displayed contacts
    setState(() {
      _contacts = contacts;
    });
  }
}
