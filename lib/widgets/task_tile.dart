import 'package:flutter/material.dart';
import 'package:schedule_reminder/model/reminderformat.dart';

class TaskTile extends StatelessWidget {
  final Reminder? rem;
  TaskTile(this.rem);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.teal[200],
        ),
        child: Row(children: [
          Expanded(
            child: Row(
              children:[ Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    rem?.title??"",
                  style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
      
                 SizedBox(
                  height: 12,
                ),
                
                Text(
                  rem?.dosage??"",
                  style:TextStyle(fontSize: 15, color: Colors.black),
                  ),
                   SizedBox(height: 12),

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
                      "${rem!.startTime}",
                      style:
                        TextStyle(fontSize: 13, color: Colors.black),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 100,),
            Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: Image(
                              image: AssetImage('assets/image${rem!.id}.jpeg'),
                              height: 120,
                              width: 120,
                            )
                          ),
                        ),
                      ),
                  ),
              ]
            )


          ),
         
        ]),
      ),
    );
  }
}