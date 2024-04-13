import 'package:flutter/material.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/student_registered.dart';
import 'package:student_hub/widgets/show_student_proposals_widget.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';

class ProposalsPage extends StatefulWidget {
  final ProjectCompany projectCompany;

  ProposalsPage({super.key, required this.projectCompany});

  @override
  _ProposalsPageState createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  List<Proposal>? proposalsItems;
  late Future<List<Proposal>> futureProposal;

  void _hireStudent(StudentRegistered student) {
    setState(() {
      // widget.hiredStudents.add(student);
      // widget.studentRegistered.remove(student);
    });
  }

  @override
  void initState() {
    super.initState();
    // companyId = widget.user!.companyUser!.id!;
    setState(() {
      // Update your state here
      futureProposal = fetchDataProposalStudent();
    });
    //print projectList;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'Truong Le',
      'Hung Tran',
      'Quan Nguyen'
    ];
    final List<int> listTime = <int>[1, 2, 4];
    final List<String> listTechStack = <String>[
      'Frontend engineer',
      'Backend engineer',
      'Fullstack'
    ];
    final List<String> listLevel = <String>['Excellent', 'Good', 'Good'];
    final List<String> listDescription = <String>[
      'I am a student at HCMUT',
      'I am a student at HCMUT',
      'I am a student at HCMUT'
    ];
    final List<String> listStatus = <String>[
      'Hire',
      'Send hire offer',
      'Send hire offer'
    ];
    return Visibility(
      replacement: const Center(
        child: Text("\t\tYou no have jobs"),
      ),
      visible: widget.projectCompany.proposals!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Divider(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Expanded(
            child: FutureBuilder<List<Proposal>>(
              future: futureProposal = fetchDataProposalStudent(),
              builder: (context, proposal) {
                if (proposal.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (proposal.hasError) {
                  return Text('Error: ${proposal.error}');
                } else {
                  return ListView.builder(
                    itemCount: proposal.data!.length,
                    itemBuilder: (context, index) {
                      print(proposal.data![index].id);
                      print(proposal.data![index].coverLetter);

                      return GestureDetector(
                        child: ShowStudentProposalsWidget(
                          proposal: proposal.data![index],
                          hireStudent: _hireStudent,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<List<Proposal>> fetchDataProposalStudent() async {
    // lấy dữ liệu từ server
    if (widget.projectCompany != null && widget.projectCompany.id != null) {
      return await ProposalViewModel(context)
          .getProposalByProject(widget.projectCompany.id!);
    }
    return [];
  }
}
