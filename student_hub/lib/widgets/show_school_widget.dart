import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/widgets/pop_up_education_widget.dart';
import 'package:student_hub/models/model/education.dart';

class ShowSchoolWidget extends StatelessWidget {
  final List<Education> educationList;
  final Function _deleteSchool;
  final Function _addNewEducation;

  const ShowSchoolWidget({
    super.key,
    required this.educationList,
    required Function deleteSchool,
    required Function addNewEducation,
  })  : _deleteSchool = deleteSchool,
        _addNewEducation = addNewEducation;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: educationList.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            ListTile(
              title: Text(educationList[index].schoolName!,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
              subtitle: Text(
                  ' ${educationList[index].startYear!} - ${educationList[index].endYear!}',
                  style: GoogleFonts.poppins(fontSize: 13)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                
                children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/edit.jpg', // Đường dẫn đến hình ảnh edit.jpg
                      width: 21, // Kích thước của hình ảnh
                      height: 21,
                    ),
                    onPressed: () {
                      // Handle edit button press
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopUpEducationEditWidget(
                            _addNewEducation,
                            _deleteSchool,
                            educationList[index].schoolName!,
                            educationList[index].startYear!,
                            educationList[index].endYear!,
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/icons/delete.jpg', // Đường dẫn đến hình ảnh edit.jpg
                      width: 21, // Kích thước của hình ảnh
                      height: 21,
                    ),
                    onPressed: () {
                      _deleteSchool(educationList[index].schoolName!);
                      // Handle delete button press
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 190, 190, 192),
              thickness: 0.8,
            ),
          ],
        );
      },
    );
  }
}
