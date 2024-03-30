import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';
const String _baseUrl = 'http://10.0.2.2:4400';
class ConnectionService {

  var client = http.Client();

  //check server
  Future<void> checkServerConnection() async {
    var url = Uri.parse(_baseUrl + '/auth/sign-in');
    var response = await http.Client().get(url);
    if (response.statusCode == 201) {
      print("Connected to the server successfully");
    } else {
      print("Failed to connect to the server");
    }
  }

  //GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var _headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

Future<dynamic> post(String api, dynamic payload) async {
  var url = Uri.parse(_baseUrl + api);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
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
    return json.decode(response.body);
  } else if (response.statusCode == 400) {
    print('Server returned status code 400. Error message: ${response.body}');
    throw Exception('Bad request');
  } else {
    print("Connect server failed");
    throw Exception('Failed to connect to server');
  }
}

Future<dynamic> put(String api, dynamic object) async{
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
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
}

Future<dynamic> delete(String api) async{
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
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
}
}