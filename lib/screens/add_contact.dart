import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class  AddContact extends StatefulWidget {
  static String id= 'AddContact';

  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState  createState() =>  _AddContactState();
}


class _AddContactState extends State<AddContact> {

  TextEditingController? _nameController;
  TextEditingController? _numberController;
  TextEditingController? _emailController;
  TextEditingController? _telephoneController;
  TextEditingController? _addressController;
  TextEditingController? _specializationController;

  DatabaseReference? _ref;



  @override
  void initState() {
    super.initState();
    _nameController= TextEditingController();
    _numberController= TextEditingController();
    _emailController= TextEditingController();
    _telephoneController= TextEditingController();
    _addressController= TextEditingController();
    _specializationController= TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child('Contacts');


  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Save Contacts',
          style: TextStyle(
            color: Colors.black,

          ),
        ),
        backgroundColor: Colors.teal[200],
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                const InputDecoration(
                  hintText: 'Enter Name',
                  prefixIcon: Icon(Icons.account_circle, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _numberController,
                decoration:
                const InputDecoration(
                  hintText: 'Enter Number',
                  prefixIcon: Icon(Icons.phone_android, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _telephoneController,
                decoration:
                const InputDecoration(
                  hintText: 'Enter Telephone Number',
                  prefixIcon: Icon(Icons.phone, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                const InputDecoration(
                  hintText: 'Enter email address',
                  prefixIcon: Icon(Icons.email, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _addressController,
                decoration:
                const InputDecoration(
                  hintText: 'Enter address',
                  prefixIcon: Icon(Icons.location_on, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _specializationController,
                decoration:
                const InputDecoration(
                  hintText: 'Enter specialization',
                  prefixIcon: Icon(Icons.badge, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
          GestureDetector(
            onTap: (){saveContact();},
            child: Center(
              child: Container(

                width: 250,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 6, 89, 92),
                ),
                child: Center(
                  child:Text(
                    'save contact',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ),

            ],
          ),
        ),
      ),
    );
  }
  void saveContact(){
    String name= _nameController!.text;
    String phoneNumber= _numberController!.text;
    String teleNumber= _telephoneController!.text;
    String email= _emailController!.text;
    String address= _addressController!.text;
    String specialization= _specializationController!.text;

    Map<String,String> contact = {
      'name': name,
      'phone Number':'+91'+phoneNumber,
      'telephone Number':teleNumber,
      'email address':email,
      'address':address,
      'specialization':specialization,
    };
    _ref!.push().set(contact).then((value){
      Navigator.pop(context);
    });
  }
}
