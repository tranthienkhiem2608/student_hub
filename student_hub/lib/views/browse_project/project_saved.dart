import 'package:flutter/material.dart';
import 'package:student_hub/constant/project_duration.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class FavoriteProjectsPage extends StatelessWidget {
  final List<ProjectCompany> favoriteProjects;

  const FavoriteProjectsPage({Key? key, required this.favoriteProjects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Student Hub',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFBEEEF7),
      ),
      body: favoriteProjects.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: favoriteProjects.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 12,
                  thickness: 1.5,
                  color: Color.fromARGB(255, 54, 52, 52),
                ),
                itemBuilder: (context, index) {
                  ProjectCompany project = favoriteProjects[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saved Project',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Project ${project.title}'),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created ${project.createdAt}',
                          style: TextStyle(height: 1.0),
                        ),
                        Text(
                          project.title!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\nTime: ${_getProjectDurationText(ProjectDuration.values[project.projectScopeFlag ?? 0])}, ${project.numberOfStudents} students needed',
                          style: TextStyle(height: 1.0),
                        ),
                        SizedBox(height: 10),
                        Text('Students are looking for'),
                        Text(
                          project.description?.isNotEmpty ?? false
                              ? project.description!.split('\n').first
                              : '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Proposals: ${project.proposals}',
                          style: TextStyle(height: 1.0),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      iconSize: 30,
                      icon: Icon(
                        project.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: project.isFavorite ? Colors.red : null,
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
                          builder: (context) =>
                              ProjectDetailPage(project: project),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          : Center(
              child: Text('You have no favorite projects.'),
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
