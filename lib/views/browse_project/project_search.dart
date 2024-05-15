import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class SearchProject extends StatefulWidget {
  final List<ProjectCompany> searchResults;
  final User user;
  String? searchQuery;

  SearchProject({
    Key? key,
    required this.searchResults,
    required this.user,
    this.searchQuery,
  }) : super(key: key);

  @override
  _SearchProjectState createState() => _SearchProjectState();
}

class _SearchProjectState extends State<SearchProject> {
  String? _previousProjectLength;
  int? _previousStudentsNeeded;
  int? _previousProposalsLessThan;
  static const int itemsPerPage = 10;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  final scrollController = ScrollController();

  List<ProjectCompany> filteredProjects = [];
  List<ProjectCompany> tmpList = [];
  String searchQuery = '';
  int? proposalsLessThan;
  int? studentsNeeded;
  String? projectLength;
  final TextEditingController _searchQuery = TextEditingController();
  Map<String, bool> radioState = {
    'less_than_one_month': false,
    'one_to_three_months': false,
    'three_to_six_months': false,
    'more_than_six_months': false,
  };

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

  Future<List<ProjectCompany>> fetchAllProjects(
      int currentPage,
      int itemsPerPage,
      String? title,
      String? projectScopeFlag,
      String? numberOfStudents,
      String? proposalsLessThan) async {
    List<ProjectCompany> projectTmp = await ProjectCompanyViewModel(context)
        .getAllProjectsData(currentPage, itemsPerPage, title, projectScopeFlag,
            numberOfStudents, proposalsLessThan);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('role') == 1) {
      return projectTmp;
    }
    List<Proposal> proposals = await ProposalViewModel(context)
        .getProposalById(widget.user!.studentUser!.id!);
    //check if projectId have in proposal will remove from project list
    projectTmp.removeWhere((project) =>
        proposals.any((proposal) => proposal.projectId == project.id));
    return projectTmp;
  }

  @override
  void initState() {
    super.initState();
    _searchQuery.text = widget.searchQuery ?? '';
    fetchAllProjects(
            currentPage, itemsPerPage, widget.searchQuery, null, null, null)
        .then((value) => setState(() {
              tmpList = value;
              filteredProjects = value;
            }));
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() {
              // Your state change here
              loadMoreData();
            });
          });
        }
      }
    });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      List<ProjectCompany> newProjects = await fetchAllProjects(
          ++currentPage, itemsPerPage, null, null, null, null);

      // Fetch the next page of data

      print('Current Page: $currentPage');
      // Update the state with the new data
      setState(() {
        isLoading = false;
        filteredProjects.addAll(newProjects);
        print('Current Page: $currentPage');
        hasMoreData = newProjects.length == itemsPerPage;
      });
    }
  }

  void navigateToProjectDetailPage(ProjectCompany project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProjectDetailPage(project: project, user: widget.user),
      ),
    );
  }

  void filterProjects() {
    setState(() {
      _previousProjectLength = projectLength;
      _previousStudentsNeeded = studentsNeeded;
      _previousProposalsLessThan = proposalsLessThan;
      filteredProjects = tmpList.where((project) {
        bool passProjectLengthFilter = true;
        if (projectLength != null) {
          switch (projectLength) {
            case 'less_than_one_month':
              passProjectLengthFilter = project.projectScopeFlag ==
                  ProjectDuration.lessThanOneMonth.index;
              break;
            case 'one_to_three_months':
              passProjectLengthFilter = project.projectScopeFlag ==
                  ProjectDuration.oneToThreeMonths.index;
              break;
            case 'three_to_six_months':
              passProjectLengthFilter = project.projectScopeFlag ==
                  ProjectDuration.threeToSixMonths.index;
              break;
            case 'more_than_six_months':
              passProjectLengthFilter = project.projectScopeFlag ==
                  ProjectDuration.moreThanSixMonth.index;
              break;
            default:
              passProjectLengthFilter = true;
          }
        }
        bool passStudentsNeededFilter = true;
        if (studentsNeeded != null) {
          passStudentsNeededFilter = project.numberOfStudents == studentsNeeded;
        }
        bool passProposalsLessThanFilter = true;
        if (proposalsLessThan != null) {
          passProposalsLessThanFilter = project.proposals == proposalsLessThan!;
        }
        return passProjectLengthFilter &&
            passStudentsNeededFilter &&
            passProposalsLessThanFilter;
      }).toList();
    });
  }

  void clearFilters() {
    setState(() {
      projectLength = null;
      studentsNeeded = null;
      proposalsLessThan = null;
      _previousProjectLength = null;
      _previousStudentsNeeded = null;
      _previousProposalsLessThan = null;
      filterProjects();
    });
  }

  void showFilterBottomSheet(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context, listen: false).isDarkMode;

    showModalBottomSheet(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Text(
                  'projectfilter_project1'.tr(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF406AFF),
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'projectfilter_project0'.tr(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        RadioListTile(
                          title: Text(
                            'projectdetail_student5'.tr(),
                            style: GoogleFonts.poppins(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black,),
                          ),
                          value: 'less_than_one_month',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month':
                                    projectLength == 'less_than_one_month',
                                'one_to_three_months': false,
                                'three_to_six_months': false,
                                'more_than_six_months': false,
                              };
                            });
                          },
                          selected: radioState['less_than_one_month'] ?? false,
                          activeColor: Color(0xFF406AFF),
                        ),
                        RadioListTile(
                          title: Text('projectlist_company6'.tr(),
                              style: GoogleFonts.poppins(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black,)),
                          value: 'one_to_three_months',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month': false,
                                'one_to_three_months':
                                    projectLength == 'one_to_three_months',
                                'three_to_six_months': false,
                                'more_than_six_months': false,
                              };
                            });
                          },
                          selected: radioState['one_to_three_months'] ?? false,
                          activeColor: Color(0xFF406AFF),
                        ),
                        RadioListTile(
                          title: Text('projectlist_company7'.tr(),
                              style: GoogleFonts.poppins(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black,)),
                          value: 'three_to_six_months',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month': false,
                                'one_to_three_months': false,
                                'three_to_six_months':
                                    projectLength == 'three_to_six_months',
                                'more_than_six_months': false,
                              };
                            });
                          },
                          selected: radioState['three_to_six_months'] ?? false,
                          activeColor: Color(0xFF406AFF),
                        ),
                        RadioListTile(
                          title: Text('projectlist_company8'.tr(),
                              style: GoogleFonts.poppins(fontSize: 15, color: isDarkMode ? Colors.white : Colors.black,)),
                          value: 'more_than_six_months',
                          groupValue: projectLength,
                          onChanged: (value) {
                            setState(() {
                              projectLength = value as String?;
                              radioState = {
                                'less_than_one_month': false,
                                'one_to_three_months': false,
                                'three_to_six_months': false,
                                'more_than_six_months':
                                    projectLength == 'more_than_six_months',
                              };
                            });
                          },
                          selected: radioState['more_than_six_months'] ?? false,
                          activeColor: Color(0xFF406AFF),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'projectfilter_project6'.tr(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'projectfilter_project9'.tr(),
                    hintStyle: GoogleFonts.poppins(fontSize: 14, color: isDarkMode ? Color.fromARGB(255, 177, 177, 177) : Color.fromARGB(255, 149, 149, 149),),
                  ),
                  onChanged: (value) {
                    setState(() {
                      studentsNeeded = int.tryParse(value);
                    });
                  },
                  // Gán giá trị từ biến lưu trữ trạng thái
                  initialValue: _previousStudentsNeeded?.toString(),
                  cursorColor: Color(0xFF406AFF),
                ),
                SizedBox(height: 25),
                Text(
                  'projectfilter_project7'.tr(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'projectfilter_project10'.tr(),
                    hintStyle: GoogleFonts.poppins(fontSize: 14, color: isDarkMode ? Color.fromARGB(255, 177, 177, 177) : Color.fromARGB(255, 149, 149, 149),),
                  ),
                  onChanged: (value) {
                    setState(() {
                      proposalsLessThan = int.tryParse(value);
                    });
                  },
                  initialValue: _previousProposalsLessThan?.toString(),
                  cursorColor: Color(0xFF406AFF),
                ),
                SizedBox(height: 170),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        clearFilters();
                        Navigator.pop(context); // Close bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4DBE3FF),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "projectfilter_project4".tr(),
                        style: GoogleFonts.poppins(
                            color: Color(0xFF406AFF), fontSize: 16.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        filterProjects();
                        Navigator.pop(context); // Close bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF406AFF),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "projectfilter_project8".tr(),
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16.0,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF212121) : Colors.white,
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
        actions: <Widget>[],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: TextField(
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              controller: _searchQuery,
              onChanged: (value) {
                setState(() {
                  _searchQuery.text = value;
                  fetchAllProjects(
                          currentPage, itemsPerPage, value, null, null, null)
                      .then((value) => setState(() {
                            filteredProjects = value;
                          }));
                });
              },
              decoration: InputDecoration(
                hintText: 'projectlist_project3'.tr(),
                hintStyle: GoogleFonts.poppins(
                  color: isDarkMode
                      ? Color.fromARGB(255, 98, 98, 98)
                      : Colors.black,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    showFilterBottomSheet(context);
                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredProjects.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: filteredProjects.length,
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemBuilder: (context, index) {
                        ProjectCompany project = filteredProjects[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                          decoration: BoxDecoration(
                            color:
                                isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
                            border: Border.all(
                              color: isDarkMode
                                  ? Color.fromARGB(255, 60, 60, 60)
                                  : Color.fromARGB(255, 228, 228, 233),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode
                                    ? Color(0xFF212121)
                                    : Colors.grey.withOpacity(0.25),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                      timeAgo(
                                          DateTime.parse(project.createdAt!)),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          height: 1,
                                          fontSize: 11,
                                          color:
                                              Color.fromARGB(255, 18, 119, 52),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                FutureBuilder<int>(
                                  future: SharedPreferences.getInstance().then(
                                      (prefs) => prefs.getInt('role') ?? 0),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<int> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData &&
                                          snapshot.data == 0) {
                                        return IconButton(
                                          iconSize: 30,
                                          icon: Icon(
                                            project.isFavorite == true
                                                ? Icons.bookmark_added
                                                : Icons.bookmark_add_outlined,
                                            color: project.isFavorite == true
                                                ? Color.fromARGB(
                                                    255, 250, 55, 87)
                                                : null,
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
                                                project.isFavorite =
                                                    newFavoriteStatus;
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
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  project.description?.isNotEmpty ?? false
                                      ? project.description!.split('\n').first
                                      : '',
                                  style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
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
                                          height: 1.0,
                                          fontSize: 12,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black),
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
                                          height: 1.0,
                                          fontSize: 12,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black),
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
                                          height: 1.0,
                                          fontSize: 12,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {
                              navigateToProjectDetailPage(project);
                            },
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text('projectlist_student0'.tr()),
                  ),
          ),
        ],
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
