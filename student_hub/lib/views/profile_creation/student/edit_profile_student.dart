import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/experience.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/student_user.dart';
import 'package:student_hub/models/model/techStack.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/widgets/pop_up_edit_techstack.dart';
import 'package:student_hub/widgets/pop_up_education_widget.dart';
import 'package:student_hub/widgets/pop_up_project_widget.dart';
import 'package:student_hub/widgets/show_project_student_widget.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:student_hub/widgets/show_school_widget.dart';
import 'package:student_hub/widgets/show_languages_widget.dart';
import 'package:student_hub/widgets/pop_up_languages_widget.dart';

import '../../../view_models/input_profile_viewModel.dart';
import '../../../widgets/pop_up_languages_edit_widget.dart';

class EditProfileInputStudent extends StatefulWidget {
  final User user;
  const EditProfileInputStudent(this.user, {super.key});

  @override
  _EditProfileInputStudentState createState() =>
      _EditProfileInputStudentState();
}

class _EditProfileInputStudentState extends State<EditProfileInputStudent> {
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
  late TextfieldTagsController<String> _textfieldTagsController;
  late double _distanceToField;
  final List<String> _selectedSkills = [];
  String _selectedTechStack = '';
  final List<int> _selectedSkillsId = [];
  int _selectedTechStackId = 0;
  List<SkillSets> _selectedSkillSet = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
 void initState() {
    super.initState();
    _textfieldTagsController = TextfieldTagsController<String>();
    _selectedTechStack = widget.user.studentUser?.techStack?.name ?? '';
    _selectedSkills.addAll(
        widget.user.studentUser?.skillSet?.map((skill) => skill.name) ?? []);
    languages = widget.user.studentUser?.languages ?? [];
    educationList = widget.user.studentUser?.education ?? [];
    widget.user.studentUser?.experience?.addAll([]);
  }

  @override
  void dispose() {
    super.dispose();
    _textfieldTagsController.dispose();
  }

  void _addNewLanguage(String language, String level) {
    setState(() {
      print("ID: ${widget.user.id}, Language: $language, Level: $level");
      final Language newLanguage = Language(
        languageName: language,
        level: level,
      );
      languages.add(newLanguage);
    });
  }

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

  void _deleteLanguage(String language) {
    setState(() {
      languages.removeWhere((element) => element.languageName == language);
    });
  }

  void _addNewEducation(String schoolName, int yearsStart, int yearsEnd) {
    setState(() {
      print(
          "ID: ${widget.user.id}, School: $schoolName, Start: $yearsStart, End: $yearsEnd");
      final Education newEducation = Education(
        schoolName: schoolName,
        startYear: yearsStart,
        endYear: yearsEnd,
      );
      educationList.add(newEducation);
    });
  }

  void _deleteEducation(String schoolName) {
    setState(() {
      educationList.removeWhere((element) => element.schoolName == schoolName);
    });
  }

  void _editLanguage(List<Map<String, dynamic>> listLanguagesDelete) {
    for (var i = 0; i < listLanguagesDelete.length; i++) {
      print(listLanguagesDelete[i]);
      if (languages.contains(listLanguagesDelete[i])) {
        setState(() {
          languages.removeWhere((element) => element == listLanguagesDelete[i]);
        });
      }
    }
  }

  List<Language> languages = [
    // Add more languages here
  ];

