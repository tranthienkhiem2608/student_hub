import 'package:flutter/material.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage({super.key, required this.user});
  final User user;
  @override
  _AllProjectsPageState createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage>
    with WidgetsBindingObserver {
  late PageController _pageController;
  late Future<List<ProjectCompany>> futureProjects;

  void _handleProjectDeleted() {
    setState(() {
      futureProjects = fetchDataProject();
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
    // companyId = widget.user!.companyUser!.id!;
    setState(() {
      // Update your state here
      futureProjects = fetchDataProject();
    });
    //print projectList;
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChange() {
    Future.microtask(() {
      if (_pageController.page == _pageController.initialPage) {
        if (mounted) {
          setState(() {
            // Update your state here
            futureProjects = fetchDataProject();
          });
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

    return Visibility(
      replacement: const Center(
        child: Text("\t\tWelcome, $username \nYou no have jobs"),
      ),
      visible: futureProjects != null,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Expanded(
              child: FutureBuilder<List<ProjectCompany>>(
                future: futureProjects,
                builder: (context, project) {
                  if (project.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (project.hasError) {
                    return Text('Error: ${project.error}');
                  } else {
                    return ListView.builder(
                      itemCount: project.data!.length,
                      itemBuilder: (context, index) {
                        print(project.data![index].title);
                        print(project.data![index].description);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HireStudentScreen(
                                    projectCompany: project.data![index]),
                              ),
                            );
                          },
                          child: ShowProjectCompanyWidget(
                            id: project.data![index].id!,
                            projectName: project.data![index].title!.toString(),
                            creationTime: DateTime.parse(
                                project.data![index].createdAt!.toString()),
                            description:
                                project.data![index].description!.toString(),
                            quantities: [
                              project.data![index].countProposal!.toString(),
                              project.data![index].countMessages!.toString(),
                              project.data![index].countHired!.toString()
                            ],
                            labels: ['Proposals', 'Messages', 'Hired'],
                            showOptionsIcon: true,
                            onProjectDeleted: _handleProjectDeleted,
                          ),
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

  Future<List<ProjectCompany>> fetchDataProject() async {
    if (widget.user.companyUser != null &&
        widget.user.companyUser!.id != null) {
      return await ProjectCompanyViewModel(context)
          .getProjectsData(widget.user.companyUser!.id!);
    } else {
      // Handle the case where companyUser or id is null
      // For example, you might want to return an empty list
      return [];
    }
  }
}
