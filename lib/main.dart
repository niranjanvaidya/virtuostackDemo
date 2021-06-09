import 'package:flutter/material.dart';
import 'LoadingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF54565A),
        scaffoldBackgroundColor: Color(0xFF54565A),
      ),
      home: LoadingScreen(),
    );
  }
}
