import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_reminder/controllers/reminder_controller.dart';
import 'package:schedule_reminder/model/reminderformat.dart';
import 'package:schedule_reminder/widgets/button.dart';
import 'package:schedule_reminder/widgets/input_field1.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
class AddReminder extends StatefulWidget {
  const AddReminder({ Key? key }) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
   final ReminderController _reminderController= Get.put(ReminderController());
   final TextEditingController _titleController= TextEditingController();
   final TextEditingController _dosageController= TextEditingController();
    var _image;
   var imagePicker;
   void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }
  Future getImagefromcamera() async {
    XFile image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.front);
            setState(() {
            _image = File(image.path);
            });
  } 
  Future getImagefromGallery()async
   {  XFile image = await imagePicker.pickImage(
       source: ImageSource.gallery,
        imageQuality: 50,
        );
          setState(() {
         _image = File(image.path);
          });  
  }
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedRepeat = "None";
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title:  Text(
          'Create Reminder',
          style: TextStyle(
            color: Colors.black,

          ),
        ),
         centerTitle:true,
         backgroundColor: Colors.teal[200],
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,
            size: 20,),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:10,
            ),
          InputField(title:"Medicine Name", hint: "Enter the name of medicine", controller: _titleController,),
          InputField(title:"Dosage", hint: "Enter the amount to be taken", controller: _dosageController,),
          Row(
            children: <Widget>[
              Expanded(child:
               InputField(title:"Time", hint:_startTime, 
               widget: IconButton(onPressed: (){
                 _getTimeFromUser(isStartTime: true);
               }, 
               icon: Icon (
                 Icons.access_alarm_rounded,
                 color: Colors.black,
                 ),
                 ),
                 ),
                 ),
                 SizedBox(width: 12),
                 Expanded(child:
               InputField(title:"Repeat", hint:"$_selectedRepeat", 
               widget: DropdownButton(
                 icon: Icon(Icons.keyboard_arrow_down,
                 color: Colors.black,
                 ),
                 iconSize: 32,
                 elevation: 4,
                 underline: Container( height:0,),
                 onChanged: (String? newValue){
                   setState(() {
                     _selectedRepeat = newValue!;
                   });
                 },
                 items:repeatList.map<DropdownMenuItem<String>>((String? value){
                   return DropdownMenuItem<String>(
                     value: value.toString(),
                     child: Text(value.toString()),
                     );
                 }
                 ).toList(),
                 ),
               )
              ),
            ],
          ),
         Container(
            margin: EdgeInsets.only(top:12.0, right:250.0, bottom:10),
            child: Text("Medicine Image",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          ),
           Row(
            children: [
             Container(
              height:MediaQuery.of(context).size.height * 0.25,
              width:MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,
               width: 1.0,),
              borderRadius: BorderRadius.circular(12),
             ),
              child: Center(
                child: _image == null
                    ? Text("Add image of your Medicine",
                    style: TextStyle(
                     color: Colors.grey,)): Image.file(_image),
              ),
              ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor:Color.fromARGB(255, 6, 89, 92),
                heroTag: Text("btn1"),
                onPressed: getImagefromcamera,
                tooltip: "pickImage",
                child: Icon(Icons.camera_alt),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                 backgroundColor:Color.fromARGB(255, 6, 89, 92),
                 heroTag: Text("btn1"),
                 onPressed: getImagefromGallery,
                tooltip: "Pick Image",
                child: Icon(Icons.add_photo_alternate),
              )
          ], ),
          )
          ],
        ), 
         SizedBox( height: 18),
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(label: "+ Add Reminder", onTap: ()=> _validateData()),  
           ]
        ),
      ],
      ),
      ),
     ),
    );
  }
  _validateData(){
   //if(_titleController.text.isNotEmpty && _dosageController.text.isNotEmpty)
   // {
      _addReminderToDb();
     Get.back();
   // }
   // else if(_titleController.text.isEmpty ||  _dosageController.text.isEmpty)
   //{
     //Get.snackbar("Required", "All fields are required!",
     //snackPosition: SnackPosition.BOTTOM,
    // backgroundColor: Colors.white,
    // icon: Icon(Icons.warning_amber_rounded),
    // colorText: Colors.red,
    // );
   //}
  
  }
  _addReminderToDb() async {
   int value= await _reminderController.addRem(
      rem: Reminder(
      title: _titleController.text,
      dosage: _dosageController.text,
      startTime: _startTime,
      repeat: _selectedRepeat,
      //isCompleted: 0,
    )
  );
   print(value);
  }
  _getTimeFromUser({required bool isStartTime})
  async {
    var pickedTime = await showTimePicker(initialEntryMode: TimePickerEntryMode.input ,context: context,
     initialTime: TimeOfDay(
       hour: int.parse(_startTime.split(":")[0]), 
       minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
    String _formatedTime= pickedTime!.format(context);
    if(pickedTime==null)
    {
      print("Time Cancelled");
    }
    else if(isStartTime==true)
    {
      setState(() {
        _startTime=_formatedTime;
      });
    }
  }
}