import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/appointment.dart';
import '../screens/contacts.dart';
import '../screens/pdfsaver.dart';
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
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.cyanAccent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/homepg.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.alarm_on_rounded),
            title: Text('Set Reminders'),
            onTap: () => {Get.to(()=>AddReminder())},
          ),
          ListTile(
            leading: Icon(Icons.folder_copy_sharp),
            title: Text('Add Documents'),
            onTap: () => {Get.to(() =>firstpage())},
          ),
          ListTile(
            leading: Icon(Icons.account_balance_sharp),
            title: Text('Add Contacts'),
            onTap: () => {Get.to(()=>Contacts())},
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_sharp),
            title: Text('Save Appointment Reminders'),
            onTap: () => {Get.to(()=>Appointments())},
          ),
        ],
      ),
    );
  }
}