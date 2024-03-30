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
        print("Connect server successful");
        print(response);
        var token = response['result']['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        Navigator.of(context).pop();
        if (user.role == 1) {
          ControllerRoute(context)
              .navigateToProfileInputCompany(
                  user);
        } else {
          ControllerRoute(context)
              .navigateToProfileInputStudent1(
                  user);
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
        ControllerRoute(context).navigateToLoginView(user.role!);
      }else{
        print("Failed to connect to the server");
        print("Connect server failed");
      }

    }catch(e){
      print(e);
    }
  }
}
