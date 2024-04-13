import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';

class ProjectList extends StatefulWidget {
  final List<ProjectCompany> projects;

  const ProjectList({Key? key, required this.projects}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return 'Created ${diff.inSeconds} seconds ago';
    } else if (diff.inMinutes < 60) {
      return 'Created ${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return 'Created ${diff.inHours} hours ago';
    } else if (diff.inDays < 7) {
      return 'Created ${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      return 'Created ${(diff.inDays / 7).round()} weeks ago';
    } else if (diff.inDays < 365) {
      return 'Created ${(diff.inDays / 30).round()} months ago';
    } else {
      return 'Created ${(diff.inDays / 365).round()} years ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: Center(
        child: Text(
          "\t\tWelcome, You have no projects",
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
            itemCount: widget.projects.length,
            itemBuilder: (context, index) {
              ProjectCompany project = widget.projects[index];
              List<String> expectations = project.description!.split('\n');
              String firstExpectation =
                  expectations.isNotEmpty ? expectations.first : '';
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
                          margin: const EdgeInsets.only(right: 230.0),
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
                        'Project ${project.title}',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF406AFF),
                        ),
                      ),
                      Text(
                        project.title!,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Students are looking for',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        firstExpectation,
                        style: GoogleFonts.poppins(),
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
                            style:
                                GoogleFonts.poppins(height: 1.0, fontSize: 12),
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
                            style:
                                GoogleFonts.poppins(height: 1.0, fontSize: 12),
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
                            '${project.countProposal} proposals',
                            style:
                                GoogleFonts.poppins(height: 1.0, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailPage(project: project),
                      ),
                    );
                  },
                ),
              );
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
      return 'Less than 1 month';
    case ProjectDuration.oneToThreeMonths:
      return '1 to 3 months';
    case ProjectDuration.threeToSixMonths:
      return '3 to 6 months';
    case ProjectDuration.moreThanSixMonth:
      return 'More than 6 months';
  }
}
