import 'package:flutter/material.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class FavoriteProjectsPage extends StatelessWidget {
  final List<ProjectInfo> favoriteProjects;

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
            color: Colors.blueAccent,
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
                  ProjectInfo project = favoriteProjects[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saved Project',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Project ${project.name}'),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created ${project.createdDate}',
                          style: TextStyle(height: 1.0),
                        ),
                        Text(
                          project.role,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\nTime: ${project.duration}, ${project.students} students needed',
                          style: TextStyle(height: 1.0),
                        ),
                        SizedBox(height: 10),
                        Text('Students are looking for'),
                        Text(
                          project.expectations.isNotEmpty
                              ? project.expectations.split('\n').first
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
