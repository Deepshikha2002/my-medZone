import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:schedule_reminder/screens/add_contact.dart';

import 'edit_contact.dart';


class Contacts extends StatefulWidget {
  static String id= 'Contacts';

  @override
  _ContactsState createState() => new _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Query? _ref;
  DatabaseReference reference =
  FirebaseDatabase.instance.ref().child('Contacts');
  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .ref()
        .child('Contacts')
        .orderByChild('name');
  }

  Widget _buildContactItem({required Map contact,}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      height: 90,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
             _showContactInfo(contact: contact);
            },
            child: Row(
              children: [
                Icon(Icons.person,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  contact['name'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(Icons.phone_iphone,
                color: Colors.black,
                size: 13,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['phone Number'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditContact(
                            contactKey: contact['key']!,
                          )));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showDeleteDialog(contact: contact);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                      size: 20,
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showContactInfo({required Map contact }){
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.greenAccent[100],
            child: Row(
              children: [
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      contact['name'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Phone No:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                        contact['phoneNumber'],
                        style: TextStyle(
                          fontSize: 12,
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Telephone No:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                        contact['teleNumber'],
                        style: TextStyle(
                          fontSize: 12,
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Email Address:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                        contact['email'],
                        style: TextStyle(
                          fontSize: 12,
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Address:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                        contact['address'],
                        style: TextStyle(
                          fontSize: 12,
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Specialization:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                        contact['specialization'],
                        style: TextStyle(
                          fontSize: 12,
                        )
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

  _showDeleteDialog({required Map contact }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['name']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    reference
                        .child(contact['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Contact List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.greenAccent[100],
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(query: _ref! , itemBuilder: (BuildContext context,
            DataSnapshot snapshot,Animation<double>animation,int index){
          Map contact = snapshot.value as Map;
          contact['key'] = snapshot.key;
          return _buildContactItem(contact: contact);

        },),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, AddContact.id);
      },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff007e33),
        foregroundColor: Colors.white,
      ),

    );
  }
}
