import 'package:flutter/material.dart';
import 'package:student_hub/views/auth/chooserole_view.dart';
import 'package:student_hub/views/pages/dashboard_page.dart';
import 'package:student_hub/views/profile_creation/student/profile_student_dragcv.dart';
import 'package:student_hub/views/auth/signup_info_view.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/homescreen/welcome_view.dart';
import 'package:student_hub/views/auth/login_view.dart';
import 'package:student_hub/views/profile_creation/company/profile_input.dart';
import 'package:student_hub/views/homescreen/welcome-screen.dart';
import 'package:student_hub/views/profile_creation/company/edit_profile.dart';
import 'package:student_hub/views/profile_creation//student/home_view.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student1.dart';
import 'package:student_hub/views/auth/signup_info_view.dart';

import 'package:student_hub/views/profile_creation/student/profile_input_student2.dart';
import 'package:student_hub/models/student_user.dart';

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
      home: WelcomePage(),
    );
  }
}
