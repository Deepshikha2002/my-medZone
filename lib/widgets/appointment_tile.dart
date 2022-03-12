import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/appoint.dart';


class AppointmentTile extends StatelessWidget {
  final Appointment? appointment;

  AppointmentTile(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.greenAccent[100],
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment?.name ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${appointment!.startTime} - ${appointment!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "appointment with Dr. ${appointment?.docName ?? " "}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "on: ${appointment!.date} ",
                  style: GoogleFonts.lato(
                    textStyle:
                    TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[400]!.withOpacity(0.7),
          ),

        ]),
      ),
    );
  }

}

