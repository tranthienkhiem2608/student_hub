import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/components/loadingUI.dart';
import 'package:student_hub/models/model/education.dart';
import 'package:student_hub/models/model/experience.dart';
import 'package:student_hub/models/model/language.dart';
import 'package:student_hub/models/model/skillSets.dart';
import 'package:student_hub/models/model/student_user.dart';
import 'package:student_hub/models/model/techStack.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/views/auth/switch_account_view.dart';
import 'package:student_hub/views/profile_creation/company/profile_input.dart';
import 'package:student_hub/widgets/pop_up_education_widget.dart';
import 'package:student_hub/widgets/pop_up_project_widget.dart';
import 'package:student_hub/widgets/show_project_student_proposal.dart';
import 'package:student_hub/widgets/show_project_student_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:student_hub/widgets/show_school_widget.dart';
import 'package:student_hub/widgets/show_languages_widget.dart';
import 'package:student_hub/widgets/pop_up_languages_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../view_models/input_profile_viewModel.dart';
import '../../../widgets/pop_up_languages_edit_widget.dart';

class ProposalProfile extends StatefulWidget {
  final StudentUser? studentUser;
  final User user;
  const ProposalProfile(this.studentUser, this.user, {super.key});

  @override
  _ProposalProfileState createState() => _ProposalProfileState();
}

class _ProposalProfileState extends State<ProposalProfile> {
  bool isEditing = false;
  late TextfieldTagsController<String> _textfieldTagsController;
  late double _distanceToField;
  String _selectedTechStack = '';
  String _email = '';
  String _resume = '';
  String _transcript = '';
  final List<String> _selectedSkills = [];
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
    isEditing = false;
    _textfieldTagsController = TextfieldTagsController<String>();

    _selectedTechStack = widget.studentUser!.techStack!.name ?? '';
    _email = widget.studentUser!.email ?? '';
    _resume = widget.studentUser!.resumeLink ?? '';
    _transcript = widget.studentUser!.transcriptLink ?? '';
    _selectedTechStackId = widget.studentUser!.techStack!.id ?? 0;

    // Initialize _selectedSkills with user's existing skillset data
    _selectedSkills.addAll(
        widget.studentUser!.skillSet!.map((skill) => skill.name ?? '') ?? []);
    // You can also initialize _selectedSkillSet if needed
    _selectedSkillSet.addAll(widget.studentUser!.skillSet ?? []);
    // Other initialization code...

    educationList = widget.studentUser!.education ?? [];

    widget.studentUser!.education!.addAll([]);

    languages = widget.studentUser!.languages ?? [];

