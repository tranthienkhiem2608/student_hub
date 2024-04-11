import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/experience.dart';
import 'package:student_hub/models/model/file_cv.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/techStack.dart';
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
    print(studentUser.studentUser?.techStack?.id);
    var payload = {
      "techStackId": studentUser.studentUser?.techStackId,
      "skillSets": studentUser.studentUser?.skillSet?.map((e) => e.id).toList(),
    };
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var response =
          await ConnectionService().post('/api/profile/student', payload);
      var responseUserMap = jsonDecode(response);
      if (responseUserMap['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
        if (studentUser.studentUser?.languages != null) {
          await putLanguage(responseUserMap['result']['id'],
              studentUser.studentUser!.languages!);
        }
        if (studentUser.studentUser?.education != null) {
          await putEducation(responseUserMap['result']['id'],
              studentUser.studentUser!.education!);
        }
        if (studentUser.studentUser?.experience != null) {
          await putExperience(responseUserMap['result']['id'],
              studentUser.studentUser!.experience!);
        }
        if (studentUser.studentUser?.file?.resume != null &&
            studentUser.studentUser?.file?.transcript != null) {
          await putFileCv(
              responseUserMap['result']['id'], studentUser.studentUser!.file!);
        }
        Navigator.of(context).pop();
        ControllerRoute(context).navigateToHomeScreen(true, studentUser);
      } else {
        print("Failed");
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<TechStack>> getTechStack() async {
    print('Get Tech Stack');
    try {
      var response =
          await ConnectionService().get('/api/techstack/getAllTechStack', {});
      if (response != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
        var responseList = jsonDecode(response);
        if (responseList['result'] != null) {
          List<TechStack> techStackList =
              TechStack.fromMapListTechStack(responseList['result']);

          return techStackList;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<SkillSets>> getSkillSets() async {
    print('Get Skill Sets');
    try {
      var response =
          await ConnectionService().get('/api/skillset/getAllSkillSet', {});
      if (response != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
        var responseList = jsonDecode(response);
        if (responseList['result'] != null) {
          List<SkillSets> skillSetsList =
              SkillSets.fromMapListSkillSets(responseList['result']);

          return skillSetsList;
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> putLanguage(int studentId, List<Language> languageList) async {
    print('Put Language');
    String url = '/api/language/updateByStudentId/$studentId';
    var languageMap = languageList.map((e) => e.toMapLanguage()).toList();
    try {
      showDialog(context: context, builder: (context) => LoadingUI());

      var payload = {
        "languages": languageList
            .map((language) => {
                  "id": null,
                  "languageName": language.languageName,
                  "level": language.level,
                })
            .toList(),
      };
      var response = await ConnectionService().put(url, payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> putEducation(
      int studentId, List<Education> educationList) async {
    print('Put Education');
    String url = '/api/education/updateByStudentId/$studentId';
    //convert the list of education to a map
    var educationMap = educationList.map((e) => e.toMapEducation()).toList();
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var payload = {
        "education": educationList
            .map((education) => {
                  "id": null,
                  "schoolName": education.schoolName,
                  "startYear": education.startYear,
                  "endYear": education.endYear,
                })
            .toList(),
      };
      var response = await ConnectionService().put(url, payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Experience>> putExperience(
      int studrntId, List<Experience> experienceList) async {
    print('Put Experience');
    String url = '/api/experience/updateByStudentId/$studrntId';
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      var payload = {
        "experience": experienceList
            .map((experience) => {
                  "id": null,
                  "title": experience.title,
                  "startMonth": DateFormat('MM-yyyy')
                      .format(DateTime.parse(experience.startMonth.toString())),
                  "endMonth": DateFormat('MM-yyyy')
                      .format(DateTime.parse(experience.endMonth.toString())),
                  "description": experience.description,
                  "skillSets": experience.skillSet
                      ?.map((e) => e.id)
                      .toList(), //convert to list of id
                })
            .toList(),
      };

      var response = await ConnectionService().put(url, payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        // Call a method to reload the page
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<FileCV> putFileCv(int studentId, FileCV fileCV) async {
    print('Put File CV');
    // String url = '/api/filecv/updateByStudentId/$studentId';
    String url = '/api/profile/student';
    try {
      showDialog(context: context, builder: (context) => LoadingUI());
      // var payload = fileCV.toMapFileCV();
      if (fileCV.resume != null) {
        String urlResume = '$url/resume/$studentId';
        var response = await ConnectionService().put(urlResume, fileCV.resume);
        var responseDecode = jsonDecode(response);
        if (responseDecode['result'] != null) {
          print("Connected to the server successfully");
          print("Resume: Connect server successful");
          print(response);
          // Call a method to reload the page
        } else {
          print("Failed upload file resume");
          print(responseDecode);
        }
      }
      if (fileCV.transcript != null) {
        String urlTranscript = '$url/transcript/$studentId';
        var response =
            await ConnectionService().put(urlTranscript, fileCV.transcript);
        var responseDecode = jsonDecode(response);
        if (responseDecode['result'] != null) {
          print("Connected to the server successfully");
          print("Transcript: Connect server successful");
          print(response);
          // Call a method to reload the page
        } else {
          print("Failed upload file transcript");
          print(responseDecode);
        }
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
    return FileCV();
  }
}
