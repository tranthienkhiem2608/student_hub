import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/services/connection_services.dart';
import 'package:student_hub/views/profile_creation/student/home_view.dart';

import '../components/loadingUI.dart';
import '../models/model/project_company.dart';

class ProjectCompanyViewModel {
  List<ProjectCompany> projectList = [];

  final BuildContext context;
  ProjectCompanyViewModel(this.context);

  // post new project
  Future<void> postProject(ProjectCompany project, User user) async {
    print('Post Project');
    var payload = project.toMapProjectCompany();

    try {
      showDialog(context: context, builder: (context) => LoadingUI());

      var response = await ConnectionService().post('/api/project', payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      user: user,
                      showAlert: false,
                      pageDefault: 1,
                    )));
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get all projects /api/project
  Future<List<ProjectCompany>> getAllProjectsData() async {
    print('Get All Projects Data');
    try {
      var response = await ConnectionService().get('/api/project', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(responseDecode['result']);
        List<ProjectCompany> projectList =
            ProjectCompany.fromListMapAllProject(responseDecode['result']);
        return projectList;
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  // get all projects of that user company id /api/project/company/{companyId}
  Future<List<ProjectCompany>> getProjectsData(int companyId) async {
    print('Get Projects Data');
    try {
      print('Get Projects Data flag');
      var response =
          await ConnectionService().get('/api/project/company/$companyId', {});
      print('Get Projects Data flag1');

      var responseDecode = jsonDecode(response);
      print('Get Projects Data flag2');
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(responseDecode['result']);
        List<ProjectCompany> projectList =
            ProjectCompany.fromListMapProjectCompany(responseDecode['result']);
        return projectList;
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  // delete project /api/project/{id}
  Future<void> deleteProject(int projectId) async {
    print('Delete Project');
    try {
      var response =
          await ConnectionService().delete('/api/project/$projectId');

      // Check HTTP status code first (e.g., 200, 204)
      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Connect server successful");
        print(response.body); // Access response body
        print("Project deleted successfully"); // Success on status code
      } else {
        // Handle other status codes as errors
        print("Failed");
        print("Deletion error: ${response.body}");
      }
    } catch (e) {
      print('Error deleting project: $e');
    }
  }
}
