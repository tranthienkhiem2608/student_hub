import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';

class SearchProject extends StatefulWidget {
  final List<ProjectCompany> searchResults;
  final int studentId;

  const SearchProject({
    Key? key,
    required this.searchResults,
    required this.studentId,
    required List<ProjectCompany> allProjects,
  }) : super(key: key);

  @override
  _SearchProjectState createState() => _SearchProjectState();
}

class _SearchProjectState extends State<SearchProject> {
  String? _previousProjectLength;
  int? _previousStudentsNeeded;
  int? _previousProposalsLessThan;

  List<ProjectCompany> filteredProjects = [];
  String searchQuery = '';
  int? proposalsLessThan;
  int? studentsNeeded;
  String? projectLength;
  Map<String, bool> radioState = {
    'less_than_one_month': false,
    'one_to_three_months': false,
    'three_to_six_months': false,
    'more_than_six_months': false,
  };

  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} seconds ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).round()} weeks ago';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).round()} months ago';
    } else {
      return '${(diff.inDays / 365).round()} years ago';
    }
  }

  @override
  void initState() {
    super.initState();
    filteredProjects.addAll(widget.searchResults);
  }

  void navigateToProjectDetailPage(ProjectCompany project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProjectDetailPage(project: project, studentId: widget.studentId),
      ),
    );
  }

  void filterProjects() {
    setState(() {
      _previousProjectLength = projectLength;
      _previousStudentsNeeded = studentsNeeded;
      _previousProposalsLessThan = proposalsLessThan;
      filteredProjects = widget.searchResults.where((project) {
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
    showModalBottomSheet(
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
                Text(
                  'Filter by',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF406AFF),
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Project length:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      children: [
                        RadioListTile(
                          title: Text(
                            'Less than one month',
                            style: GoogleFonts.poppins(fontSize: 15),
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
                          title: Text('1 to 3 months',
                              style: GoogleFonts.poppins(fontSize: 15)),
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
                          title: Text('3 to 6 months',
                              style: GoogleFonts.poppins(fontSize: 15)),
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
                          title: Text('More than 6 months',
                              style: GoogleFonts.poppins(fontSize: 15)),
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
                  'Students needed:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter number of students',
                    hintStyle: GoogleFonts.poppins(fontSize: 14),
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
                  'Proposals less than:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter maximum number of proposals',
                    hintStyle: GoogleFonts.poppins(fontSize: 14),
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
                        "Save project",
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
                        "Apply now",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16.0),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Hub',
            style: GoogleFonts.poppins(
                // Apply the Poppins font
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[],
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                filterProjects();
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    showFilterBottomSheet(context);
                  },
                  icon: Icon(Icons.filter_list),
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
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromARGB(255, 228, 228, 233),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
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
                                IconButton(
                                  iconSize: 30,
                                  icon: Icon(
                                    project.isFavorite
                                        ? Icons.bookmark_added
                                        : Icons.bookmark_add_outlined,
                                    color: project.isFavorite
                                        ? Color.fromARGB(255, 250, 55, 87)
                                        : null,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      project.isFavorite = !project.isFavorite;
                                    });
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
                                  'Students are looking for',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  project.description?.isNotEmpty ?? false
                                      ? project.description!.split('\n').first
                                      : '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                          height: 1.0, fontSize: 12),
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
                                      '${project.numberOfStudents} students',
                                      style: GoogleFonts.poppins(
                                          height: 1.0, fontSize: 12),
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
                                      '${project.proposals != null ? project.proposals : 0} proposals',
                                      style: GoogleFonts.poppins(
                                          height: 1.0, fontSize: 12),
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
                    child: Text('No projects found.'),
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
      return 'Less than 1 month';
    case ProjectDuration.oneToThreeMonths:
      return '1 to 3 months';
    case ProjectDuration.threeToSixMonths:
      return '3 to 6 months';
    case ProjectDuration.moreThanSixMonth:
      return 'More than 6 months';
  }
}
