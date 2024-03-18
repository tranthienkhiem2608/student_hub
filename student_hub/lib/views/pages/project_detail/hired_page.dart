import 'package:flutter/material.dart';
import 'package:student_hub/models/student_registered.dart';
class HiredPage extends StatelessWidget {
  final List<StudentRegistered>? hiredStudents;

  const HiredPage({this.hiredStudents});
  @override
  Widget build(BuildContext context) {
    // Display the hired students
    return Visibility(
      replacement: const Center(
        child: Text("\t\tYou no have student hired yet!"),
      ),
      visible: hiredStudents != null && hiredStudents!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Divider(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Expanded(
            child: ListView.separated(
              itemCount: hiredStudents?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the student's profile
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_img.png',
                            width: 80,
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hiredStudents![index].student.user.fullName),
                                Text(hiredStudents![index].student.techStack),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(hiredStudents![index].student.techStack),
                            Text(hiredStudents![index].student.techStack),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            hiredStudents![index].introductionStudent,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ]),
      ),
    );
  }
}