import 'package:flutter/material.dart';
import 'package:student_hub/view_models/controller_route.dart';

import '../components/loadingUI.dart';
import '../models/model/users.dart';
import '../services/connection_services.dart';
import 'dart:convert';

class InputProfileViewModel {
  final BuildContext context;
  InputProfileViewModel(this.context);

  Future<void> inputProfileCompany(User companyUser) async {
    print('Input Profile Company');
    var payload = companyUser.companyUser?.toMapCompanyUser();
    // Call a method to reload the page
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var response =
          await ConnectionService().post('/api/profile/company', payload);
      if (response != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
        var responseUserMap = jsonDecode(response);
        User userReponse = User.fromMapUser(responseUserMap['result']);
        Navigator.of(context).pop();
        ControllerRoute(context).navigateToWelcomeView(userReponse);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> inputProfileStudent(User studentUser) async {
    print('Input Profile Student');
    var payload = studentUser.toMapUser(); // Call a method to reload the page
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var response =
          await ConnectionService().post('/api/profile/student', payload);
      if (response != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
      }
    } catch (e) {
      print(e);
    }
  }
}
