// show_school_widget.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/student_user.dart';
import 'package:student_hub/widgets/pop_up_project_widget.dart';

import 'package:intl/intl.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart'; // Import the intl package

class ShowProjectStudentPropasalWidget extends StatelessWidget {
  final StudentUser userStudent;
  final Function _deleteProject;
  final Function _addNewProject;
  final bool? isEditing;

  const ShowProjectStudentPropasalWidget({
    Key? key,
    required this.userStudent,
    required Function deleteProject,
    required Function addNewProject,
    required this.isEditing,
  })  : _deleteProject = deleteProject,
        _addNewProject = addNewProject;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return ListView.builder(
      itemCount: userStudent.experience?.length,
      itemBuilder: (ctx, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0),
          padding: const EdgeInsets.fromLTRB(3, 3, 0, 3),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(244, 212, 221, 253),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10.0),
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
                    fontSize: 18,
                  ),
                ),
                // Các phần khác của ListTile
                subtitle: Text(
                  '${DateFormat('MM-yyyy').format(userStudent.experience![index].startMonth!)} - ${DateFormat('MM-yyyy').format(userStudent.experience![index].endMonth!)}, \nDuration: ${userStudent.experience![index].endMonth!.difference(userStudent.experience![index].startMonth!).inDays} ${'time9'.tr()}',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: isDarkMode
                        ? const Color.fromARGB(255, 214, 214, 214)
                        : Colors.black,
                  ),
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: isEditing!, // Hiển thị khi isEditing là true
                      child: IconButton(
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
                    ),
                    Visibility(
                      visible: isEditing!, // Hiển thị khi isEditing là true
                      child: IconButton(
                        icon: Image.asset(
                          'assets/icons/delete.jpg',
                          width: 21,
                          height: 21,
                        ),
                        onPressed: () {
                          _deleteProject(userStudent.experience![index].title);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userStudent.experience![index].description!,
                    style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white : Color(0xFF777B8A),
                        fontSize: 14 // Màu sắc của văn bản
                        ),
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
