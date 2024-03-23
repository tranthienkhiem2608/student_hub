import 'package:flutter/material.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/views/auth/chooserole_view.dart';
import 'package:student_hub/views/profile_creation/student/home_view.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student1.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student2.dart';
import 'package:student_hub/views/profile_creation/student/profile_student_dragcv.dart';
import 'package:student_hub/views/auth/signup_info_view.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/auth/login_view.dart';
import 'package:student_hub/views/profile_creation/company/profile_input.dart';
import 'package:student_hub/views/homescreen/welcome-screen.dart';
class ControllerRoute {
  final BuildContext context;

  ControllerRoute(this.context);

//authentification
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

  void navigateToHomeScreen(bool? showAlert, CompanyUser? companyUser, StudentUser? studentUser) {
    if(companyUser == null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(showAlert: true, studentUser: studentUser)),
      );
    } else if(studentUser == null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(showAlert: false, companyUser: companyUser)),
      );
    }
  }





}
