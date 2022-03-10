import 'package:schedule_reminder/controllers/appointment_controller.dart';
import 'package:schedule_reminder/widgets/input_field.dart';
import 'package:schedule_reminder/widgets/pattern.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:schedule_reminder/model/appoint.dart';

class AddAppointment extends StatefulWidget {
  static String id = 'AddAppointment';

  const AddAppointment({Key? key}) : super(key: key);

  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment>{
  final AppointmentController _appointmentController = Get.put(AppointmentController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _docnameContoller = TextEditingController();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime="9:30 AM";
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind =5;
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Appointment"),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(title: "Patient Name", hint: "Enter your name ",controller: _nameController,),
              InputField(title: "Docter Name", hint: "Enter Doctor Name ", controller: _docnameContoller,),
              InputField(title: "Phone Number", hint: "Enter phone number of doctor ", controller: _numController,),
              InputField(title: "Address", hint: "Enter Address ", controller: _addressController,),
              InputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: (){
                    _getDateFromUser();
                  },
                ), ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      )
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                      child: InputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      )
                  ),
                ],
              ),
              InputField(title: "Remind me", hint: "$_selectedRemind hours early",
                widget: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,),
                    iconSize: 32,
                    elevation: 4,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey
                    ),
                    underline: Container(height: 0,),
                    onChanged: (String? newValue){
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    items: remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }
                    ).toList()
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Button(label:"Save", onTap: ()=>_validateDate()),
            ],
          ),
        ),
      ),
    );
  }
  _validateDate(){
    if(_nameController.text.isNotEmpty&&_docnameContoller.text.isNotEmpty
        &&_numController.text.isNotEmpty&&_addressController.text.isNotEmpty){
      _addAppointmentToDb();
      Get.back();
    }else if(_numController.text.isEmpty || _addressController.text.isEmpty ||
        _docnameContoller.text.isEmpty || _nameController.text.isEmpty){
      Get.snackbar("Required", "All field are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }
  _addAppointmentToDb() async {
    int value=await _appointmentController.addAppointment(
        appoin: Appointment(
          name:_nameController.text,
          docName:_docnameContoller.text,
          phoneNo: _numController.text,
          address: _addressController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime:_startTime,
          endTime: _endTime,
          remind: _selectedRemind,

        )

    );
    print("my id is"+"$value");
  }
  _getDateFromUser() async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2122)
    );

    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }else{
      print("something is wrong");
    }
  }
  _getTimeFromUser({required bool isStartTime})async {
    var pickedTime =await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time canceled");
    }else if(isStartTime==true){
      setState(() {
        _startTime=_formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime=_formatedTime;
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        )
    );
  }
}
