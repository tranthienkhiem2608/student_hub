import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';

class AddAccountWidget extends StatefulWidget {
  User user;
  AddAccountWidget(this.user, {super.key});
  @override
  State<AddAccountWidget> createState() => _AddAccountWidgetState();
}

class _AddAccountWidgetState extends State<AddAccountWidget> {
  late SharedPreferences prefs;
  int? role;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    role = prefs.getInt('role');
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380, // Set the width you want
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), // Set the radius you want
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFdce8e8), // Set the background color you want
          ),
          onPressed: () {
        Navigator.of(context).pop();
        if(widget.user.studentUser == null && widget.user.companyUser == null) {
          role == 0 ? ControllerRoute(context).navigateToProfileInputStudent1(widget.user) : ControllerRoute(context).navigateToProfileInputCompany(widget.user);
        }
        else {
          widget.user.studentUser != null ? ControllerRoute(context).navigateToProfileInputCompany(widget.user) : ControllerRoute(context).navigateToProfileInputStudent1(widget.user);
          }
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add, size: 34, color: Colors.black),
              SizedBox(width: 10),
              Text('Add new account', style: TextStyle(fontSize: 21, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}