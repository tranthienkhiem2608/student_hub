import 'package:flutter/material.dart';

import '../../../widgets/show_student_proposals_widget.dart';

class ProposalsPage extends StatelessWidget {
  const ProposalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Truong Le','Hung Tran','Quan Nguyen'];
    final List<int> listTime = <int>[1, 2, 4];
    final List<String> listTechStack = <String>['Frontend engineer', 'Backend engineer', 'Fullstack'];
    final List<String> listLevel = <String>['Excellent', 'Good', 'Good'];
    final List<String> listDescription = <String>['I am a student at HCMUT', 'I am a student at HCMUT', 'I am a student at HCMUT'];
    final List<String> listStatus = <String>['Hire', 'Send hire offer', 'Send hire offer'];
    return Visibility(
      replacement: const Center(
        child: Text("\t\tYou no have jobs"),
      ),
      visible: entries.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Divider(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Expanded(
            child:ListView.separated(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                String yearStudent;
                if (listTime[index] == 1) {
                  yearStudent = "1st year student";
                } else if (listTime[index] == 2) {
                  yearStudent = "2nd year student";
                } else {
                  yearStudent = "${listTime[index]}th year student";
                }
                return GestureDetector(
                  onTap: () {
                    // Handle your tap here.
                    // Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(
                    //     builder: (context) => HireStudentScreen()));
                    print('Item at index $index was tapped.');
                  },
                  child: ShowStudentProposalsWidget(
                    nameStudentProposals: entries[index],
                    yearStudent: yearStudent,
                    techStack: listTechStack[index],
                    levelStudent: listLevel[index],
                    description: listDescription[index],
                    status: listStatus[index],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ]),
      ),
    );
  }
}