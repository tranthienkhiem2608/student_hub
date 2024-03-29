import 'package:flutter/material.dart';
import 'package:student_hub/models/project_company.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';

import '../../models/project_student.dart';
import '../../models/student_registered.dart';
import '../../models/user.dart'; // Import the ShowProjectCompanyWidget

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({super.key});
  @override
  _AllProjectsPageState createState() => _AllProjectsPageState();
}
class _AllProjectsPageState extends State<AllProjectsPage> with WidgetsBindingObserver {


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
    if (_pageController.page == _pageController.initialPage) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Senior frontend developer (Fintech)','Senior backend developer (Fintech)','Fresher fullstack developer'];
    final List<DateTime> listTime = <DateTime>[DateTime.now(), DateTime.now(), DateTime.now()];
    const String username = "John";
    return Visibility(
      replacement: const Center(
      child: Text("\t\tWelcome, $username \nYou no have jobs"),
    ),
    visible: entries.isNotEmpty,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Expanded(
          child: ListView.separated(
            itemCount: entries.length,
            itemBuilder: (context, index)=> GestureDetector(
              onTap: () {
                // Handle your tap here.
                ProjectCompany projectCompany = ProjectCompany(
                  projectName: entries[index],
                  creationTime: listTime[index],
                  studentRequired: 3,
                  duration: "3 to 6",
                  description:  'Clear expectations about your project or deliverables\n The skills required for your project \n Details about your project',
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
                          {'name': 'English', 'level': 'Intermediate'},
                          {'name': 'Vietnamese', 'level': 'Native'},
                        ],
                        educationList: [
                          {
                            'school': 'University of Florida',
                            'yearsStart': 2010,
                            'yearsEnd': 2015
                          },
                        ],
                        projectsList: [
                          ProjectStudent(
                            projectName: 'Project 1',
                            projectDescription: 'This is a project 1 description',
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
                introductionStudent:'I am a student at HCMUT',
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
                        {'name': 'English', 'level': 'Intermediate'},
                        {'name': 'Vietnamese', 'level': 'Native'},
                      ],
                      educationList: [
                        {
                          'school': 'University of Florida',
                          'yearsStart': 2020,
                          'yearsEnd': 2024
                        },
                      ],
                      projectsList: [
                        ProjectStudent(
                          projectName: 'Project 1',
                          projectDescription: 'This is a project 1 description',
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
                          skillsList: ['HTML', 'CSS', 'JS', 'Java', 'Python', 'C++'],
                          languagesList: [
                            {'name': 'English', 'level': 'Intermediate'},
                            {'name': 'Vietnamese', 'level': 'Native'},
                          ],
                          educationList: [
                            {
                              'school': 'University of Florida',
                              'yearsStart': 2021,
                              'yearsEnd': 2026
                            },
                          ],
                          projectsList: [
                            ProjectStudent(
                              projectName: 'Project 1',
                              projectDescription: 'This is a project 1 description',
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => HireStudentScreen(projectCompany: projectCompany,)));


                print('Item at index $index was tapped.');
              }, child: ShowProjectCompanyWidget(
              projectName: '${entries[index]}',
              creationTime: listTime[index],
              description: ['Clear expectations about your project or deliverables', 'The skills required for your project', 'Details about your project'],
              quantities: [0, 8, 2],
              labels: ['Proposals', 'Messages', 'Hired'],
              showOptionsIcon: true,
            ),
            ),
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ]),
    ),
    );
  }
}