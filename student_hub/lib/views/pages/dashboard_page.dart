import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/pages/all_projects_page.dart';
import 'package:student_hub/views/pages/archieved_page.dart';
import 'package:student_hub/views/pages/working_page.dart';
import 'package:student_hub/views/post_project/post_screen_1.dart';

import '../../models/model/company_user.dart';
import '../../models/model/student_user.dart';
import 'all_projects_page_student.dart';

class DashboardPage extends StatefulWidget {
  final User user;

  const DashboardPage(this.user, {super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? role; // Keep the role variable

  Future<int?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role');
  }

  @override
  void initState() {
    super.initState();
    _initializeRole();
  }

  Future<void> _initializeRole() async {
    int? role = await getRole();
    setState(() {
      this.role = role;
    });
  }

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
                role == 0 ? 'Your Projects' : 'Your Jobs',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              role == 0
                  ? Container() // Empty container (or any other widget you want to show when the button should be hidden)
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF69cde0)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostScreen1()),
                        );
                      },
                      child: const Text('Post a Job',
                          style: TextStyle(color: Colors.black)),
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
        body: TabBarView(children: [
          role == 0 ? AllProjectsPageStudent() : AllProjectsPage(),
          WorkingPage(),
          ArchivedPage()
        ]),
      ),
    );
  }
}

// SharedPreferences getPrefs(){
//   return SharedPreferences.getInstance() as SharedPreferences;
// }