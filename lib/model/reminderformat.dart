class Reminder{
  int? id;
  String? title;
  String? dosage;
 // int? isCompleted;
  String? startTime;
  String? repeat;

  Reminder({
    this.id, 
    this.title,
    this.dosage,
  //  this.isCompleted,
    this.startTime,
    this.repeat,
  });
Reminder.fromJson(Map<String, dynamic> json)
{
  id= json['id'];
  title= json['title'];
  dosage= json['dosage'];
 // isCompleted= json['isCompleted'];
  startTime= json['startTime'];
  repeat= json['repeat'];
}
Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id']= this.id;
  //data['isCompleted']= this.isCompleted;
  data['title']= this.title;
  data['dosage']= this.dosage;
  data['startTime']= this.startTime;
  data['repeat']= this.repeat;
  return data;
}
}