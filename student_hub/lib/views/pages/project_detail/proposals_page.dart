import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/student_registered.dart';
import 'package:student_hub/widgets/show_student_proposals_widget.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class ProposalsPage extends StatefulWidget {
  final ProjectCompany projectCompany;
  final User user;
  ProposalsPage({super.key, required this.projectCompany, required this.user});

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
    bool isDarkMode = Provider.of<DarkModeProvider>(context).isDarkMode;
    return Visibility(
      replacement: Center(
        child: Text(
          "\t\tYou no have jobs",
          style: GoogleFonts.poppins(color: isDarkMode ? Colors.white : Colors.black,),
        ),
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
                      if (proposal.data![index].statusFlag != 3) {
                        return GestureDetector(
                          child: ShowStudentProposalsWidget(
                            proposal: proposal.data![index],
                            user: widget.user,
                          ),
                        );
                      }
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
