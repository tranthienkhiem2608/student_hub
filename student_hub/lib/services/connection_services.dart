import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';
const String _baseUrl = 'http://localhost:4400';
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
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

Future<dynamic> post(String api, dynamic object) async{
var url = Uri.parse(_baseUrl + api);
var payload = json.encode(object);
    var headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    var response = await http.Client().post(url, headers: headers, body: payload);
    if (response.statusCode == 201) {
      print("Connect server successful");
      return response.body;
    } else {
      print("Connect server failed");
      //throw exception and catch it in UI
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