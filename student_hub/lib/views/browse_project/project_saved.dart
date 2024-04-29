import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/view_models/controller_route.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class FavoriteProjectsPage extends StatefulWidget {
  final List<ProjectCompany> favoriteProjects;
  final int studentId;
  final User user;

  const FavoriteProjectsPage(
      {Key? key,
      required this.favoriteProjects,
      required this.studentId,
      required this.user})
      : super(key: key);
  @override
  _FavoriteProjectsPageState createState() => _FavoriteProjectsPageState();
}

class _FavoriteProjectsPageState extends State<FavoriteProjectsPage> {
  Future<List<ProjectCompany>>? favoriteList;

  Future<List<ProjectCompany>> fetchListFavoriteProjects(
      BuildContext context, int studentId) async {
    List<ProjectCompany> projectList =
        await ProposalViewModel(context).getListFavoriteProject(studentId);
    return projectList;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: FutureBuilder<List<ProjectCompany>>(
          future: favoriteList =
              fetchListFavoriteProjects(context, widget.studentId),
          builder: (context, project) {
            if (project.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (project.hasError) {
              return Text('Error: ${project.error}');
            } else if (project.hasData && project.data!.isEmpty) {
              return Center(child: Text("You have no favorite projects."));
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: project.data!.length,
                itemBuilder: (context, index) {
                  project.data![index].isFavorite = true;
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
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text('${project.data![index].title}',
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
                              timeAgo(DateTime.parse(
                                  project.data![index].createdAt!.toString())),
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
                                  fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black,),
                            ),
                            Text(
                              project.data![index].description?.isNotEmpty ??
                                      false
                                  ? project.data![index].description!
                                      .split('\n')
                                      .first
                                  : '',
                              style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black,),
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
                                  _getProjectDurationText(ProjectDuration
                                          .values[
                                      project.data![index].projectScopeFlag ??
                                          0]),
                                  style: GoogleFonts.poppins(
                                      height: 1.0, fontSize: 12, color: isDarkMode ? Colors.white : Colors.black,),
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
                                  '${project.data![index].numberOfStudents} students',
                                  style: GoogleFonts.poppins(
                                      height: 1.0, fontSize: 12, color: isDarkMode ? Colors.white : Colors.black,),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.assignment,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${project.data![index].countProposal != null ? project.data![index].countProposal : 0} proposals',
                                  style: GoogleFonts.poppins(
                                      height: 1.0, fontSize: 12, color: isDarkMode ? Colors.white : Colors.black,),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          iconSize: 30,
                          icon: Icon(
                            project.data![index].isFavorite == true
                                ? Icons.bookmark_added
                                : Icons.bookmark_add_outlined,
                            color: project.data![index].isFavorite == true
                                ? Color.fromARGB(255, 250, 55, 87)
                                : null,
                          ),
                          onPressed: () async {
                            // Toggle favorite status
                            bool newFavoriteStatus =
                                !project.data![index].isFavorite;
                            bool success =
                                await ProposalViewModel(context).setFavorite(
                              widget.studentId,
                              project.data![index].id!,
                              newFavoriteStatus ? 0 : 1,
                            );

                            if (success) {
                              // If the API call was successful, update the UI
                              setState(() {
                                project.data![index].isFavorite =
                                    newFavoriteStatus;
                              });
                            }
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectDetailPage(
                                project: project.data![index],
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      ));
                },
              );
            }
          },
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
