import 'package:caerus/main.dart';
import 'package:flutter/material.dart';

import 'MainLoginScreen.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigatetologin();
  }

  _navigatetologin()async{
    await Future.delayed(Duration(microseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'CAERUS',)));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Text("SystemCAERUS", style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
