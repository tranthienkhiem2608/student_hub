import 'package:flutter/material.dart';
import 'package:student_hub/views/welcome_view.dart';
import 'package:student_hub/views/login_view.dart';
import 'package:student_hub/views/profile_input.dart';
import 'package:student_hub/views/welcome-screen.dart';
import 'package:student_hub/views/edit_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Hub",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomePage(),
    );
  }
}
