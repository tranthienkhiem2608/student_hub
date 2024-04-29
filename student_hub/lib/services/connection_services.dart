// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

// final String _baseUrl =
//     Platform.isAndroid ? 'http://10.0.2.2:4400' : 'http://localhost:4400';

const String _baseUrl = 'https://api.studenthub.dev';
// _baseUrl for local server

class ConnectionService {
  var client = http.Client();
  var multiPart = http.MultipartRequest('PUT', Uri.parse(_baseUrl));

  //GET
  Future<dynamic> get(String api, Map<String, dynamic> json) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var _headers = {
      'accept': '*/*',
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
      'accept': '*/*', // 'application/json
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

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

  Future<dynamic> postAuth(String api, dynamic payload) async {
    try {
      var url = Uri.parse(_baseUrl + api);
      print(url);
      var headers = {
        'accept': '*/*', // 'application/json
        'Content-Type': 'application/json',
      };

      var body = json.encode(payload);
      print(body);
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Connect server successful");
        return response.body;
      } else {
        print("Connect server failed");
        print(json.decode(response.body));
        return response.body;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<dynamic> postLogout(String api) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token: $token');
    var _headers = {
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(url, headers: _headers);
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

  Future<dynamic> patch(String api, dynamic object) async {
    var url = Uri.parse(_baseUrl + api);
    var payload = json.encode(object);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var response = await client.patch(url, headers: headers, body: payload);
    if (response.statusCode == 200) {
      print("Connect server successful");
      return response.body;
    } else {
      print("Connect server failed");
      return response.body;
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> putFile(String api, String filePath) async {
    var url = Uri.parse(_baseUrl + api);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Authorization': 'Bearer $token',
      'accept': '*/*', // 'application/json
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest('PUT', url);
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("Connect server successful");
      try {
        return response.body;
      } catch (e) {
        print('Error parsing JSON: $e');
        return response.body;
      }
    } else {
      print("Connect server failed");
      try {
        return response.body;
      } catch (e) {
        print('Error parsing JSON: $e');
        return response.body;
      }
    }
  }
}
