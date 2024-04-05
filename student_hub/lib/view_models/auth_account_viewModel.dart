import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/view_models/controller_route.dart';

import '../components/loadingUI.dart';
import '../models/model/users.dart';
import '../services/connection_services.dart';
import '../views/auth/switch_account_view.dart';
import '../widgets/account_list_dialog.dart';

class AuthAccountViewModel {
  final BuildContext context;

  AuthAccountViewModel(this.context);
  void reloadPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccountView()),
    );
  }

  Future<void> showAccountList(List<CompanyUser> accounts) async {
    print('Show Account List');
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AccountListDialog(
              accounts,
              (CompanyUser companyUser) async {
                for (var account in accounts) {
                  account.isLogin = false;
                }
                companyUser.isLogin = true;
                // Call a method to reload the page
              },
              reloadPage,
              // Pass the method to reload the page
            ),
          );
        });
  }

  Future<void> loginAccount(User user) async {
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
        var responseUser = await ConnectionService().get('/api/auth/me', {});
        var responseUserMap = jsonDecode(responseUser);

        if (responseUserMap['result'] != null) {
          print('User Response');
          User userResponse = User.fromMapUser(responseUserMap['result']);
          print(userResponse.id);
          print(userResponse.fullname);
          print(userResponse.role);
          print(userResponse.role?[0]);

          Navigator.of(context).pop();
          // int role = int.parse(userResponse.role?[0]);
          int role = int.parse(userResponse.role?[0] ?? '0');
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
              print(userResponse.companyUser!);

              userResponse.studentUser == null
                  ? ControllerRoute(context)
                      .navigateToProfileInputStudent1(userResponse)
                  : ControllerRoute(context)
                      .navigateToHomeScreen(true, userResponse);
            }
          } else if (userResponse.role?.length == 2) {
            // ControllerRoute(context).navigateToHomeScreen(false, userResponse);

            if (userResponse.role?.first == '1') {
              if (userResponse.companyUser?.id == null) {
                ControllerRoute(context)
                    .navigateToProfileInputCompany(userResponse);
              } else {
                ControllerRoute(context)
                    .navigateToHomeScreen(false, userResponse);
              }
            } else if (userResponse.role?.first == '0') {
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
}
