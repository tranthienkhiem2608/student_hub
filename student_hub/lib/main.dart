import 'package:flutter/material.dart';
import 'package:student_hub/views/chooserole_view.dart';
import 'package:student_hub/views/pages/dashboard_page.dart';
import 'package:student_hub/views/profile_student_dragcv.dart';
import 'package:student_hub/views/signup_info_view.dart';
import 'package:student_hub/views/switch_account_view.dart';
import 'package:student_hub/views/welcome_view.dart';
import 'package:student_hub/views/login_view.dart';
import 'package:student_hub/views/profile_input.dart';
import 'package:student_hub/views/welcome-screen.dart';
import 'package:student_hub/views/edit_profile.dart';
import 'package:student_hub/views/home_view.dart';
import 'package:student_hub/views/profile_input_student1.dart';

import 'package:student_hub/views/profile_input_student2.dart';
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
      home: StudentProfileDragCv(),
    );
  }
}
