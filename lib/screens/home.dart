import 'package:flutter/material.dart';
import 'package:schedule_reminder/screens/contacts.dart';
import 'package:schedule_reminder/screens/appointment.dart';

class Home extends StatelessWidget{
  static String id= 'Home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            GestureDetector(
                onTap:() {
                  Navigator.pushNamed(context, Contacts.id);
                },
                child: Container(
                    padding: EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),

                    ),

                    child: Text(
                        "SAVE YOUR CONTACTS"
                    )
                )
            ),
            const SizedBox(
              height: 50.0,
            ),
            GestureDetector(
                onTap:() {
                  Navigator.pushNamed(context, Appointments.id);
                },
                child:   Container(
                    padding: EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24),

                    ),

                    child: Text(
                        "SAVE YOUR DOCTOR'S APPOINTMENT"
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
