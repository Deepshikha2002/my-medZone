import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_reminder/screens/reminder.dart';
class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({ Key? key, required this.label,required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Center(
        child: Container(
          width:200,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 6, 89, 92),
          ),
          child: Center(
            child: Text(
            label,
             style: TextStyle(
             color: Colors.white,
         ),
            ),
          ),
        ),
      )
    );
  }
}
