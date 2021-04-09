import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';

import 'base/contact.dart';

class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormState>();
  final nameHolder = TextEditingController();
  final numberHolder = TextEditingController();

  String _name;
  String _number;

  void addContact(Contact contact) {
    final contactsBox = Hive.box('contacts');
    contactsBox.add(contact);
  }

  clearTextInput() {
    nameHolder.clear();
    numberHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextFormField(
                controller: nameHolder,
                autocorrect: true,
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    hintText: 'Enter contact name'),
                onSaved: (value) => _name = value,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: TextFormField(
                controller: numberHolder,
                decoration: InputDecoration(
                  labelText: 'Number',
                  labelStyle: TextStyle(fontSize: 20.0),
                  hintText: 'Enter contact number'
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _number = value,
              ),
            ),
            RaisedButton(
              color: Colors.white38,
              child: Text(
                'Add New Contact',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _formKey.currentState.save();
                final newContact = Contact(_name, int.parse(_number));
                addContact(newContact);
                clearTextInput();
                Navigator.pop(context);
              },

            ),
          ],
        ),
      ),
    );
  }
}
