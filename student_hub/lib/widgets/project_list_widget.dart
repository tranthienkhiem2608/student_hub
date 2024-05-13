import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';
import 'package:student_hub/views/pages/projects_page.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ProjectList extends StatefulWidget {
  final List<ProjectCompany> projects;
  final User user;
  final Future<List<ProjectCompany>> Function(int, int) fetchAllProjects;
  ScrollController scrollController;
  ProjectList(
      {Key? key,
      required this.projects,
      required this.user,
      required this.fetchAllProjects,
      required this.scrollController})
      : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  int itemsPerPage = 8;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    // widget.scrollController.addListener(() {
    //   if (widget.scrollController.position.pixels ==
    //       widget.scrollController.position.maxScrollExtent) {
    //     // The user has scrolled to the bottom, load more data
    //     loadMoreData();
    //   }
    // });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Fetch the next page of data
      List<ProjectCompany> newProjects =
          await widget.fetchAllProjects(currentPage, itemsPerPage);

      // Update the state with the new data
      setState(() {
        isLoading = false;
        widget.projects.addAll(newProjects);
        currentPage++;
        hasMoreData = newProjects.length == itemsPerPage;
      });
    }
  }

  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds <= 0) {
      return 'time0'.tr();
    } else if (diff.inSeconds < 60 && diff.inSeconds > 0) {
      return '${diff.inSeconds} ${'time1'.tr()}';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${'time2'.tr()}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${'time3'.tr()}';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ${'time4'.tr()}';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()} ${'time5'.tr()}';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()} ${'time6'.tr()}';
    } else {
      return '${(diff.inDays / 365).round()} ${'time4'.tr()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Visibility(
      replacement: Center(
        child: Text(
          "projectlist_company1".tr(),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      visible: widget.projects.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: ListView.separated(
            controller: widget.scrollController,
            itemCount: widget.projects.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < widget.projects.length) {
                ProjectCompany project = widget.projects[index];
                project.isFavorite == false;
                List<String> expectations = project.description!.split('\n');
                String firstExpectation =
                    expectations.isNotEmpty ? expectations.first : '';
                if (project.typeFlag == 1 || project.typeFlag == 2) {
                  return const SizedBox.shrink();
                }
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
                    border: Border.all(
                      color: isDarkMode ? Color.fromARGB(255, 60, 60, 60) : Color.fromARGB(255, 228, 228, 233),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode ? Color(0xFF212121) : Colors.grey.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 206, 250, 223),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: const EdgeInsets.only(right: 200.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7.0, vertical: 10.0),
                            constraints: const BoxConstraints(
                                minWidth: 0, maxWidth: double.infinity),
                            child: Text(
                              timeAgo(DateTime.parse(project.createdAt!)),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  height: 1,
                                  fontSize: 11,
                                  color: Color.fromARGB(255, 18, 119, 52),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        FutureBuilder<int>(
                          future: SharedPreferences.getInstance()
                              .then((prefs) => prefs.getInt('role') ?? 0),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData && snapshot.data == 0) {
                                return IconButton(
                                  iconSize: 30,
                                  icon: Icon(
                                    project.isFavorite == true
                                        ? Icons.bookmark_added
                                        : Icons.bookmark_add_outlined,
                                    color: project.isFavorite == true
                                        ? Color.fromARGB(255, 250, 55, 87)
                                        :  isDarkMode ? Colors.white : Colors.black,

                                  ),
                                  onPressed: () async {
                                    // Toggle favorite status
                                    bool newFavoriteStatus =
                                        !project.isFavorite;
                                    bool success =
                                        await ProposalViewModel(context)
                                            .setFavorite(
                                      widget.user.studentUser!.id!,
                                      project.id!,
                                      newFavoriteStatus ? 0 : 1,
                                    );

                                    if (success) {
                                      // If the API call was successful, update the UI
                                      setState(() {
                                        project.isFavorite = newFavoriteStatus;
                                      });
                                    }
                                  },
                                );
                              } else {
                                return SizedBox
                                    .shrink(); // Return an empty widget if role is not 0
                              }
                            } else {
                              return CircularProgressIndicator(); // Show a loading spinner while waiting for the future to complete
                            }
                          },
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          '${project.title}',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF406AFF),
                          ),
                        ),
                        // Text(
                        //   project.company.role,
                        //   style: GoogleFonts.poppins(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 15),
                        Text(
                          'projectlist_company2'.tr(),
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
                        ),
                        Text(
                          firstExpectation,
                          style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black,),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${_getProjectDurationText(ProjectDuration.values[project.projectScopeFlag ?? 0])}',
                              style: GoogleFonts.poppins(
                                  height: 1.0, fontSize: 12, color: isDarkMode ? Colors.white : Colors.black,),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.grey,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${project.numberOfStudents} ${'projectlist_company3'.tr()}',
                              style: GoogleFonts.poppins(
                                  height: 1.0, fontSize: 12, color: isDarkMode ? Colors.white : Colors.black,),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.assignment,
                              color: Colors.grey,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${project.proposals != null ? project.proposals : 0} ${'projectlist_company4'.tr()}',
                              style: GoogleFonts.poppins(
                                  height: 1.0, fontSize: 12, color: isDarkMode ? Colors.white : Colors.black,),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailPage(
                              project: project, user: widget.user),
                        ),
                      );
                    },
                  ),
                );
              } else {
                // Return a loading indicator
                return CircularProgressIndicator();
              }
            },
            separatorBuilder: (context, index) => const SizedBox(),
          ),
        ),
      ),
    );
  }
}

// Helper method to get project duration text from enum
String _getProjectDurationText(ProjectDuration duration) {
  switch (duration) {
    case ProjectDuration.lessThanOneMonth:
      return 'projectlist_company5'.tr();
    case ProjectDuration.oneToThreeMonths:
      return 'projectlist_company6'.tr();
    case ProjectDuration.threeToSixMonths:
      return 'projectlist_company7'.tr();
    case ProjectDuration.moreThanSixMonth:
      return 'projectlist_company8'.tr();
  }
}
