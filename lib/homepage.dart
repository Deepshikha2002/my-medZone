import 'package:flutter/material.dart';
import 'package:schedule_reminder/controllers/reminder_controller.dart';
import 'package:schedule_reminder/model/reminderformat.dart';
import 'package:schedule_reminder/screens/reminder.dart';
import 'package:schedule_reminder/services/notification_services1.dart';
import 'package:schedule_reminder/widgets/button.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:schedule_reminder/widgets/task_tile.dart';
import 'package:schedule_reminder/widgets/navbar.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _reminderController = Get.put(ReminderController());
  var _notify;
   @override
  void initState() {
    super.initState();
    _notify = Notifying();
    _notify.requestIOSPermissions();
    _notify.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title:  Text('medZone',
         style: TextStyle(
           color: Colors.black,
         ),),
        centerTitle:true,
        backgroundColor: Colors.teal[200],
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/remind.jpeg'),
        ),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            _addNewRem(),
            SizedBox(height: 10,),
            _showReminders(),
          ],
        ),
      ),
    );
  }

  _showReminders() {
    return Expanded(
      child: Obx((){
        return ListView.builder(
          itemCount: _reminderController.remList.length,
          itemBuilder: (_, index){
            Reminder reminder= _reminderController.remList[index];
             DateTime date = DateFormat.jm().parse(
                  reminder.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              _notify.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                 reminder
              );
             return AnimationConfiguration.staggeredList(
               position: index,
              child:SlideAnimation(
                child:FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                         _showBottomBar(context, reminder);
                        },
                        child: TaskTile( _reminderController.remList[index]),
                      )
                    ],)
                  ) ), );
              
        });
      }),
      );
  }

  _showBottomBar(BuildContext context, Reminder rem){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top:4),
        height: MediaQuery.of(context).size.height*0.20,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 235, 228, 227),
              ),
            ),
            Spacer(),
            _bottomSheetButton(
              label: "Delete",
              onTap: (){
                _reminderController.delete(rem);
                Get.back();
              },
              clr: Colors.red,
              context: context,
            ),
            SizedBox(height:45,),

          ],
        ),
      ),
    );
  }
_bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width*0.9,
        height: 40,

        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: clr,
          ),
          borderRadius: BorderRadius.circular(10),
          color: clr,
        ),
        child:Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
            )
          )
        ),
      ),
    ) ;
  }
  _addNewRem() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
            ),
            MyButton(label: "+Add Reminder", onTap: () async {
              await Get.to(() =>(AddReminder()));
              _reminderController.getRems();
            }
            )


          ],
        )
    );
  }


}