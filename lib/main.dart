import 'package:schedule_reminder/db/db_helper.dart';
import 'package:schedule_reminder/screens/add_contact.dart';
import 'package:schedule_reminder/screens/contact_info.dart';
import 'package:schedule_reminder/screens/edit_contact.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'screens/home.dart';
import 'package:schedule_reminder/screens/contacts.dart';
import 'package:schedule_reminder/screens/appointment.dart';
import 'package:schedule_reminder/screens/add_appointment.dart';
import 'package:get/get.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(appointmentScheduler());
}

class appointmentScheduler extends StatelessWidget {
  const appointmentScheduler({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AppointmentScheduler',
      initialRoute: Home.id,
      routes: {
        Home.id: (context)=> Home(),
        Contacts.id: (context)=> Contacts(),
        Appointments.id: (context)=> Appointments(),
        AddAppointment.id: (context)=>AddAppointment(),
        AddContact.id: (context)=> AddContact(),
        EditContact.id: (context)=> EditContact(contactKey:'Key',),
        ContactInfo.id: (context)=> ContactInfo(contactKey: 'Key',),


      },
    );
  }
}