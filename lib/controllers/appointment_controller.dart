import 'package:schedule_reminder/db/db_helper.dart';
import 'package:get/get.dart';

import '../model/appoint.dart';

class AppointmentController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var appintmentList = <Appointment>[].obs;


  Future<int> addAppointment({Appointment? appoin})async{
    return await DBHelper.insert(appoin);
  }

  void getAppointments()async{
    List<Map<String, dynamic>> appointments= await DBHelper.query();
    appintmentList.assignAll(appointments.map((data)=> new Appointment.fromJson(data)).toList());
  }

  void delete(Appointment appointment){
    DBHelper.delete(appointment);
    getAppointments();
  }
}