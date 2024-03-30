import 'package:flutter/material.dart';
import 'package:student_hub/models/model/company_user.dart';

import '../components/loadingUI.dart';
import '../services/connection_services.dart';

class InputProfileViewModel {
  final BuildContext context;
  InputProfileViewModel(this.context);


  Future<void> inputProfileCompany(CompanyUser companyUser) async {
    print('Input Profile Company');
    var payload = companyUser.toMapCompanyUser();
    // Call a method to reload the page
    try{
      showDialog(context: context, builder: (context) => LoadingUI());
      var response = await ConnectionService().post('/api/profile/company', payload);
      if(response != null){
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
      }
    }catch(e){
      print(e);
    }
  }
  Future<void> inputProfileStudent(CompanyUser companyUser) async {
    print('Input Profile Student');
    var payload = companyUser.toMapCompanyUser();
    // Call a method to reload the page
    try{
      showDialog(context: context, builder: (context) => LoadingUI());
      var response = await ConnectionService().post('/api/profile/student', payload);
      if(response != null){
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
      }
    }catch(e){
      print(e);
    }
  }
}