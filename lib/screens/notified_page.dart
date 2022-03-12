import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/appoint.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  final Appointment? appointment;
  const NotifiedPage({Key? key, required this.label, this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.grey,
          ),
          title: Text(this.label.toString().split("|")[0],
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.greenAccent[100],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            height: 400,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[400]
            ),
            child: Text(
                    "You have an appointment with Dr. ${this.label.toString().split("|")[1]}"
                    "Don't forget to grab your medical reports. medZone",
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    ),

                  ),
                ),
            ),
    );
  }
}
