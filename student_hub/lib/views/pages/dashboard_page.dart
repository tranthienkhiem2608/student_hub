import 'package:flutter/material.dart';
import 'package:student_hub/views/pages/all_projects_page.dart';
import 'package:student_hub/views/pages/archieved_page.dart';
import 'package:student_hub/views/pages/working_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Jobs', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF69cde0)),
                ),
                onPressed: () {
                  // Handle button press
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
        body: const TabBarView(
            children: [AllProjectsPage(), WorkingPage(), ArchivedPage()]),
      ),
    );
  }
}