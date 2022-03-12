class Appointment{
  int? id;
  String? name;
  String? docName;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  dynamic address;
  dynamic phoneNo;

  Appointment({
    this.id,
    this.name,
    this.docName,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.address,
    this.phoneNo,

  });

  Appointment.fromJson(Map<String, dynamic>json) {
    id = json['id'];
    name = json['name'];
    docName = json['docName'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    phoneNo = json['phoneNo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['name']=this.name;
    data['docName']=this.docName;
    data['date']=this.date;
    data['startTime']=this.startTime;
    data['endTime']=this.endTime;
    data['remind']=this.remind;
    data['address']= this.address;
    data['phoneNo']=this.phoneNo;
    return data;
  }
}

