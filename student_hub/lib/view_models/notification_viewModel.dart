import 'dart:convert';

import 'package:student_hub/models/model/notification.dart';
import 'package:student_hub/services/connection_services.dart';

class NotifyViewModel {
  Future<List<Notify>> getAllNotifications(int userId) async {
    print('getAllNotifys');
    try {
      var response = await ConnectionService()
          .get('/api/notification/getByReceiverId/$userId', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        // print(response);
        List<Notify> notifications =
            Notify.fromMapListNotify(responseDecode['result']);
        return notifications;
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
