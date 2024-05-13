import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            backgroundColor:
                Color(0xFF4DBE3FF), // Set the background color you want
          ),
          onPressed: () {
            prefs.setInt('role', role == 0 ? 1 : 0);
            Navigator.of(context).pop();
            if (widget.user.studentUser == null &&
                widget.user.companyUser == null) {
              role == 0
                  ? ControllerRoute(context)
                      .navigateToProfileInputStudent1(widget.user)
                  : ControllerRoute(context)
                      .navigateToProfileInputCompany(widget.user);
            } else {
              widget.user.studentUser != null
                  ? ControllerRoute(context)
                      .navigateToProfileInputCompany(widget.user)
                  : ControllerRoute(context)
                      .navigateToProfileInputStudent1(widget.user);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add, size: 34, color: Color(0xFF406AFF)),
              SizedBox(width: 10),
              Text('add_account1'.tr(),
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Color(0xFF406AFF), fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
