import 'dart:convert';

import 'package:student_hub/models/model/interview.dart';
import 'package:student_hub/services/connection_services.dart';

class InterviewViewModel {
  Future<void> postScheduleInterviews(Interview interview) async {
    print('postScheduleInterviews');
    var payload = interview.toMapInterview();
    print(payload);
    try {
      var response = await ConnectionService().post('/api/interview', payload);
      print(response);
      var responseDecode = jsonDecode(response);
      if (responseDecode != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateScheduleInterviews(Interview interview) async {
    print('updateScheduleInterviews');
    var payload = interview.toMapInterviewUpdate();
    print(payload);
    try {
      var response = await ConnectionService()
          .patch('/api/interview/${interview.id}', payload);
      print(response);
      var responseDecode = jsonDecode(response);
      if (responseDecode != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> disableInterview(Interview interview) async {
    print('disableInterview');
    try {
      var response = await ConnectionService()
          .patch('/api/interview/${interview.id}/disable', {});
      print(response);
      var responseDecode = jsonDecode(response);
      if (responseDecode != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }
}
