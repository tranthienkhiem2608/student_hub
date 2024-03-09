// show_school_widget.dart
import 'package:flutter/material.dart';
import 'package:student_hub/models/student_user.dart';

import 'package:intl/intl.dart'; // Import the intl package

class ShowProjectStudentWidget extends StatelessWidget {
  final List<StudentUser> projectList;

  const ShowProjectStudentWidget({Key? key, required this.projectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projectList.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            ListTile(
              title: Text(projectList[index].projectsList[index].projectName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${DateFormat('dd-MM-yyyy').format(projectList[index].projectsList[index].timeStart)} - ${DateFormat('dd-MM-yyyy').format(projectList[index].projectsList[index].timeEnd)}, \nDuration: ${(projectList[index].duration.inHours / 24).round()} days'),              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black),
                    onPressed: () {
                      // Handle edit button press
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Handle delete button press
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(projectList[index].projectsList[index].projectDescription)
              ),
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
                    children: projectList[index].projectsList[index].skillsListProject.map((skill) => Chip(label: Text(skill))).toList(),
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