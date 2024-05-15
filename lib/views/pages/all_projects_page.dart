import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/views/company_proposal/hire_student_screen.dart';
import 'package:student_hub/widgets/show_project_company_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class AllProjectsPage extends StatefulWidget {
  const AllProjectsPage(
      {super.key, required this.user, required this.fetchProjectDataFunction});
  final User user;
  final Future<List<ProjectCompany>> Function() fetchProjectDataFunction;
  @override
  _AllProjectsPageState createState() => _AllProjectsPageState();
}

class _AllProjectsPageState extends State<AllProjectsPage>
    with WidgetsBindingObserver {
  late PageController _pageController;
  late Future<List<ProjectCompany>> futureProjects;

  void _handleProjectDeleted() {
    setState(() {
      futureProjects = widget.fetchProjectDataFunction();
    });
  }

  void _handleChangeStatus() {
    setState(() {
      futureProjects = widget.fetchProjectDataFunction();
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(_onPageChange);
    // companyId = widget.user!.companyUser!.id!;
    setState(() {
      futureProjects = widget.fetchProjectDataFunction();
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
            futureProjects = widget.fetchProjectDataFunction();
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
                          "${'welcome_welcomecompany2'.tr()} ${widget.user.fullname}!. ${'noti1'.tr()}",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          )));
                } else {
                  return ListView.builder(
                    itemCount: project.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HireStudentScreen(
                                projectCompany: project.data![index],
                                user: widget.user,
                                initialTabIndex: 0,
                              ),
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
                          labels: [
                            'companyprojecthired_company1'.tr(),
                            'companyprojecthired_company3'.tr(),
                            'companyprojecthired_company4'.tr()
                          ],
                          showOptionsIcon: true,
                          onProjectDeleted: _handleProjectDeleted,
                          onChangeStatus: _handleChangeStatus,
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
