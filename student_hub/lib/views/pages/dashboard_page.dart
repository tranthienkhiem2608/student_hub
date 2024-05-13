import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/views/pages/all_projects_page.dart';
import 'package:student_hub/views/pages/archieved_page.dart';
import 'package:student_hub/views/pages/working_page.dart';
import 'package:student_hub/views/pages/working_page_student.dart';
import 'package:student_hub/views/post_project/post_screen_1.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

import 'all_projects_page_student.dart';

class DashboardPage extends StatefulWidget {
  final User user;

  const DashboardPage(this.user, {super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? role; // Keep the role variable

  Future<int?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role');
  }

  @override
  void initState() {
    super.initState();
    _initializeRole();
  }

  Future<void> _initializeRole() async {
    int? role = await getRole();
    setState(() {
      this.role = role;
    });
  }

  Future<List<ProjectCompany>> fetchDataProject() async {
    if (widget.user.companyUser != null &&
        widget.user.companyUser!.id != null) {
      return await ProjectCompanyViewModel(context)
          .getProjectsData(widget.user.companyUser!.id!);
    } else {
      return [];
    }
  }

  Future<List<Proposal>> fetchProposals() async {
    return await ProposalViewModel(context)
        .getProposalById(widget.user.studentUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                role == 0 ? 'studentdashboard_student1'.tr() : 'companydashboard_company1'.tr(),
                style: GoogleFonts.poppins(
                    color: Color(0xFF406AFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              role == 0
                  ? Container() // Empty container (or any other widget you want to show when the button should be hidden)
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF406AFF)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostScreen1(widget.user)),
                        );
                      },
                      child: Text(
                        'companydashboard_company3'.tr(),
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: const Color(0xFF406AFF),
            labelColor: isDarkMode ? Colors.white : Colors.black,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            unselectedLabelColor: isDarkMode ? Colors.white : Colors.black,
            dividerColor: isDarkMode
                ? const Color.fromARGB(255, 47, 47, 47)
                : Colors.white,
            tabs: [
              Tab(text: 'companydashboard_company4'.tr()),
              Tab(text: 'studentdashboard_student3'.tr()),
              Tab(text: 'studentdashboard_student4'.tr()),
            ],
          ),
        ),
        body: TabBarView(children: [
          role == 0
              ? AllProjectsPageStudent(
                  user: widget.user,
                  fetchProjectDataFunction: fetchProposals,
                )
              : AllProjectsPage(
                  user: widget.user,
                  fetchProjectDataFunction: fetchDataProject,
                ),
          role == 0
              ? WorkingPageStudent(
                  user: widget.user, fetchProjectDataFunction: fetchProposals)
              : WorkingPage(
                  user: widget.user,
                  fetchProjectDataFunction: fetchDataProject),
          ArchivedPage(
              user: widget.user, fetchProjectDataFunction: fetchDataProject),
        ]),
      ),
    );
  }
}
