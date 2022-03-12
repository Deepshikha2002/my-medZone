import 'package:schedule_reminder/controllers/appointment_controller.dart';
import 'package:schedule_reminder/model/appoint.dart';
import 'package:schedule_reminder/screens/add_appointment.dart';
import 'package:schedule_reminder/widgets/appointment_tile.dart';
import 'package:schedule_reminder/widgets/pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:schedule_reminder/services/notification_services.dart';
import 'package:intl/intl.dart';



class Appointments extends StatefulWidget {
  static String id = 'Appointments';



  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointments> {

  final _appointmentController = Get.put(AppointmentController());
  var notify;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notify = Notify();
    notify.requestIOSPermissions();
    notify.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Appointment Reminder",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Colors.greenAccent[100],

      ),
      backgroundColor: Colors.white,
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appointments.png'),
          ),
        ),
        child:  Column(
          children: [
            _addNewAppt(),
            SizedBox(height: 10,),
            _showAppointments(),
          ],
        ),
      )
    );
  }

  _showAppointments() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _appointmentController.appintmentList.length,
            itemBuilder: (_, index) {
              Appointment appointment=_appointmentController.appintmentList[index] ;
              DateTime date = DateFormat.jm().parse(
                  appointment.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              notify.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  appointment

              );

              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet( context, appointment);
                            },
                            child: AppointmentTile(_appointmentController.appintmentList[index]),
                          )

                        ],
                      ),
                    ),
                  )
              );
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Appointment appointment){
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
              label: "Delete ",
              onTap: (){
                _appointmentController.delete(appointment);
                Get.back();
              },
              clr: Colors.red,
              context: context,
            ),
            SizedBox(height: 5,),
            _bottomSheetButton(
              label: "Close ",
              onTap: (){
                Get.back();
              },
              clr: Colors.black,
              isClose: true,
              context: context,
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context
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
            color: isClose==true?Colors.black:clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.grey:clr,
        ),
        child:Center(
          child: Text(
            label,
            style: isClose? TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white
            ):TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color:Colors.white),
          ),
        ),
      ),
    ) ;
  }




  _addNewAppt() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7,),
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
            Button(label: "+Add", onTap: () async {
              await Get.to(() => AddAppointment());
              _appointmentController.getAppointments();
            }
            )


          ],
        )
    );
  }

}
