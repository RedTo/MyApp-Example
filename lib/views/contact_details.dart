import 'package:flutter/material.dart';
import 'package:myapp/model/contact.dart';
import 'package:myapp/widgets/myWidgetCreator.dart';

class ContactDetails extends StatelessWidget {
  ContactDetails(this.contact);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.firstname + " " + contact.lastname),
      ),
      body: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Telephone:"),
                Text(contact.telephone)
              ],
            ),
            Row(
              children: <Widget>[
                Text("E-Mail:"),
                Text(contact.eMail)
              ],
            )
          ],
        ),
      ),
    );
  }
}
