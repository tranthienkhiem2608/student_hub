// show_school_widget.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/student_user.dart';
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
      itemCount: userStudent.experience?.length,
      itemBuilder: (ctx, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(244, 212, 221, 253),
              width: 2, // Màu và độ dày của border
            ),
            borderRadius: BorderRadius.circular(10.0), // Độ cong của border
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  userStudent.experience![index].title!,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF406AFF),
                    fontSize: 18, // Đổi màu của văn bản thành màu xanh
                  ),
                ),
                // Các phần khác của ListTile
                subtitle: Text(
                  '${DateFormat('MM-yyyy').format(userStudent.experience![index].startMonth!)} - ${DateFormat('MM-yyyy').format(userStudent.experience![index].endMonth!)}, \nDuration: ${(userStudent.experience![index].duration)} days',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    fontSize: 12, // Đổi chữ thành dạng italic
                  ),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/edit.jpg',
                        width: 21,
                        height: 21,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUpProjectWidget(
                              _addNewProject,
                              _deleteProject,
                              userStudent.experience![index].title!,
                              userStudent.experience![index].startMonth!,
                              userStudent.experience![index].endMonth!,
                              userStudent.experience![index].description!,
                              userStudent.experience![index].skillSet!,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(width: 0),
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/delete.jpg',
                        width: 21,
                        height: 21,
                      ),
                      onPressed: () {
                        _deleteProject(userStudent.experience![index].title);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userStudent.experience![index].description!,
                    style: GoogleFonts.poppins(
                      color: Color(0xFF777B8A),
                      fontSize: 14 // Màu sắc của văn bản
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Skills',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: userStudent.experience![index].skillSet!
                        .map((skill) => Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Chip(
                                label: Text(
                                  skill.name!,
                                  style: TextStyle(
                                    color: Color(0xFF406AFF),
                                  ),
                                ),
                                backgroundColor: Color(0xFF4DBE3FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Bo viền của Chip
                                  side: BorderSide(
                                    color: Color(0xFF4DBE3FF), // Màu của border
                                    width: 1, // Độ dày của border
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
