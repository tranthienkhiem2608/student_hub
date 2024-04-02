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
    try{
      showDialog(context: context, builder: (context) => LoadingUI());
      var response = await ConnectionService().post('/api/auth/sign-in', payload);
      if(response != null){
        print("Connected to the server successfully");
        print(response);
        var token = response['result']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        var responseUser = await ConnectionService().get('/api/auth/me');
        if(responseUser != null) {
          var responseUserMap = jsonDecode(responseUser);
          print(responseUserMap);
          User userResponse = User.fromMapUser(responseUserMap['result']);
          print(userResponse.id);
          print(userResponse.fullname);
          print(userResponse.role);
          print(userResponse.role?[0]);

          Navigator.of(context).pop();
          int role = int.parse(userResponse.role?[0]);
          if (userResponse.role?.length == 1){
            prefs.setInt('role', role);
            if(role == 1){
              ControllerRoute(context).navigateToProfileInputCompany(userResponse);

            }
            else if(userResponse.role?[0] == 0){
              ControllerRoute(context).navigateToProfileInputStudent1(userResponse);
            }
          }
        }
      }else{
        print("Failed to connect to the server");
        print("Connect server failed");
      }
    }catch(e){
      print(e);
    }

  }

  Future<void> signUpAccount(User user) async {
    print('Sign Up Account');
    var payload = user.toMapUser();
    // Call a method to reload the page
    try{
      showDialog(context: context, builder: (context) => LoadingUI());
      var response = await ConnectionService().post('/api/auth/sign-up', payload);
      if(response != null){
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        Navigator.of(context).pop();
        ControllerRoute(context).navigateToLoginView(user.role?.last);
      }else{
        print("Failed to connect to the server");
        print("Connect server failed");
      }

    }catch(e){
      print(e);
    }
  }
}
