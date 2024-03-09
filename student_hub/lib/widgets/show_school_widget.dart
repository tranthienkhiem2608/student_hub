// show_school_widget.dart
import 'package:flutter/material.dart';

class ShowSchoolWidget extends StatelessWidget {
  final List<Map<String, dynamic>> educationList;

  const ShowSchoolWidget({super.key, required this.educationList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: educationList.length,
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            ListTile(
              title: Text(educationList[index]['schoolName']),
              subtitle: Text('${educationList[index]['yearsStart']} - ${educationList[index]['yearsEnd']}'),
              trailing: Row(
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