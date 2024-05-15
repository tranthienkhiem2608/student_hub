import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/experience.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/widgets/show_project_student_widget.dart';

import '../../../models/model/users.dart';
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "studentprofileinput1_ProfileCreation6".tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF406AFF),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
              child: Text(
                "settingscreen_ProfileCreation10".tr(),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Color.fromARGB(255, 90, 93, 104),
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Projects",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
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
                        size: 26, color: Color(0xFF406AFF)),
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
                          addNewProject: _addNewProject, isEditing: true,),
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
                      ControllerRoute(context)
                          .navigateToProfileInputStudent3(widget.user);
                    },
                    height: 45,
                    color: Color(0xFF406AFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "companyprofileinput_ProfileCreation12".tr(),
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
