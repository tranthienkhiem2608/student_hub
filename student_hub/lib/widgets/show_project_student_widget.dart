// show_school_widget.dart
import 'package:flutter/material.dart';
import 'package:student_hub/models/student_user.dart';
import 'package:student_hub/widgets/pop_up_project_widget.dart';

import 'package:intl/intl.dart'; // Import the intl package

class ShowProjectStudentWidget extends StatelessWidget {
  final StudentUser userStudent;
  final Function _deleteProject;
  final Function _addNewProject;

  const ShowProjectStudentWidget({
    Key? key,
    required this.userStudent,
    required Function deleteProject,
    required Function addNewProject,
  })  : _deleteProject = deleteProject,
        _addNewProject = addNewProject;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userStudent.projectsList.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            ListTile(
              title: Text(userStudent.projectsList[index].projectName,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${DateFormat('dd-MM-yyyy').format(userStudent.projectsList[index].timeStart)} - ${DateFormat('dd-MM-yyyy').format(userStudent.projectsList[index].timeEnd)}, \nDuration: ${(userStudent.duration.inHours / 24).round()} days'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: () {
                          // Handle edit button press
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PopUpProjectWidget(
                                _addNewProject,
                                _deleteProject,
                                userStudent.projectsList[index].projectName,
                                userStudent.projectsList[index].timeStart,
                                userStudent.projectsList[index].timeEnd,
                                userStudent.projectsList[index].projectDescription,
                                userStudent.projectsList[index].skillsListProject,
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(width: 0), // Khoảng cách giữa hai biểu tượng
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Handle delete button press
                          _deleteProject(userStudent.projectsList[index].projectName);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(userStudent.projectsList[index].projectDescription)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: userStudent
                        .projectsList[index]
                        .skillsListProject
                        .map((skill) => Chip(label: Text(skill)))
                        .toList(),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.7,
            ),
          ],
        );
      },
    );
  }
}
