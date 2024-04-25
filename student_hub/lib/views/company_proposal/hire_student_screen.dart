// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/project_detail/detail_page.dart';
import 'package:student_hub/views/pages/project_detail/hired_page.dart';
import 'package:student_hub/views/pages/project_detail/proposals_page.dart';

import '../../models/student_registered.dart';

class HireStudentScreen extends StatefulWidget {
  final ProjectCompany projectCompany;

  const HireStudentScreen({super.key, required this.projectCompany});
  @override
  _HireStudentScreenState createState() => _HireStudentScreenState();
}

class _HireStudentScreenState extends State<HireStudentScreen> {
  List<StudentRegistered> hiredStudents = []; // để tạm thời

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: _AppBar(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 5, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.projectCompany.title!,
                  style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF406AFF)),
                ),
              ),
            ),
            TabBar(
              indicatorColor: Color(0xFF406AFF),
              labelColor: Color(0xFF406AFF),
              labelStyle: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Proposals'),
                Tab(text: 'Details'),
                Tab(text: 'Messages'),
                Tab(text: 'Hired'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProposalsPage(projectCompany: widget.projectCompany),
                  DetailPage(projectCompany: widget.projectCompany),
                  MessagePage(),
                  HiredPage(
                    projectCompany: widget.projectCompany,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Student Hub',
          style: GoogleFonts.poppins(
              // Apply the Poppins font
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      actions: <Widget>[
        IconButton(
          icon: Container(
            // Add a Container as the parent
            padding: const EdgeInsets.all(8.0), // Padding for spacing
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: BoxShape.circle,
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
              child: Image.asset('assets/icons/user_ic.png',
                  width: 25, height: 25),
            ),
          ),
          onPressed: () {},
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
