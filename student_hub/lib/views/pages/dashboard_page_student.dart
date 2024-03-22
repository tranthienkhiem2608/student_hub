import 'package:flutter/material.dart';
import 'package:student_hub/views/pages/all_projects_page.dart';
import 'package:student_hub/views/pages/all_projects_page_student.dart';
import 'package:student_hub/views/pages/archieved_page.dart';
import 'package:student_hub/views/pages/working_page.dart';
import 'package:student_hub/views/post_project/post_screen_1.dart';

class DashboardPageStudent extends StatelessWidget {
  const DashboardPageStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your projects',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              
            ],
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF69cde0),
            labelColor: Color(0xFF69cde0),
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'All Projects'),
              Tab(text: 'Working'),
              Tab(text: 'Archived'),
            ],
          ),
        ),
        body: const TabBarView(
            children: [
              AllProjectsPageStudent(),
              WorkingPage(),
              ArchivedPage()]),
      ),
    );
  }
}
