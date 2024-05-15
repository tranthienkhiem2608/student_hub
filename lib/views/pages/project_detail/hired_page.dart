import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/models/not_use/student_registered.dart';
import 'package:student_hub/view_models/proposal_viewModel.dart';
import 'package:student_hub/views/profile_creation/student/proposal_profile.dart';
import 'package:student_hub/widgets/show_student_proposals_widget.dart';
import 'package:student_hub/widgets/theme/dark_mode.dart';

class HiredPage extends StatefulWidget {
  final ProjectCompany projectCompany;
  final User user;
  HiredPage({super.key, required this.projectCompany, required this.user});

  @override
  _HiredPageState createState() => _HiredPageState();
}

class _HiredPageState extends State<HiredPage> {
  List<Proposal>? proposalsItems;
  late Future<List<Proposal>> futureProposal;

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
          "noti2".tr(),
          style: GoogleFonts.poppins(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      visible: widget.projectCompany.proposals!.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      if (proposal.data![index].statusFlag == 3) {
                        return GestureDetector(
                          onTap: () {
                            Future<Proposal?> proposalStudent =
                                ProposalViewModel(context)
                                    .getProposalStudentById(
                                        proposal.data![index].id!);
                            proposalStudent.then((value) {
                              print(
                                  "Proposal: ${value!.studentUser!.skillSet}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProposalProfile(
                                    value.studentUser!,
                                    widget.user,
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? Color(0xFF2f2f2f) : Colors.white,
                              border: Border.all(
                                color: isDarkMode
                                    ? Color.fromARGB(255, 60, 60, 60)
                                    : Color.fromARGB(255, 228, 228, 233),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Color(0xFF212121)
                                      : Colors.grey.withOpacity(0.25),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ShowStudentProposalsWidget(
                              proposal: proposal.data![index],
                              user: widget.user,
                            ),
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
