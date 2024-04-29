import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_hub/models/model/message.dart';
import 'package:student_hub/services/connection_services.dart';

class MessagesViewModel {
  Future<List<Message>> getMessagesByProject(int projectId) async {
    print('getMessagesByProject');
    try {
      var response =
          await ConnectionService().get('/api/message/$projectId', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        List<Message> messages =
            Message.formListMapMessage(responseDecode['result']);
        return messages;
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Message>> getAllOldMessages(int projectId, int receiverId) async {
    print('getAllOldMessages');
    try {
      var response = await ConnectionService()
          .get('/api/message/$projectId/user/$receiverId', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        List<Message> messages =
            Message.formListMapMessage(responseDecode['result']);
        return messages;
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Message>> getLastMessage() async {
    print('getLastMessage');
    try {
      var response = await ConnectionService().get('/api/message', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        List<Message> messages =
            Message.formListMapLastMessage(responseDecode['result']);
        return messages;
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
