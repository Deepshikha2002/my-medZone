import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/appointment.dart';
import '../screens/contacts.dart';
import '../screens/reminder.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Set Reminders'),
            onTap: () => {Get.to(AddReminder())},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Add Documents'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Add Contacts'),
            onTap: () => {Get.to(Contacts())},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Save Appointment Reminders'),
            onTap: () => {Get.to(Appointments())},
          ),
        ],
      ),
    );
  }
}