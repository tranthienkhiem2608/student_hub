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

  Future<void> removeProject(ProjectCompany project) async {
    // Simulate a delay for the API call
    await Future.delayed(Duration(seconds: 1));

    // Remove the project from the list
    projectList.remove(project);
  }

  Future<void> editProject(
      ProjectCompany oldProject, ProjectCompany newProject) async {
    // Simulate a delay for the API call
    await Future.delayed(Duration(seconds: 1));

    // Find the index of the old project in the list
    int index = projectList.indexOf(oldProject);

    // Replace the old project with the new project
    if (index != -1) {
      projectList[index] = newProject;
    }
  }

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
                    )));
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get all projects of that user company id /api/project/company/{companyId}
  Future<List<ProjectCompany>> getProjectsData(int companyId) async {
    print('Get Projects Data');
    try {
      showDialog(context: context, builder: (context) => LoadingUI());

      var response =
          await ConnectionService().get('/api/project/company/$companyId', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        List<ProjectCompany> projects = [];
        for (var project in responseDecode['result']) {
          projects.add(ProjectCompany.fromMapProjectCompany(project));
        }
        projectList = projects;
        // Navigator.of(context).pop(); // Remove this line
        return projects;
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
