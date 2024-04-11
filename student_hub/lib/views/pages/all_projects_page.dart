import 'package:flutter/material.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';

import '../../models/project_student.dart';
import '../../models/student_registered.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({super.key, required this.user});
  final User user;
  @override
  _AllProjectsPageState createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage>
    with WidgetsBindingObserver {
  late final PageController _pageController;

  List<ProjectCompany> projectList = [];

  int companyId = 0;

  Future<void> fetchProjects() async {
    List<ProjectCompany> projects =
        await ProjectCompanyViewModel(context).getProjectsData(companyId);
    setState(() {
      projectList = projects;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
    companyId = widget.user!.companyUser!.id!;
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

    return Visibility(
      replacement: const Center(
        child: Text("\t\tWelcome, $username \nYou no have jobs"),
      ),
      visible: projectList.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Expanded(
              child: FutureBuilder(
                future: fetchProjects(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: projectList.length,
                      itemBuilder: (context, index) {
                        return ShowProjectCompanyWidget(
                          projectName: projectList[index].title!,
                          creationTime:
                              DateTime.parse(projectList[index].createdAt!),
                          description: projectList[index].description!,
                          quantities: [0, 8, 0],
                          labels: ['Students are looking for'],
                          showOptionsIcon: true,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
