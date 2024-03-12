import 'package:flutter/material.dart';
import 'package:student_hub/views/browse_project/project_detail.dart';

class ProjectList extends StatefulWidget {
  final List<ProjectInfo> projects;

  const ProjectList({Key? key, required this.projects}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: const Center(
        child: Text(
          "\t\tWelcome, You have no projects",
          textAlign: TextAlign.center,
        ),
      ),
      visible: widget.projects.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 5,
              thickness: 1.5,
              color: Color.fromARGB(255, 54, 52, 52),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Expanded(
              child: ListView.separated(
                itemCount: widget.projects.length,
                itemBuilder: (context, index) {
                  ProjectInfo project = widget.projects[index];
                  List<String> expectations = project.expectations.split('\n');
                  String firstExpectation = expectations.isNotEmpty ? expectations.first : '';
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Project ${project.name}'),
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
                                color: Colors.green, // Màu xanh lá cho role
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\nTime: ${project.duration}, ${project.students} students needed',
                              style: TextStyle(height: 1.0),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Students are looking for',
                            ),
                            Text(
                              firstExpectation,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Proposals: Less than ${project.proposals}',
                              style: TextStyle(height: 1.0),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          iconSize: 30,
                          icon: Icon(
                            project.isFavorite
                                ? Icons.favorite // Biểu tượng đã được chọn
                                : Icons
                                .favorite_border, // Biểu tượng chưa được chọn
                            color: project.isFavorite
                                ? Colors.red // Màu đỏ nếu đã được chọn
                                : null, // Màu mặc định nếu chưa được chọn
                          ),
                          onPressed: () {
                            setState(() {
                              // Cập nhật trạng thái yêu thích của dự án khi người dùng nhấn vào biểu tượng
                              project.isFavorite = !project.isFavorite;
                            });
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
                      ),
                      SizedBox(height: 12),
                      const Divider(
                        height: 12,
                        thickness: 1.5,
                        color: Color.fromARGB(255, 54, 52, 52),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectInfo {
  final String name;
  final String createdDate;
  final String role;
  final String duration;
  final int students;
  final String expectations;
  final int proposals;
  bool isFavorite;

  ProjectInfo({
    required this.name,
    required this.createdDate,
    required this.role,
    required this.duration,
    required this.students,
    required this.expectations,
    required this.proposals,
    this.isFavorite = false, // Mặc định là không yêu thích
  });
}
