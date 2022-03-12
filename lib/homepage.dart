import 'package:flutter/material.dart';
import 'package:schedule_reminder/controllers/reminder_controller.dart';
import 'package:schedule_reminder/model/reminderformat.dart';
import 'package:schedule_reminder/screens/reminder.dart';
import 'package:schedule_reminder/widgets/button.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:schedule_reminder/widgets/task_tile.dart';
import 'package:schedule_reminder/widgets/navbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _reminderController = Get.put(ReminderController());
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
        backgroundColor: Colors.greenAccent[100],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/remind.png'),
          ),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: MyButton(label: "+ Add Reminder",  onTap: () async { await Get.to(AddReminder());
              _reminderController.getRems();
              }
              ),
              ),
            ),
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
             return AnimationConfiguration.staggeredList(
               position: index,
              child:SlideAnimation(
                child:FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                         _showBottomBar(context, _reminderController.remList[index]);
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

}