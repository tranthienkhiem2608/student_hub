// show_school_widget.dart
import 'package:flutter/material.dart';
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
              title: Text(educationList[index].schoolName!),
              subtitle: Text(
                  '${educationList[index].startYear!} - ${educationList[index].endYear!}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black),
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
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteSchool(educationList[index].schoolName!);
                      // Handle delete button press
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
          ],
        );
      },
    );
  }
}