    widget.studentUser!.experience!.addAll([]);
  }

  void _addNewProject(String projectName, DateTime startMonth,
      DateTime endMonth, String description, List<SkillSets> skills) {
    setState(() {
      widget.studentUser!.experience?.add(Experience(
        id: widget.user.id!,
        title: projectName,
        startMonth: startMonth,
        endMonth: endMonth,
        description: description,
        skillSet: skills,
        duration: (widget.studentUser!.duration!.inHours / 24).round(),
      ));
    });
    // Add your logic here for handling the icon press
  }

  void _deleteProject(String projectName) {
    setState(() {
      widget.studentUser!.experience
          ?.removeWhere((project) => project.title == projectName);
    });
    // Add your logic here for handling the icon press
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

  void _launchURL(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        if (inApp) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  StudentUser? _studentProfiles;

  List<SkillSets> skillsSets = [];
  List<Language> languages = [
    // Add more languages here
  ];

  List<Education> educationList = [];
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: isDarkMode ? Colors.white : Color(0xFF242526),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Student Hub',
            style: GoogleFonts.poppins(
                // Apply the Poppins font
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 28, 28, 29) : Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Container(
              // Add a Container as the parent
              padding: const EdgeInsets.all(8.0), // Padding for spacing
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    isDarkMode ? Colors.white : Colors.black, BlendMode.srcIn),
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
                  '${widget.studentUser!.user}',
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
                  // Khoảng cách giữa chữ "Techstack" và thông tin
                  Expanded(
                    child: Text(
                      _email.isNotEmpty
                          ? _email // Hiển thị Techstack đã chọn
                          : "studentprofileinput4_ProfileEdit14"
                              .tr(), // Nếu không có Techstack được chọn
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: isDarkMode
                            ? Color.fromARGB(255, 200, 200, 200)
                            : Color.fromARGB(255, 126, 126, 126),
                        fontWeight: FontWeight
                            .normal, // or another weight like FontWeight.bold
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow
                          .ellipsis, // Đảm bảo văn bản không tràn ra ngoài
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "studentprofileinput4_ProfileEdit2".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
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
                          : "studentprofileinput4_ProfileEdit7"
                              .tr(), // Nếu không có Techstack được chọn
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: isDarkMode
                            ? Color.fromARGB(255, 200, 200, 200)
                            : Color.fromARGB(255, 126, 126, 126),
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow
                          .ellipsis, // Đảm bảo văn bản không tràn ra ngoài
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
                      "studentprofileinput4_ProfileEdit3".tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
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
                                  color: Color.fromARGB(255, 126, 126, 126),
                                ),
                              ),
                            ),
                          if (_selectedSkills.isEmpty)
                            Text(
                              "studentprofileinput4_ProfileEdit8"
                                  .tr(), // Hiển thị thông báo nếu không có Skillset nào được chọn
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: isDarkMode
                                    ? Color.fromARGB(255, 200, 200, 200)
                                    : Color.fromARGB(255, 126, 126, 126),
                              ),
                            ),
                        ],
                      ),
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
                      "studentprofileinput4_ProfileEdit9".tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          10), // Khoảng cách giữa chữ "Skillset" và danh sách các Skillset
                  Expanded(
                      child: _resume.isNotEmpty
                          ? () {
                              return TextButton(
                                onPressed: () => _launchURL(Uri.parse(_resume),
                                    false), // Mở liên kết trong ứng dụng
                                child: Text('View Resume'),
                              );
                            }()
                          : () {
                              return Text(
                                // Hiển thị Techstack đã chọn
                                "studentprofileinput4_ProfileEdit11"
                                    .tr(), // Nếu không có Techstack được chọn
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: isDarkMode
                                      ? Color.fromARGB(255, 200, 200, 200)
                                      : Color.fromARGB(255, 126, 126, 126),
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow
                                    .ellipsis, // Đảm bảo văn bản không tràn ra ngoài
                              );
                            }()),
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
                      "studentprofileinput4_ProfileEdit10".tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                      width:
                          10), // Khoảng cách giữa chữ "Skillset" và danh sách các Skillset
                  Expanded(
                      child: _transcript.isNotEmpty
                          ? () {
                              return TextButton(
                                onPressed: () => _launchURL(
                                    Uri.parse(_transcript),
                                    false), // Mở liên kết trong ứng dụng
                                child: Text('View Transcript'),
                              );
                            }()
                          : () {
                              return Text(
                                // Hiển thị Techstack đã chọn
                                "studentprofileinput4_ProfileEdit12"
                                    .tr(), // Nếu không có Techstack được chọn
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: isDarkMode
                                      ? Color.fromARGB(255, 200, 200, 200)
                                      : Color.fromARGB(255, 126, 126, 126),
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow
                                    .ellipsis, // Đảm bảo văn bản không tràn ra ngoài
                              );
                            }()),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "studentprofileinput4_ProfileEdit4".tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isEditing, // Hiển thị khi isEditing là true
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(210, 10, 0, 5),
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
                              244, 212, 221, 253), // Set border color
                          width: 2, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 70,
                      child: ShowLanguagesWidget(
                        languages: languages,
                        isEditing:
                            isEditing, // Truyền giá trị isEditing xuống ShowLanguagesWidget
                        deleteLanguage:
                            _deleteLanguage, // Truyền hàm _deleteLanguage xuống ShowLanguagesWidget
                      ),
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
                      "studentprofileinput4_ProfileEdit5".tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: isEditing, // Hiển thị khi isEditing là true
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(220, 10, 0, 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PopUpEducationEditWidget(_addNewEducation,
                                  _deleteEducation, " ", 0, 0);
                            },
                          );
                        },
                        icon: const Icon(Icons.add,
                            size: 26, color: Color(0xFF406AFF)),
                      ),
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
                          color: Color.fromARGB(244, 212, 221, 253),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 80,
                      child: ShowSchoolWidget(
                        educationList: educationList,
                        deleteSchool: _deleteEducation,
                        addNewEducation: _addNewEducation,
                        isEditing: isEditing,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "studentprofileinput4_ProfileEdit6".tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Visibility(
                    visible: isEditing, // Hiển thị khi isEditing là true
                    child: IconButton(
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 210,
                      child: ShowProjectStudentPropasalWidget(
                        userStudent: widget.studentUser!,
                        deleteProject: _deleteProject,
                        addNewProject: _addNewProject,
                        isEditing: isEditing,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final User? user;
  const _AppBar(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SwitchAccountView(user!, null)));
        },
      ),
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
