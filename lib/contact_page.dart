import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'base/contact.dart';
import 'add_new_contact.dart';

class ContactPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Mobile Contacts',
            style: TextStyle(fontSize: 22),
          )),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildListView()),

        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewContactForm(),
              ),
            );
          },
      ),
    );
  }

  Widget _buildListView() {
    return WatchBoxBuilder(
      box: Hive.box('contacts'),
      builder: (context, contactsBox) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = contactsBox.getAt(index) as Contact;

            return ListTile(
              title: Text(
                contact.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '+142 ${contact.number}'.toString(),
                style: TextStyle(fontSize: 17),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      contactsBox.deleteAt(index);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
