import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

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
                color: Colors.black
            ),
          ),
        ),
        body: Center(
          child: Container(
            height: 400,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[400]
            ),
            child: Text(this.label.toString().split("|")[1],
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,

              ),

            ),
          ),
        )
    );
  }
}
