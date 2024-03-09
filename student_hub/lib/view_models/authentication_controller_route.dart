import 'package:flutter/material.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/views/chooserole_view.dart';
import 'package:student_hub/views/home_view.dart';
import 'package:student_hub/views/profile_input_student1.dart';
import 'package:student_hub/views/profile_input_student2.dart';
import 'package:student_hub/views/profile_student_dragcv.dart';
import 'package:student_hub/views/signup_info_view.dart';
import 'package:student_hub/views/switch_account_view.dart';
import 'package:student_hub/views/login_view.dart';
import 'package:student_hub/views/profile_input.dart';
import 'package:student_hub/views/welcome-screen.dart';
class ControllerRoute {
  final BuildContext context;

  ControllerRoute(this.context);


  void navigateToSwitchAccountView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView()),
    );
  }

  void navigateToLoginView(String typeUser) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(typeUser)),
    );
  }

  void navigateToSignupInfoView(String typeUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpInfo(typeUser)),
    );
  }

  void navigateToChooseRoleView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChooseRole()),
    );
  }

  void navigateToProfileInputCompany(User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileInput(user)),
    );
  }
  void navigateToProfileInputStudent1(User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileInputStudent1(user)),
    );
  }

  void navigateToProfileInputStudent2(StudentUser studentUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileInputStudent2(studentUser)),
    );
  }
  void navigateToProfileInputStudent3(StudentUser studentUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StudentProfileDragCv(studentUser)),
    );
  }

  void navigateToWelcomeView(CompanyUser companyUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen(companyUser)),
    );
  }

  void navigateToHomeScreen(CompanyUser companyUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(showAlert: false)),
    );
  }





}
