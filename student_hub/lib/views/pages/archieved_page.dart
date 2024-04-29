import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ArchivedPage extends StatefulWidget {
  final User user;
  final Future<List<ProjectCompany>> fetchProjectData;

  const ArchivedPage(
      {super.key, required this.user, required this.fetchProjectData});
  @override
  _ArchivedPageState createState() => _ArchivedPageState();
}

class _ArchivedPageState extends State<ArchivedPage>
    with WidgetsBindingObserver {
  late PageController _pageController;
  late Future<List<ProjectCompany>> futureProjects;

  void _handleProjectDeleted() {
    setState(() {
      futureProjects = widget.fetchProjectData;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
    // companyId = widget.user!.companyUser!.id!;
    setState(() {
      // Update your state here
      futureProjects = widget.fetchProjectData;
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
            futureProjects = widget.fetchProjectData;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                } else if (project.hasData && project.data!.isEmpty) {
                  return Center(
                      child: Text(
                        textAlign: TextAlign.center,
                          "\t\tWelcome, ${widget.user.fullname}!. You no archived in progress",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          )));
                } else {
                  return ListView.builder(
                    itemCount: project.data!.length,
                    itemBuilder: (context, index) {
                      print(project.data![index].title);
                      print(project.data![index].description);
                      if (project.data![index].typeFlag == 1 ||
                          project.data![index].typeFlag == 0 ||
                          project.data![index].typeFlag == null) {
                        return const SizedBox.shrink();
                      }
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
                          projectCompany: project.data![index],
                          quantities: [
                            project.data![index].countProposal!.toString(),
                            project.data![index].countMessages!.toString(),
                            project.data![index].countHired!.toString()
                          ],
                          labels: ['Proposals', 'Messages', 'Hired'],
                          showOptionsIcon: true,
                          onProjectDeleted: _handleProjectDeleted,
                          user: widget.user,
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
    );
  }
}
