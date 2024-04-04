import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';

final String _baseUrl =
    Platform.isAndroid ? 'http://10.0.2.2:4400' : 'http://10.0.2.1:4400';
// final String _baseUrl = 'http://34.16.137.128';

class ConnectionService {
  var client = http.Client();

  //GET
  Future<dynamic> get(String api, Map<String, dynamic> json) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var _headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      print("Connect server successful");
      return response.body;
    } else {
      print("Connect server failed");
      return response.body;
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> post(String api, dynamic payload) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token: $token');
    var headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    var body = json.encode(payload);
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Connect server successful");
      return response.body;
    } else {
      print("Connect server failed");
      print(json.decode(response.body));
      return response.body;
    }
  }

  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(_baseUrl + api);
    var payload = json.encode(object);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    var response = await client.put(url, headers: headers, body: payload);
    if (response.statusCode == 200) {
      print("Connect server successful");
      return response.body;
    } else {
      print("Connect server failed");
      return response.body;
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    var response = await client.delete(url, headers: headers);
    if (response.statusCode == 200) {
      print("Connect server successful");
      return response.body;
    } else {
      print("Connect server failed");
      return response.body;
      //throw exception and catch it in UI
    }
  }
}
