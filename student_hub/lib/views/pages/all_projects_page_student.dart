import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/project_company.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';

import '../../models/project_student.dart';
import '../../models/student_registered.dart';
import '../../models/user.dart'; // Import the ShowProjectCompanyWidget

class AllProjectsPageStudent extends StatefulWidget {
  const AllProjectsPageStudent({super.key});
  @override
  _AllProjectsPageStudentState createState() => _AllProjectsPageStudentState();
}

class _AllProjectsPageStudentState extends State<AllProjectsPageStudent>
    with WidgetsBindingObserver {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.page == _pageController.initialPage) {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'Senior frontend developer (Fintech)',
      'Senior backend developer (Fintech)',
      'Fresher fullstack developer'
    ];
    final List<DateTime> listTime = <DateTime>[
      DateTime.now(),
      DateTime.now(),
      DateTime.now()
    ];
    const String username = "John";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Text(
            "Active Proposal (0)",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          // Thêm Expanded ở đây
          child: Visibility(
            replacement: const Center(
              child: Text("\t\tWelcome, $username \nYou no have jobs"),
            ),
            visible: entries.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 0)),
                  Expanded(
                    child: ListView.separated(
                      itemCount: entries.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          // Handle your tap here.
                          ProjectCompany projectCompany = ProjectCompany(
                            projectName: entries[index],
                            creationTime: listTime[index],
                            studentRequired: 3,
                            duration: "3 to 6",
                            description:
                                'Clear expectations about your project or deliverables\n The skills required for your project \n Details about your project',
                            studentRegistered: [
                              StudentRegistered(
                                student: StudentUser(
                                  user: User(
                                    fullName: 'Truong Le',
                                    email: '223mnd@gmail.com',
                                    password: 'password123',
                                    typeUser: 'student',
                                  ),
                                  techStack: 'Frontend engineer',
                                  skillsList: ['HTML', 'CSS', 'JS'],
                                  languagesList: [
                                    {
                                      'name': 'English',
                                      'level': 'Intermediate'
                                    },
                                    {'name': 'Vietnamese', 'level': 'Native'},
                                  ],
                                  educationList: [
                                    {
                                      'school': 'University of Florida',
                                      'degree':
                                          'Bachelor of Science in Computer Science',
                                      'graduationDate': '2023-05-01',
                                    },
                                  ],
                                  projectsList: [
                                    ProjectStudent(
                                      projectName: 'Project 1',
                                      projectDescription:
                                          'This is a project 1 description',
                                      timeStart: DateTime.parse('2021-10-01'),
                                      timeEnd: DateTime.parse('2021-10-01'),
                                      skillsListProject: [
                                        'HTML',
                                        'CSS',
                                        'JS',
                                      ],
                                    ),
                                  ],
                                ),
                                levelStudent: 'Excellent',
                                introductionStudent: 'I am a student at HCMUT',
                                statusStudent: 'Hire',
                                isMessage: false,
                              ),
                              StudentRegistered(
                                student: StudentUser(
                                  user: User(
                                    fullName: 'Hung Tran',
                                    email: '232fs@gmail.com',
                                    password: 'password123',
                                    typeUser: 'student',
                                  ),
                                  techStack: 'Backend engineer',
                                  skillsList: ['Java', 'Python', 'C++'],
                                  languagesList: [
                                    {
                                      'name': 'English',
                                      'level': 'Intermediate'
                                    },
                                    {'name': 'Vietnamese', 'level': 'Native'},
                                  ],
                                  educationList: [
                                    {
                                      'school': 'University of Florida',
                                      'degree':
                                          'Bachelor of Science in Computer Science',
                                      'graduationDate': '2023-05-01',
                                    },
                                  ],
                                  projectsList: [
                                    ProjectStudent(
                                      projectName: 'Project 1',
                                      projectDescription:
                                          'This is a project 1 description',
                                      timeStart: DateTime.parse('2021-10-23'),
                                      timeEnd: DateTime.parse('2021-12-01'),
                                      skillsListProject: [
                                        'Java',
                                        'Python',
                                        'C++',
                                      ],
                                    ),
                                  ],
                                ),
                                levelStudent: "Good",
                                introductionStudent: "I am a student at HCMUT",
                                statusStudent: "Send hire offer",
                                isMessage: false,
                              ),
                              StudentRegistered(
                                student: StudentUser(
                                  user: User(
                                    fullName: 'Quan Nguyen',
                                    email: '1m23n@gmail.com',
                                    password: 'password',
                                    typeUser: 'student',
                                  ),
                                  techStack: 'Fullstack',
                                  skillsList: [
                                    'HTML',
                                    'CSS',
                                    'JS',
                                    'Java',
                                    'Python',
                                    'C++'
                                  ],
                                  languagesList: [
                                    {
                                      'name': 'English',
                                      'level': 'Intermediate'
                                    },
                                    {'name': 'Vietnamese', 'level': 'Native'},
                                  ],
                                  educationList: [
                                    {
                                      'school': 'University of Florida',
                                      'degree':
                                          'Bachelor of Science in Computer Science',
                                      'graduationDate': '2023-05-01',
                                    },
                                  ],
                                  projectsList: [
                                    ProjectStudent(
                                      projectName: 'Project 1',
                                      projectDescription:
                                          'This is a project 1 description',
                                      timeStart: DateTime.parse('2021-10-23'),
                                      timeEnd: DateTime.parse('2021-12-01'),
                                      skillsListProject: [
                                        'HTML',
                                        'CSS',
                                        'JS',
                                        'Java',
                                        'Python',
                                        'C++',
                                      ],
                                    ),
                                  ],
                                ),
                                levelStudent: 'Good',
                                introductionStudent: 'I am a student at HCMUT',
                                statusStudent: 'Send hire offer',
                                isMessage: false,
                              ),
                            ],
                          );
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HireStudentScreen(
                                projectCompany: projectCompany,
                              ),
                            ),
                          );

                          print('Item at index $index was tapped.');
                        },
                        child: ShowProjectCompanyWidget(
                          id: index,
                          projectName: '${entries[index]}',
                          creationTime: listTime[index],
                          description:
                              'Clear expectations about your project or deliverables\n The skills required for your project \n Details about your project',
                          quantities: [],
                          labels: [],
                          showOptionsIcon: false,
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
