import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';

class FavoriteProjectsPage extends StatelessWidget {
  final List<ProjectCompany> favoriteProjects;
  final int studentId;

  const FavoriteProjectsPage(
      {Key? key, required this.favoriteProjects, required this.studentId})
      : super(key: key);

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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Saved projects',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF406AFF),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: favoriteProjects.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: favoriteProjects.length,
                separatorBuilder: (context, index) => const SizedBox(),
                itemBuilder: (context, index) {
                  ProjectCompany project = favoriteProjects[index];

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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text('${project.title}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF406AFF),
                                    fontSize: 18)),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3),
                            Text(
                              timeAgo(DateTime.parse(project.createdAt!)),
                              style: GoogleFonts.poppins(
                                  height: 1.0,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 25, 241, 43)),
                            ),
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
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(height: 15),
                            const SizedBox(height: 5),
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
                            SizedBox(height: 5),
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
                            SizedBox(height: 5),
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
                        trailing: IconButton(
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
                            // Toggle favorite status
                            project.isFavorite = !project.isFavorite;
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectDetailPage(
                                project: project,
                                studentId: studentId,
                              ),
                            ),
                          );
                        },
                      ));
                },
              ),
            )
          : Center(
              child: Text(
                'You have no favorite projects.',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
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
