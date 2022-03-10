import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ContactInfo extends StatefulWidget {

  static String id ='ContactInfo';

  String contactKey;

  ContactInfo({required this.contactKey,  });

  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  late DatabaseReference _ref;

  String? contactKey ;
  String? Name;
  String? PnoneNo;
  String? TelNo;
  String? Add;
  String? Spc;
  String? Email;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactDetail();
    _ref= FirebaseDatabase.instance.ref().child('Contacts');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Information'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "Name:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                Name!,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Phone No:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                  PnoneNo!,
                  style: TextStyle(
                    fontSize: 12,
                  )
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Telephone No:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                  TelNo!,
                  style: TextStyle(
                    fontSize: 12,
                  )
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Email Address:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                  Email!,
                  style: TextStyle(
                    fontSize: 12,
                  )
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Address:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                  Add!,
                  style: TextStyle(
                    fontSize: 12,
                  )
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Specialization:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                  Spc!,
                  style: TextStyle(
                    fontSize: 12,
                  )
              ),
            ],
          ),

        ],
      ),
    );
  }
  getContactDetail() async{
    DataSnapshot snapshot = (await _ref.child(widget.contactKey).once()) as DataSnapshot;

    Map contact= snapshot.value as Map;

    Name= contact['name']!;
    PnoneNo=contact['phone Number']!;
    TelNo=contact['telephone Number']!;
    Email=contact['email address']!;
    Add=contact['address']!;
    Spc=contact['specialization']!;
  }
}


