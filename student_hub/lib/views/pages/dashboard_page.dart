import 'package:flutter/material.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/views/pages/all_projects_page.dart';
import 'package:student_hub/views/pages/archieved_page.dart';
import 'package:student_hub/views/pages/working_page.dart';
import 'package:student_hub/views/post_project/post_screen_1.dart';

import '../../models/company_user.dart';
import '../../models/student_user.dart';
import 'all_projects_page_student.dart';

class DashboardPage extends StatelessWidget {
  final StudentUser? studentUser;
  final CompanyUser? companyUser;
  DashboardPage(this.studentUser, this.companyUser, {super.key});

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
              Text(
                studentUser != null ? 'Your Projects' : 'Your Jobs',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              studentUser != null
                  ? Container() // Empty container (or any other widget you want to show when the button should be hidden)
                  : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF69cde0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostScreen1()),
                  );
                },
                child: const Text('Post a Job', style: TextStyle(color: Colors.black)),
              ),
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
        body: TabBarView(
            children: [
              studentUser != null ? AllProjectsPageStudent() : AllProjectsPage(),
              WorkingPage(),
              ArchivedPage()]),
      ),
    );
  }
}