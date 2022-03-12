import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class  EditContact extends StatefulWidget {
  static String id= 'EditContact';
  String contactKey;

  EditContact({Key? key, required this.contactKey}) : super(key: key);

  @override
  _EditContactState  createState() =>  _EditContactState();
}


class _EditContactState extends State<EditContact> {

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
    getContactDetail();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Edit Contact',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.greenAccent[100],
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
                height: 40,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  child: const Text(
                    'save ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: (){
                    saveContact();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getContactDetail() async {
    DataSnapshot snapshot = (await _ref!.child(widget.contactKey).once()) as DataSnapshot;

    Map contact= snapshot.value as Map;

    _nameController!.text = contact['name'].toString();
    _numberController!.text = contact['number'].toString();
    _telephoneController!.text= contact['teleNumber'].toString();
    _emailController!.text= contact['email'].toString();
    _addressController!.text=contact['address'].toString();
    _specializationController!.text=contact['specialization'].toString();

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
    _ref!.child(widget.contactKey).update(contact).then((value) {
      Navigator.pop(context);
    });
  }
}
