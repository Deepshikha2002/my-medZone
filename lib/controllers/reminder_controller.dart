import 'package:get/get.dart';
import 'package:schedule_reminder/db/db_helper1.dart';
import 'package:schedule_reminder/model/reminderformat.dart';

class ReminderController extends GetxController{
  @override
  void onReady()
  {
    super.onReady();
  }
  var remList = <Reminder>[].obs;
  Future<int> addRem({Reminder? rem})
  async {
    return await DBHelper1.insert(rem);
  }
  void getRems() async {
    List<Map<String, dynamic>> rems = await DBHelper1.query();
    remList.assignAll(rems.map((data)=>  new Reminder.fromJson(data)).toList());
  }
   void delete(Reminder rem){
    DBHelper1.delete(rem);
    getRems();
  }
}