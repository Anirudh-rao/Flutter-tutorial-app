import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/Services/Auth.dart';
import 'package:time_tracker_flutter_course/app/Landing_Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
