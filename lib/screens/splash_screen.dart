import 'package:flutter/material.dart';
import 'package:schedule_reminder/homepage.dart';

class Splash extends StatefulWidget {
  static String id = 'splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState()
  {
    super.initState();
    _navigatetohome();
  }
_navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 7000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));
}
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
          alignment: Alignment.center,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           children:[
               Image.asset('assets/icon.png',
                 width:300,
                 height: 300,),
        ],
    ),
      ),
    );

  }
}