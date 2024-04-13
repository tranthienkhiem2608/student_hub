// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/pages/message_page.dart';
import 'package:student_hub/views/pages/project_detail/detail_page.dart';
import 'package:student_hub/views/pages/project_detail/hired_page.dart';
import 'package:student_hub/views/pages/project_detail/message_page.dart';
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
              padding: EdgeInsets.fromLTRB(25, 5, 5, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.projectCompany.title!,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ),
            const TabBar(
              indicatorColor: Color(0xFF69cde0),
              labelColor: Color(0xFF69cde0),
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
                    hiredStudents: hiredStudents,
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
      title: const Text('Student Hub',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('assets/icons/user_ic.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
