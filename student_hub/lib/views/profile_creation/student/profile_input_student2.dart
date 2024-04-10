import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/models/model/experience.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/input_profile_viewModel.dart';
import 'package:student_hub/widgets/show_project_student_widget.dart';

import '../../../models/model/users.dart';
import '../../../models/project_student.dart';
import '../../../widgets/pop_up_project_widget.dart';

class ProfileInputStudent2 extends StatefulWidget {
  final User user;
  const ProfileInputStudent2(this.user, {super.key});

  @override
  _ProfileInputStudent2State createState() => _ProfileInputStudent2State();
}

class _ProfileInputStudent2State extends State<ProfileInputStudent2> {
  final List<String> skills = [
    'Flutter',
    'Dart',
    'Java',
    'Kotlin',
    'Python',
    'C++',
    'C#',
    'Swift',
    'React',
    'Angular',
    'Vue',
    'Node.js',
    'Express.js',
    'MongoDB',
    'Firebase',
  ];
  List<SkillSets> skillsSets = [];

  void _addNewProject(String projectName, DateTime startMonth,
      DateTime endMonth, String description, List<SkillSets> skills) {
    setState(() {
      widget.user.studentUser?.experience?.add(Experience(
        id: widget.user.id!,
        title: projectName,
        startMonth: startMonth,
        endMonth: endMonth,
        description: description,
        skillSet: skills,
        duration: (widget.user.studentUser!.duration!.inHours / 24).round(),
      ));
    });
    // Add your logic here for handling the icon press
  }

  void _deleteProject(String projectName) {
    setState(() {
      widget.user.studentUser?.experience
          ?.removeWhere((project) => project.title == projectName);
    });
    // Add your logic here for handling the icon press
  }

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final selectedSkills = <String>[];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Student Hub',
            style: TextStyle(
                color: Colors.blueAccent,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Experiences",
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Text(
                "Tell us about your self and you will be on your way connect with real-world project",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Projects",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopUpProjectWidget(_addNewProject,
                              _deleteProject, '', null, null, '', const []);
                        },
                      );
                    },
                    icon: const Icon(Icons.add,
                        size: 26, color: Colors.lightBlue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: ShowProjectStudentWidget(
                          userStudent: widget.user.studentUser!,
                          deleteProject: _deleteProject,
                          addNewProject: _addNewProject),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FadeTransition(
                  opacity: const AlwaysStoppedAnimation(1),
                  child: MaterialButton(
                    onPressed: () {
                      widget.user.studentUser?.experience =
                          widget.user.studentUser?.experience ?? [];
                      print(widget.user.studentUser?.experience![0].title);
                      print(
                          widget.user.studentUser?.experience![0].description);
                      print(widget.user.studentUser?.experience![0].skillSet);
                      print(DateFormat('MM-yyyy').format(DateTime.parse(widget
                          .user.studentUser!.experience![0].startMonth
                          .toString())));
                      print(DateFormat('MM-yyyy').format(DateTime.parse(widget
                          .user.studentUser!.experience![0].endMonth
                          .toString())));
                      InputProfileViewModel(context)
                          .inputProfileStudent(widget.user);
                    },
                    height: 45,
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
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
      automaticallyImplyLeading: false,
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.blueAccent,
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
