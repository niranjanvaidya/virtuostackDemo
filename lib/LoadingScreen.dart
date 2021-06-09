import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:virtuostack/LoginScreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          color: Colors.blue,
          child: SplashScreen(
            photoSize: 100,
            seconds: 5,
            navigateAfterSeconds: LoginScreen(),
            image: Image.asset('images/image.gif'),
            backgroundColor: Color(0xFF54565A),
            useLoader: false,
          ),
        )),
        Expanded(
          child: Column(children: [
            Container(
                child: Text('Dog\'s Path',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.0,
                        color: Colors.grey))),
            Container(
                child: Text('By',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey))),
            SizedBox(
              height: 10,
            ),
            Container(
                child: Text('VirtuoStack Softwares Pvt Ltd',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.grey))),
          ]),
        )
      ],
    )));
  }
}
