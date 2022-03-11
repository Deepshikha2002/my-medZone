import 'package:flutter/material.dart';
class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget; 
  const InputField({ Key? key, required this.title, required this.hint, 
  this.controller, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          Container(
            margin: EdgeInsets.only(top:8.0),
            padding: EdgeInsets.only(left:14),
           height: 52,
           decoration: BoxDecoration(
             border: Border.all(
               color: Colors.grey,
               width: 1.0,
             ),
             borderRadius: BorderRadius.circular(12),
           ),
           child: Row(children: [
             Expanded(
               child:TextFormField(
                 readOnly: widget==null?false:true,
                 controller: controller,
                 style: TextStyle(
                   color: Colors.grey[850],
                 ),
                 decoration: InputDecoration(
                   hintText: hint,
                   focusedBorder: UnderlineInputBorder(
                     borderSide: (BorderSide(
                       color: Colors.transparent,
                       width: 0,
                     )),
                   )
                 ),
               )
             ),
                widget==null?Container():Container(child:widget),
           ],)
          ),
        ],
      )
      
    );
  }
}