  List<Education> educationList = [
    // Add more education items here
  ];
  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Your profile',
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF406AFF)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Techstack: ",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                      width:
                          10), // Khoảng cách giữa chữ "Techstack" và thông tin
                  Expanded(
                    child: Text(
                      _selectedTechStack.isNotEmpty
                          ? _selectedTechStack // Hiển thị Techstack đã chọn
                          : "No Techstack selected", // Nếu không có Techstack được chọn
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow
                          .ellipsis, // Đảm bảo văn bản không tràn ra ngoài
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopUpTechstackEditWidget(
                              _deleteLanguage, languages);
                        },
                      );
                    },
                    icon: Image.asset(
                      'assets/icons/edit.jpg', // Đường dẫn đến hình ảnh edit.jpg
                      width: 20, // Kích thước của hình ảnh
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Skillset: ",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          10), // Khoảng cách giữa chữ "Skillset" và danh sách các Skillset
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var skill in _selectedSkills)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                skill, // Hiển thị tên của Skillset đã chọn
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          if (_selectedSkills.isEmpty)
                            Text(
                              "No Skillset selected", // Hiển thị thông báo nếu không có Skillset nào được chọn
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return PopUpLanguagesEditWidget(
                      //         _deleteLanguage, languages);
                      //   },
                      // );
                    },
                    icon: Image.asset(
                      'assets/icons/edit.jpg', // Đường dẫn đến hình ảnh edit.jpg
                      width: 20, // Kích thước của hình ảnh
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Languages",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(160, 10, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        final result = await showDialog<Language>(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUpLanguagesWidget(
                                _addNewLanguage, languages);
                          },
                        );

                        if (result != null) {
                          setState(() {
                            languages.add(result);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 26,
                        color: Color(0xFF406AFF),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUpLanguagesEditWidget(
                            _deleteLanguage, languages);
                      },
                    );
                  },
                  icon: Image.asset(
                    'assets/icons/edit.jpg', // Đường dẫn đến hình ảnh edit.jpg
                    width: 20, // Kích thước của hình ảnh
                    height: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(
                              255, 190, 190, 192), // Set border color
                          width: 1, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: ShowLanguagesWidget(languages: languages),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Education",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(220, 10, 0, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUpEducationEditWidget(
                                _addNewEducation, _deleteEducation, " ", 0, 0);
                          },
                        );
                      },
                      icon: const Icon(Icons.add,
                          size: 26, color: Color(0xFF406AFF)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(
                              255, 190, 190, 192), // Set border color
                          width: 1, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 80,
                      child: ShowSchoolWidget(
                          educationList: educationList,
                          deleteSchool: _deleteEducation,
                          addNewEducation: _addNewEducation),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Projects",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
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
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           height: 200,
            //           child: ShowProjectStudentWidget(
            //               userStudent: widget.user.studentUser!,
            //               deleteProject: _deleteProject,
            //               addNewProject: _addNewProject),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FadeTransition(
                  opacity: const AlwaysStoppedAnimation(1),
                  child: MaterialButton(
                    onPressed: () {
                      print(
                          "Techstack: $_selectedTechStackId - $_selectedTechStack");
                      for (var i = 0; i < _selectedSkills.length; i++) {
                        print(
                            "SkillSet: ${_selectedSkillSet[i].id} - ${_selectedSkillSet[i].name}");
                      }
                      for (var i = 0; i < languages.length; i++) {
                        print(
                            "Language: ${languages[i].languageName} - ${languages[i].level}");
                      }

                      if (_selectedTechStackId != 0 &&
                          _selectedSkillsId.isNotEmpty) {
                        widget.user.studentUser = StudentUser(
                          id: widget.user.id!,
                          userId: widget.user.id!,
                          techStackId: _selectedTechStackId,
                          skillSet: _selectedSkillSet ?? [],
                          languages: languages ?? [],
                          education: educationList ?? [],
                          experience: [],
                        );
                        ControllerRoute(context)
                            .navigateToProfileInputStudent2(widget.user);
                      } else {
                        //show dialog to choose techstack and skillset
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: _selectedSkillsId.isEmpty
                                      ? const Text('Skillset is empty')
                                      : const Text('Techstack is empty'),
                                  content: _selectedSkillsId.isEmpty
                                      ? const Text(
                                          'Please choose at least one skillset')
                                      : const Text('Please choose a techstack'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      }
                      // ControllerRoute(context)
                      //     .navigateToProfileInputStudent2(widget.user);
                    },
                    height: 45,
                    color: Color(0xFF406AFF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      "Next",
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

Widget _customItemBuilder(
    BuildContext context, TechStack item, bool isSelected) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
      child: Column(
        children: [
          Text(
            item.name,
            style: TextStyle(
              color: isSelected ? Color(0xFF406AFF) : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Divider(
            color: Color(0xFF777B8A),
            thickness: 0.2,
          ),
        ],
      ));
}

Widget _customLoadingBuilder(BuildContext context, String item) {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
    ),
  );
}

Future<List<TechStack>> getData(BuildContext context, String? filter) async {
  List<TechStack> skillsTechList =
      await InputProfileViewModel(context).getTechStack();

  await Future.delayed(const Duration(milliseconds: 200));
  if (filter!.isNotEmpty) {
    return skillsTechList
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  return skillsTechList;
}

Future<List<SkillSets>> getDataSkillSet(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 200));
  List<SkillSets> skillsList =
      await InputProfileViewModel(context).getSkillSets();

  return skillsList;
}
