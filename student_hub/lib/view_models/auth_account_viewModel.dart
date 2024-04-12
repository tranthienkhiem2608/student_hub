import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:quickalert/quickalert.dart';

import '../components/loadingUI.dart';
import '../models/model/users.dart';
import '../services/connection_services.dart';
import '../views/auth/switch_account_view.dart';
import '../widgets/account_list_dialog.dart';

class AuthAccountViewModel {
  final BuildContext context;

  AuthAccountViewModel(this.context);
  void reloadPage(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView(user)),
    );
    prefs.getInt('role') == 0
        ? ControllerRoute(context).navigateToHomeScreen(true, user)
        : ControllerRoute(context).navigateToHomeScreen(false, user);
  }

  Future<void> showAccountList(User accounts) async {
    print('Show Account List');
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AccountListDialog(
              accounts,
              reloadPage,
              // Pass the method to reload the page
            ),
          );
        });
  }

  Future<void> loginAccount(bool stageNav, User user) async {
    print('Login Account');
    var payload = user.toMapUser();
    // Call a method to reload the page
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var response =
          await ConnectionService().post('/api/auth/sign-in', payload);
      var responseDecode = jsonDecode(response);
      print(responseDecode);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        // print('ERROR: ' + responseDecode['errorDetails']);
        String token = responseDecode['result']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        print(token);
        if (stageNav == false) {
          return;
        }
        var responseUser = await ConnectionService().get('/api/auth/me', {});
        var responseUserMap = jsonDecode(responseUser);

        if (responseUserMap['result'] != null) {
          print('User Response');
          User userResponse = User.fromMapUser(responseUserMap['result']);
          print(userResponse.id);
          print(userResponse.fullname);
          print(userResponse.role);
          print(userResponse.role?[0]);

          // Navigator.of(context).pop();
          // int role = int.parse(userResponse.role?[0]);
          int role = userResponse.role?[0];
          print('length: ${userResponse.role?.length}');

          if (userResponse.role?.length == 1) {
            prefs.setInt('role', role);
            if (role == 1) {
              userResponse.companyUser == null
                  ? ControllerRoute(context)
                      .navigateToProfileInputCompany(userResponse)
                  : ControllerRoute(context)
                      .navigateToHomeScreen(false, userResponse);
            } else if (role == 0) {
              print('USER RESPONSE');

              print(userResponse.studentUser?.id);
              Navigator.of(context).pop();
              userResponse.studentUser == null
                  ? ControllerRoute(context)
                      .navigateToProfileInputStudent1(userResponse)
                  : ControllerRoute(context)
                      .navigateToHomeScreen(true, userResponse);
              // ControllerRoute(context)
              //     .navigateToProfileInputStudent3(userResponse);
            }
          } else {
            // ControllerRoute(context).navigateToHomeScreen(false, userResponse);
            print('Switch Account');
            // prefs.setInt('role', 1);
            if (role == 1) {
              print('Switch Account1');

              Navigator.of(context).pop();
              userResponse.companyUser == null
                  ? ControllerRoute(context)
                      .navigateToProfileInputCompany(userResponse)
                  : ControllerRoute(context)
                      .navigateToHomeScreen(false, userResponse);
            } else if (role == 0) {
              print('Switch Account2');

              userResponse.studentUser == null
                  ? ControllerRoute(context)
                      .navigateToProfileInputStudent1(userResponse)
                  : ControllerRoute(context)
                      .navigateToHomeScreen(true, userResponse);
            }
          }
        }
      } else {
        print("Failed to connect to the server");
        print("Connect server failed");
        // Show error message with error details
        Navigator.of(context).pop();

        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: responseDecode['errorDetails'].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> signUpAccount(User user) async {
    print('Sign Up Account');
    var payload = user.toMapUser();
    // Call a method to reload the page
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var response =
          await ConnectionService().post('/api/auth/sign-up', payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        Navigator.of(context).pop();
        ControllerRoute(context).navigateToLoginView();
      } else {
        print("Failed to connect to the server");
        print("Connect server failed");
        Navigator.of(context).pop();
        print(responseDecode['errorDetails']);
        return response;
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<void> logoutAccount() async {
    print('Sign Out Account');
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.get('token');
      var payload = {'authorization': token};
      var response = await ConnectionService().postLogout('/api/auth/logout');
      var responseDecode = jsonDecode(response);
      if (responseDecode != null) {
        print("Connected to the server successfully: logout");
        print("Connect server successful");
        print(response);
        prefs.remove('token');
        Navigator.of(context).pop();
        ControllerRoute(context).navigateToLoginView();
      } else {
        print("Failed to connect to the server: logout");
        print("Connect server failed");
        print(responseDecode['errorDetails']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> forgotPassword(String email) async {
    print('Forgot Password');
    var payload = {'email': email};
    // Call a method to reload the page
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var response =
          await ConnectionService().post('/api/user/forgotPassword', payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        Navigator.of(context).pop();
        ControllerRoute(context).navigateToNotifySendPasswordView(email);
      } else {
        print("Failed to connect to the server");
        print("Connect server failed");
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(responseDecode['errorDetails'].toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
        print(responseDecode['errorDetails']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> changePassword(
      String email, String oldPassword, String newPassword) async {
    print('Change Password');
    var payload = {'oldPassword': oldPassword, 'newPassword': newPassword};
    // Call a method to reload the page
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      User user = User(
        id: 0,
        email: email,
        password: oldPassword,
        fullname: '',
        role: [0],
        companyUser: null,
        studentUser: null,
      );
      loginAccount(false, user);
      var response =
          await ConnectionService().put('/api/user/changePassword', payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        Navigator.of(context).pop();
        user = User(
          id: 0,
          email: email,
          password: newPassword,
          fullname: '',
          role: [0],
          companyUser: null,
          studentUser: null,
        );
        loginAccount(true, user);
      } else {
        print("Failed to connect to the server");
        print("Connect server failed");
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(responseDecode['errorDetails'].toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
        print(responseDecode['errorDetails']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> userProfile(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt('role');

    if (role == 1) {
      user.companyUser == null
          ? ControllerRoute(context).navigateToProfileInputCompany(user)
          : ControllerRoute(context).navigateToEditProfileInputCompany(user);
    } else if (role == 0) {
      user.studentUser == null
          ? ControllerRoute(context).navigateToProfileInputStudent1(user)
          : ControllerRoute(context).navigateToEditProfileInputCompany(user);
    }
  }

// Future<void> switchAccount(){
//   return
// }
}
