import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/views/auth/chooserole_view.dart';
import 'package:student_hub/views/auth/forgort_password_view.dart';
import 'package:student_hub/views/pages/chat_screen/chat_room.dart';
import 'package:student_hub/views/profile_creation/company/edit_profile.dart';
import 'package:student_hub/views/profile_creation/student/edit_profile_student.dart';
import 'package:student_hub/views/profile_creation/student/home_view.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student1.dart';
import 'package:student_hub/views/profile_creation/student/profile_input_student2.dart';
import 'package:student_hub/views/profile_creation/student/profile_student_dragcv.dart';
import 'package:student_hub/views/auth/signup_info_view.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/auth/login_view.dart';
import 'package:student_hub/views/profile_creation/company/profile_input.dart';
import 'package:student_hub/views/homescreen/welcome-screen.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/auth/notify_send_password_view.dart';
import 'package:student_hub/views/auth/change_password_view.dart';

class ControllerRoute {
  final BuildContext context;

  ControllerRoute(this.context);

//authentification
  void navigateToSwitchAccountView(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView(user)),
    );
  }

  void navigateToLoginView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void navigateToSignupInfoView(int typeUser) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpInfo(typeUser)),
    );
  }

  void navigateToChooseRoleView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseRole()),
    );
  }

  void navigateToProfileInputCompany(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileInput(user)),
    );
  }

  void navigateToEditProfileInputCompany(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfile(user: user)),
    );
  }

  void navigateToProfileInputStudent1(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileInputStudent1(user)),
    );
  }

  void navigateToProfileInputStudent2(User studentUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileInputStudent2(studentUser)),
    );
  }

  void navigateToProfileInputStudent3(User studentUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StudentProfileDragCv(studentUser)),
    );
  }

  void navigateToEditProfileInputStudent(User studentUser) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditProfileInputStudent(studentUser)),
    );
  }

  void navigateToWelcomeView(User companyUser, String fullName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WelcomeScreen(companyUser, fullName)),
    );
  }

  void navigateToForgotPasswordView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordView()),
    );
  }

  void navigateToNotifySendPasswordView(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotifySendPassword(email)),
    );
  }

  void navigateToChangePasswordView(String email) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordView(email)),
    );
  }

  void navigateToHomeScreen(
      bool? showAlert, User? user, int? pageDefault) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt('role');
    print(role);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                showAlert: showAlert!,
                user: user,
                pageDefault: pageDefault,
              )),
    );
  }

  void navigateToChatRoom(int senderId, int receiverId, int projectId,
      String senderName, String receiverName, User user, int flagCheck) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatRoom(
                senderId: senderId,
                receiverId: receiverId,
                projectId: projectId,
                senderName: senderName,
                receiverName: receiverName,
                user: user,
                flagCheck: flagCheck,
              )),
    );
  }
}
